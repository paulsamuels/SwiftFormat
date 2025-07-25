//
//  GitFileInfo.swift
//  SwiftFormat
//
//  Created by Hampus Tågerud on 2023-08-08.
//  Copyright 2023 Nick Lockwood and the SwiftFormat project authors
//
//  Distributed under the permissive MIT license
//  Get the latest version from here:
//
//  https://github.com/nicklockwood/SwiftFormat
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

import Foundation

struct GitFileInfo {
    var authorName: String?
    var authorEmail: String?
    var creationDate: Date?
}

extension GitFileInfo {
    init?(url: URL) {
        guard let gitRoot = getGitRoot(url.deletingLastPathComponent()) else {
            return nil
        }

        let commitHash = getCommitHash(url, root: gitRoot)
        guard let gitInfo = getCommitInfo((commitHash, gitRoot)) else {
            return nil
        }

        self = gitInfo
    }

    var author: String? {
        if let authorName {
            if let authorEmail {
                return "\(authorName) <\(authorEmail)>"
            }
            return authorName
        }
        return authorEmail
    }
}

private extension String {
    func shellOutput(cwd: URL? = nil) -> String? {
        #if os(macOS) || os(Linux) || os(Windows)
            let process = Process()
            let pipe = Pipe()

            process.executableURL = URL(fileURLWithPath: "/bin/bash")
            process.arguments = ["-c", self]
            process.standardOutput = pipe
            process.standardError = pipe

            if let safeCWD = cwd {
                process.currentDirectoryURL = safeCWD
            }

            let file = pipe.fileHandleForReading

            do { try process.run() }
            catch { return nil }

            process.waitUntilExit()

            guard process.terminationStatus == 0 else {
                return nil
            }

            let outputData = file.readDataToEndOfFile()
            return String(data: outputData, encoding: .utf8)?
                .trimmingCharacters(in: .whitespacesAndNewlines)
        #else
            return nil
        #endif
    }
}

private let getGitRoot: (URL) -> URL? = memoize({ $0.relativePath }) { url in
    let dir = "git rev-parse --show-toplevel".shellOutput(cwd: url)

    guard let root = dir, FileManager.default.fileExists(atPath: root) else {
        return nil
    }

    return URL(fileURLWithPath: root, isDirectory: true)
}

// If a file has never been committed, default to the local git user for the repository
private let getDefaultGitInfo: (URL) -> GitFileInfo = memoize({ $0.relativePath }) { url in
    let name = "git config user.name".shellOutput(cwd: url)
    let email = "git config user.email".shellOutput(cwd: url)

    return GitFileInfo(authorName: name, authorEmail: email)
}

private let getMovedFiles: (URL) -> [(from: URL, to: URL)] = memoize({ $0.relativePath }) { root in
    let command = "git diff --diff-filter=R --staged --name-status"
    let output = command.shellOutput(cwd: root)

    guard let safeValue = output, !safeValue.isEmpty else { return [] }

    return safeValue.split(separator: "\n").compactMap { input -> (URL, URL)? in
        var parts = input.split(separator: "\t").dropFirst()

        guard let from = parts.popFirst(), let to = parts.popFirst(), from != to else { return nil }

        let fromURL = URL(fileURLWithPath: String(from), relativeTo: root)
        let toURL = URL(fileURLWithPath: String(to), relativeTo: root)

        return (fromURL, toURL)
    }
}

private func getCommitHash(_ url: URL, root: URL) -> String? {
    let movedFile = getMovedFiles(root).first { $0.to.absoluteString == url.absoluteString }
    let trackedFile = movedFile?.from ?? url

    let command = [
        "git log",
        "--follow", // keep tracking file across renames
        "--diff-filter=A",
        "--author-date-order",
        "--pretty=%H",
        "--",
        trackedFile.relativePath,
    ]
    .filter { ($0?.count ?? 0) > 0 }
    .joined(separator: " ")

    let output = command.shellOutput(cwd: root)

    guard let safeValue = output, !safeValue.isEmpty else { return nil }

    if safeValue.contains("\n") {
        let parts = safeValue.split(separator: "\n")

        if parts.count > 1, let first = parts.first {
            return String(first)
        }
    }

    return safeValue
}

private let getCommitInfo: ((String?, URL)) -> GitFileInfo? = memoize(
    { hash, root in (hash ?? "none") + root.relativePath },
    { hash, root in
        let defaultInfo = getDefaultGitInfo(root)

        guard let hash else {
            return GitFileInfo(authorName: defaultInfo.authorName,
                               authorEmail: defaultInfo.authorEmail)
        }

        let format = #"{"name":"%an","email":"%ae","time":"%at"}"#
        let command = "git show --format='\(format)' -s \(hash)"
        guard let commitInfo = command.shellOutput(cwd: root),
              let commitData = commitInfo.data(using: .utf8),
              let dict = try? JSONDecoder().decode([String: String].self, from: commitData)
        else {
            return nil
        }

        let (name, email) = (
            dict["name"] ?? defaultInfo.authorName,
            dict["email"] ?? defaultInfo.authorEmail
        )

        var date: Date?
        if let createdAtString = dict["time"],
           let interval = TimeInterval(createdAtString)
        {
            date = Date(timeIntervalSince1970: interval)
        }

        return GitFileInfo(authorName: name,
                           authorEmail: email,
                           creationDate: date)
    }
)

private func memoize<K, T>(_ keyFn: @escaping (K) -> String?,
                           _ workFn: @escaping (K) -> T) -> (K) -> T
{
    let lock = NSLock()
    var cache: [String: T] = [:]

    return { input in
        let key = keyFn(input) ?? "@nil"

        lock.lock()
        defer { lock.unlock() }

        if let value = cache[key] {
            return value
        }

        let newValue = workFn(input)
        cache[key] = newValue

        return newValue
    }
}
