//
//  ArgumentsTests.swift
//  SwiftFormat
//
//  Created by Nick Lockwood on 07/08/2018.
//  Copyright © 2018 Nick Lockwood.
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

import XCTest
@testable import SwiftFormat

class ArgumentsTests: XCTestCase {
    // MARK: arg parser

    func testParseSimpleArguments() {
        let input = "hello world"
        let output = ["", "hello", "world"]
        XCTAssertEqual(parseArguments(input), output)
    }

    func testParseEscapedSpace() {
        let input = "hello\\ world"
        let output = ["", "hello world"]
        XCTAssertEqual(parseArguments(input), output)
    }

    func testParseEscapedN() {
        let input = "hello\\nworld"
        let output = ["", "hellonworld"]
        XCTAssertEqual(parseArguments(input), output)
    }

    func testParseQuoteArguments() {
        let input = "\"hello world\""
        let output = ["", "hello world"]
        XCTAssertEqual(parseArguments(input), output)
    }

    func testParseEscapedQuote() {
        let input = "hello \\\"world\\\""
        let output = ["", "hello", "\"world\""]
        XCTAssertEqual(parseArguments(input), output)
    }

    func testParseEscapedQuoteInString() {
        let input = "\"hello \\\"world\\\"\""
        let output = ["", "hello \"world\""]
        XCTAssertEqual(parseArguments(input), output)
    }

    func testParseQuotedEscapedN() {
        let input = "\"hello\\nworld\""
        let output = ["", "hello\\nworld"]
        XCTAssertEqual(parseArguments(input), output)
    }

    func testCommentedLine() {
        let input = "#hello"
        let output = [""]
        XCTAssertEqual(parseArguments(input, ignoreComments: false), output)
    }

    func testCommentInLine() {
        let input = "hello#world"
        let output = ["", "hello"]
        XCTAssertEqual(parseArguments(input, ignoreComments: false), output)
    }

    func testCommentAfterSpace() {
        let input = "hello #world"
        let output = ["", "hello"]
        XCTAssertEqual(parseArguments(input, ignoreComments: false), output)
    }

    func testCommentBeforeSpace() {
        let input = "hello# world"
        let output = ["", "hello"]
        XCTAssertEqual(parseArguments(input, ignoreComments: false), output)
    }

    func testCommentContainingSpace() {
        let input = "hello #wide world"
        let output = ["", "hello"]
        XCTAssertEqual(parseArguments(input, ignoreComments: false), output)
    }

    func testEscapedComment() {
        let input = "hello \\#world"
        let output = ["", "hello", "#world"]
        XCTAssertEqual(parseArguments(input, ignoreComments: false), output)
    }

    func testQuotedComment() {
        let input = "hello \"#world\""
        let output = ["", "hello", "#world"]
        XCTAssertEqual(parseArguments(input, ignoreComments: false), output)
    }

    func testQuotedURLMacro() {
        let input = "--url-macro \"#URL,URLFoundation\""
        let output = ["", "--url-macro", "#URL,URLFoundation"]
        XCTAssertEqual(parseArguments(input, ignoreComments: false), output)
    }

    func testLegacyOptionsWithLegacyOptionNames() throws {
        let testCases: [(legacy: String, current: String)] = [
            ("lineaftermarks", "line-after-marks"),
            ("indentcase", "indent-case"),
            ("trailingcommas", "trailing-commas"),
            ("wrapArguments", "wrap-arguments"),
            ("hexliteralcase", "hex-literal-case"),
            ("nospaceoperators", "no-space-operators"),
            ("modifierorder", "modifier-order"),
            ("extensionACL", "extension-acl"),
            ("propertyTypes", "property-types"),
            ("swiftVersion", "swift-version"),
        ]

        for (legacy, current) in testCases {
            do {
                let legacyArgs = try preprocessArguments(["", "--\(legacy)", "true"], commandLineArguments)
                let currentArgs = try preprocessArguments(["", "--\(current)", "true"], commandLineArguments)

                // Both should map to the same internal option name
                XCTAssertEqual(legacyArgs[current] ?? legacyArgs[legacy], currentArgs[current])
            } catch {
                XCTFail("Legacy option --\(legacy) should work but failed with: \(error)")
            }
        }
    }

    // MARK: arg preprocessor

    func testPreprocessArguments() {
        let input = ["", "foo", "bar", "-o", "baz", "-i", "4", "-l", "cr", "-s", "inline"]
        let output = ["0": "", "1": "foo", "2": "bar", "output": "baz", "indent": "4", "linebreaks": "cr", "semicolons": "inline"]
        XCTAssertEqual(try preprocessArguments(input, [
            "output",
            "indent",
            "linebreaks",
            "semicolons",
        ]), output)
    }

    func testPreprocessArgumentsNormalizesKeyCase() {
        let input = ["", "--Help", "-VERSION", "-foo", "BaR"]
        let output = ["0": "", "help": "", "version": "", "foo": "BaR"]
        XCTAssertEqual(try preprocessArguments(input, [
            "help",
            "version",
            "foo",
        ]), output)
    }

    func testEmptyArgsAreRecognized() {
        let input = ["", "--help", "--version"]
        let output = ["0": "", "help": "", "version": ""]
        XCTAssertEqual(try preprocessArguments(input, [
            "help",
            "version",
        ]), output)
    }

    func testInvalidArgumentThrows() {
        XCTAssertThrowsError(try preprocessArguments(["", "--vers"], [
            "verbose",
            "version",
        ])) { error in
            XCTAssertEqual("\(error)", "Unknown option --vers. Did you mean --version?")
        }
    }

    // merging

    func testDuplicateDisableArgumentsAreMerged() {
        let input = ["", "--disable", "foo", "--disable", "bar"]
        let output = ["0": "", "disable": "foo,bar"]
        XCTAssertEqual(try preprocessArguments(input, [
            "disable",
        ]), output)
    }

    func testDuplicateExcludeArgumentsAreMerged() {
        let input = ["", "--exclude", "foo", "--exclude", "bar"]
        let output = ["0": "", "exclude": "foo,bar"]
        XCTAssertEqual(try preprocessArguments(input, [
            "exclude",
        ]), output)
    }

    func testDuplicateUnexcludeArgumentsAreMerged() {
        let input = ["", "--unexclude", "foo", "--unexclude", "bar"]
        let output = ["0": "", "unexclude": "foo,bar"]
        XCTAssertEqual(try preprocessArguments(input, [
            "unexclude",
        ]), output)
    }

    func testDuplicateSelfrequiredArgumentsAreMerged() {
        let input = ["", "--self-required", "foo", "--self-required", "bar"]
        let output = ["0": "", "self-required": "foo,bar"]
        XCTAssertEqual(try preprocessArguments(input, [
            "self-required",
        ]), output)
    }

    func testDuplicateNoSpaceOperatorsArgumentsAreMerged() {
        let input = ["", "--nospaceoperators", "+", "--nospaceoperators", "*"]
        let output = ["0": "", "no-space-operators": "+,*"]
        XCTAssertEqual(try preprocessArguments(input, [
            "no-space-operators",
        ]), output)
    }

    func testDuplicateNoWrapOperatorsArgumentsAreMerged() {
        let input = ["", "--nowrapoperators", "+", "--nowrapoperators", "."]
        let output = ["0": "", "no-wrap-operators": "+,."]
        XCTAssertEqual(try preprocessArguments(input, [
            "no-wrap-operators",
        ]), output)
    }

    func testDuplicateRangesArgumentsAreNotMerged() {
        let input = ["", "--ranges", "spaced", "--ranges", "no-space"]
        let output = ["0": "", "ranges": "no-space"]
        XCTAssertEqual(try preprocessArguments(input, [
            "ranges",
        ]), output)
    }

    // comma-delimited values

    func testSpacesIgnoredInCommaDelimitedArguments() {
        let input = ["", "--rules", "foo,", "bar"]
        let output = ["0": "", "rules": "foo,bar"]
        XCTAssertEqual(try preprocessArguments(input, [
            "rules",
        ]), output)
    }

    func testNextArgumentNotIgnoredAfterCommaInArguments() {
        let input = ["", "--enable", "foo,", "--disable", "bar"]
        let output = ["0": "", "enable": "foo", "disable": "bar"]
        XCTAssertEqual(try preprocessArguments(input, [
            "enable",
            "disable",
        ]), output)
    }

    // flags

    func testVMatchesVerbose() {
        let input = ["", "-v"]
        let output = ["0": "", "verbose": ""]
        XCTAssertEqual(try preprocessArguments(input, commandLineArguments), output)
    }

    func testHMatchesHelp() {
        let input = ["", "-h"]
        let output = ["0": "", "help": ""]
        XCTAssertEqual(try preprocessArguments(input, commandLineArguments), output)
    }

    func testOMatchesOutput() {
        let input = ["", "-o"]
        let output = ["0": "", "output": ""]
        XCTAssertEqual(try preprocessArguments(input, commandLineArguments), output)
    }

    func testNoMatchFlagThrows() {
        let input = ["", "-v"]
        XCTAssertThrowsError(try preprocessArguments(input, [
            "help", "file",
        ]))
    }

    // MARK: format options to arguments

    func testCommandLineArgumentsHaveValidNames() {
        for key in argumentsFor(.default).keys {
            XCTAssertTrue(optionsArguments.contains(key), "\(key) is not a valid argument name")
        }
    }

    func testFormattingArgumentsAreAllImplemented() throws {
        CLI.print = { _, _ in }
        for key in formattingArguments {
            guard let value = argumentsFor(.default)[key] else {
                XCTAssert(deprecatedArguments.contains(key))
                continue
            }
            XCTAssert(!deprecatedArguments.contains(key), key)
            _ = try formatOptionsFor([key: value])
        }
    }

    func testEmptyFormatOptions() throws {
        XCTAssertNil(try formatOptionsFor([:]))
        XCTAssertNil(try formatOptionsFor(["--disable": "void"]))
    }

    func testFileHeaderOptionToArguments() throws {
        let options = FormatOptions(fileHeader: "//  Hello World\n//  Goodbye World")
        let args = argumentsFor(Options(formatOptions: options), excludingDefaults: true)
        XCTAssertEqual(args["header"], "//  Hello World\\n//  Goodbye World")
    }

    // TODO: should this go in OptionDescriptorTests instead?
    func testRenamedArgument() throws {
        XCTAssert(Descriptors.specifierOrder.isRenamed)
    }

    // MARK: config file parsing

    func testParseArgumentsContainingBlankLines() {
        let config = """
        --allman true

        --rules braces,fileHeader
        """
        let data = Data(config.utf8)
        do {
            let args = try parseConfigFile(data)
            XCTAssertEqual(args.count, 2)
        } catch {
            XCTFail("\(error)")
        }
    }

    func testParseArgumentsContainingAnonymousValues() throws {
        let config = """
        hello
        --allman true
        """
        let data = Data(config.utf8)
        XCTAssertThrowsError(try parseConfigFile(data)) { error in
            guard case let FormatError.options(message) = error else {
                XCTFail("\(error)")
                return
            }
            XCTAssert(message.contains("hello"))
        }
    }

    func testParseArgumentsContainingSpaces() throws {
        let config = "--rules braces, fileHeader, consecutiveSpaces"
        let data = Data(config.utf8)
        let args = try parseConfigFile(data)
        XCTAssertEqual(args.count, 1)
        XCTAssertEqual(args["rules"], "braces, fileHeader, consecutiveSpaces")
    }

    func testParseURLMacroArgumentInConfigFileFailsWithoutQuotes() throws {
        let config = "--url-macro #URL,URLFoundation"
        let data = Data(config.utf8)
        let args = try parseConfigFile(data)
        // This should fail because #URL,URLFoundation is treated as a comment
        XCTAssertEqual(args.count, 1)
        XCTAssertEqual(args["url-macro"], "")
    }

    func testParseURLMacroArgumentInConfigFileWithQuotes() throws {
        let config = "--url-macro \"#URL,URLFoundation\""
        let data = Data(config.utf8)
        let args = try parseConfigFile(data)
        XCTAssertEqual(args.count, 1)
        XCTAssertEqual(args["url-macro"], "#URL,URLFoundation")
    }

    func testParseArgumentsOnMultipleLines() throws {
        let config = """
        --rules braces, \\
                fileHeader, \\
                andOperator, typeSugar
        --allman true
        --hexgrouping   \\
                4,      \\
                8
        """
        let data = Data(config.utf8)
        let args = try parseConfigFile(data)
        XCTAssertEqual(args["rules"], "braces, fileHeader, andOperator, typeSugar")
        XCTAssertEqual(args["allman"], "true")
        XCTAssertEqual(args["hex-grouping"], "4, 8")
    }

    func testCommentsInConsecutiveLines() throws {
        let config = """
        --rules braces, \\
                # some comment
                fileHeader, \\
                # another comment invalidating this line separator \\
                # yet another comment
                andOperator
        --hexgrouping   \\
                4,      \\  # comment after line separator
                8           # comment invalidating this line separator \\
        """
        let data = Data(config.utf8)
        let args = try parseConfigFile(data)
        XCTAssertEqual(args["rules"], "braces, fileHeader, andOperator")
        XCTAssertEqual(args["hex-grouping"], "4, 8")
    }

    func testLineContinuationCharacterOnLastLine() throws {
        let config = """
        --rules braces,\\
                fileHeader\\
        """
        let data = Data(config.utf8)
        XCTAssertThrowsError(try parseConfigFile(data)) {
            XCTAssert($0.localizedDescription.contains("line continuation character"))
        }
    }

    func testParseArgumentsContainingEscapedCharacters() throws {
        let config = "--header hello\\ world\\ngoodbye\\ world"
        let data = Data(config.utf8)
        let args = try parseConfigFile(data)
        XCTAssertEqual(args.count, 1)
        XCTAssertEqual(args["header"], "hello world\\ngoodbye world")
    }

    func testParseArgumentsContainingQuotedCharacters() throws {
        let config = """
        --header "hello world\\ngoodbye world"
        """
        let data = Data(config.utf8)
        let args = try parseConfigFile(data)
        XCTAssertEqual(args.count, 1)
        XCTAssertEqual(args["header"], "hello world\\ngoodbye world")
    }

    func testParseIgnoreFileHeader() throws {
        let config = "--header ignore"
        let data = Data(config.utf8)
        let args = try parseConfigFile(data)
        let options = try Options(args, in: "/")
        XCTAssertEqual(options.formatOptions?.fileHeader, .ignore)
    }

    func testParseUppercaseIgnoreFileHeader() throws {
        let config = "--header IGNORE"
        let data = Data(config.utf8)
        let args = try parseConfigFile(data)
        let options = try Options(args, in: "/")
        XCTAssertEqual(options.formatOptions?.fileHeader, .ignore)
    }

    func testParseArgumentsContainingSwiftVersion() throws {
        let config = "--swiftversion 5.1"
        let data = Data(config.utf8)
        let args = try parseConfigFile(data)
        XCTAssertEqual(args.count, 1)
        XCTAssertEqual(args["swift-version"], "5.1")
    }

    func testParseArgumentsContainingLanguageVersion() throws {
        let config = "--languagemode 6"
        let data = Data(config.utf8)
        let args = try parseConfigFile(data)
        XCTAssertEqual(args.count, 1)
        XCTAssertEqual(args["language-mode"], "6")
    }

    func testParseArgumentsContainingDisableAll() throws {
        let config = "--disable all"
        let data = Data(config.utf8)
        let args = try parseConfigFile(data)
        let options = try Options(args, in: "/")
        XCTAssertEqual(options.rules, [])
    }

    func testPopulatesDefaultLanguageMode() throws {
        let swift5Options = FormatOptions(swiftVersion: "5.0")
        XCTAssertEqual(swift5Options.languageMode, "5")

        let swift6Options = FormatOptions(swiftVersion: "6.0")
        XCTAssertEqual(swift6Options.languageMode, "5")

        let swift6LangModeOptions = FormatOptions(swiftVersion: "6.0", languageMode: "6")
        XCTAssertEqual(swift6LangModeOptions.languageMode, "6")
    }

    // MARK: config file serialization

    // file header comment encoding

    func testSerializeFileHeaderContainingSpace() throws {
        let options = Options(formatOptions: FormatOptions(fileHeader: "// hello world"))
        let config = serialize(options: options, excludingDefaults: true)
        XCTAssertEqual(config, "--header \"// hello world\"")
    }

    func testSerializeFileHeaderContainingEscapedSpace() throws {
        let options = Options(formatOptions: FormatOptions(fileHeader: "// hello\\ world"))
        let config = serialize(options: options, excludingDefaults: true)
        XCTAssertEqual(config, "--header \"// hello\\ world\"")
    }

    func testSerializeFileHeaderContainingLinebreak() throws {
        let options = Options(formatOptions: FormatOptions(fileHeader: "//hello\nworld"))
        let config = serialize(options: options, excludingDefaults: true)
        XCTAssertEqual(config, "--header //hello\\nworld")
    }

    func testSerializeFileHeaderContainingLinebreakAndSpaces() throws {
        let options = Options(formatOptions: FormatOptions(fileHeader: "// hello\n// world"))
        let config = serialize(options: options, excludingDefaults: true)
        XCTAssertEqual(config, "--header \"// hello\\n// world\"")
    }

    func testSerializeOptionsWithPoundCharacter() throws {
        let options = Options(formatOptions: FormatOptions(
            urlMacro: .macro("#URL", module: "URLFoundation"),
            preferFileMacro: false
        ))
        let config = serialize(options: options, excludingDefaults: true)
        XCTAssertEqual(config, """
        --file-macro "#fileID"
        --url-macro "#URL,URLFoundation"
        """)
    }

    // trailing separator

    func testSerializeOptionsDisabledDefaultRulesEnabledIsEmpty() throws {
        let rules = defaultRules
        let config: String = serialize(options: Options(formatOptions: nil, rules: rules))
        XCTAssertEqual(config, "")
    }

    func testSerializeOptionsDisabledAllRulesEnabledNoTerminatingSeparator() throws {
        let rules = allRules
        let config: String = serialize(options: Options(formatOptions: nil, rules: rules))
        XCTAssertFalse(config.contains("--disable"))
        XCTAssertNotEqual(config.last, "\n")
    }

    func testSerializeOptionsDisabledSomeRulesDisabledNoTerminatingSeparator() throws {
        let rules = Set(defaultRules.prefix(3))
        let config: String = serialize(options: Options(formatOptions: nil, rules: rules))
        XCTAssertTrue(config.contains("--disable"))
        XCTAssertFalse(config.contains("--enable"))
        XCTAssertNotEqual(config.last, "\n")
    }

    func testSerializeOptionsEnabledDefaultRulesEnabledNoTerminatingSeparator() throws {
        let rules = defaultRules
        let config: String = serialize(options: Options(formatOptions: .default, rules: rules))
        XCTAssertNotEqual(config, "")
        XCTAssertFalse(config.contains("--disable"))
        XCTAssertFalse(config.contains("--enable"))
        XCTAssertNotEqual(config.last, "\n")
    }

    func testSerializeOptionsEnabledAllRulesEnabledNoTerminatingSeparator() throws {
        let rules = allRules
        let config: String = serialize(options: Options(formatOptions: .default, rules: rules))
        XCTAssertFalse(config.contains("--disable"))
        XCTAssertNotEqual(config.last, "\n")
    }

    func testSerializeOptionsEnabledSomeRulesDisabledNoTerminatingSeparator() throws {
        let rules = Set(defaultRules.prefix(3))
        let config: String = serialize(options: Options(formatOptions: .default, rules: rules))
        XCTAssertTrue(config.contains("--disable"))
        XCTAssertFalse(config.contains("--enable"))
        XCTAssertNotEqual(config.last, "\n")
    }

    // swift version

    func testSerializeSwiftVersion() throws {
        let version = Version(rawValue: "5.2") ?? "0"
        let options = Options(formatOptions: FormatOptions(swiftVersion: version))
        let config = serialize(options: options, excludingDefaults: true)
        XCTAssertEqual(config, "--swift-version 5.2")
    }

    // MARK: config file merging

    func testMergeFormatOptionArguments() throws {
        let args = ["allman": "false", "commas": "always"]
        let config = ["allman": "true", "binary-grouping": "4,8"]
        let result = try mergeArguments(args, into: config)
        for (key, value) in result {
            // args take precedence over config
            XCTAssertEqual(value, args[key] ?? config[key])
        }
        for key in Set(args.keys).union(config.keys) {
            // all keys should be present in result
            XCTAssertNotNil(result[key])
        }
    }

    func testMergeExcludedURLs() throws {
        let args = ["exclude": "foo,bar"]
        let config = ["exclude": "bar,baz"]
        let result = try mergeArguments(args, into: config)
        XCTAssertEqual(result["exclude"], "bar,baz,foo")
    }

    func testMergeUnexcludedURLs() throws {
        let args = ["unexclude": "foo,bar"]
        let config = ["unexclude": "bar,baz"]
        let result = try mergeArguments(args, into: config)
        XCTAssertEqual(result["unexclude"], "bar,baz,foo")
    }

    func testMergeRules() throws {
        let args = ["rules": "braces,fileHeader"]
        let config = ["rules": "consecutiveSpaces,braces"]
        let result = try mergeArguments(args, into: config)
        let rules = try parseRules(result["rules"]!)
        XCTAssertEqual(rules, ["braces", "fileHeader"])
    }

    func testMergeEmptyRules() throws {
        let args = ["rules": ""]
        let config = ["rules": "consecutiveSpaces,braces"]
        let result = try mergeArguments(args, into: config)
        let rules = try parseRules(result["rules"]!)
        XCTAssertEqual(Set(rules), Set(["braces", "consecutiveSpaces"]))
    }

    func testMergeEnableRules() throws {
        let args = ["enable": "braces,fileHeader"]
        let config = ["enable": "consecutiveSpaces,braces"]
        let result = try mergeArguments(args, into: config)
        let enabled = try parseRules(result["enable"]!)
        XCTAssertEqual(enabled, ["braces", "consecutiveSpaces", "fileHeader"])
    }

    func testMergeDisableRules() throws {
        let args = ["disable": "braces,fileHeader"]
        let config = ["disable": "consecutiveSpaces,braces"]
        let result = try mergeArguments(args, into: config)
        let disabled = try parseRules(result["disable"]!)
        XCTAssertEqual(disabled, ["braces", "consecutiveSpaces", "fileHeader"])
    }

    func testRulesArgumentOverridesAllConfigRules() throws {
        let args = ["rules": "braces,fileHeader"]
        let config = ["rules": "consecutiveSpaces", "disable": "braces", "enable": "redundantSelf"]
        let result = try mergeArguments(args, into: config)
        let disabled = try parseRules(result["rules"]!)
        XCTAssertEqual(disabled, ["braces", "fileHeader"])
        XCTAssertNil(result["enabled"])
        XCTAssertNil(result["disabled"])
    }

    func testEnabledArgumentOverridesConfigRules() throws {
        let args = ["enable": "braces"]
        let config = ["rules": "fileHeader", "disable": "consecutiveSpaces,braces"]
        let result = try mergeArguments(args, into: config)
        let rules = try parseRules(result["rules"]!)
        XCTAssertEqual(rules, ["fileHeader"])
        let enabled = try parseRules(result["enable"]!)
        XCTAssertEqual(enabled, ["braces"])
        let disabled = try parseRules(result["disable"]!)
        XCTAssertEqual(disabled, ["consecutiveSpaces"])
    }

    func testDisableArgumentOverridesConfigRules() throws {
        let args = ["disable": "braces"]
        let config = ["rules": "braces,fileHeader", "enable": "consecutiveSpaces,braces"]
        let result = try mergeArguments(args, into: config)
        let rules = try parseRules(result["rules"]!)
        XCTAssertEqual(rules, ["fileHeader"])
        let enabled = try parseRules(result["enable"]!)
        XCTAssertEqual(enabled, ["consecutiveSpaces"])
        let disabled = try parseRules(result["disable"]!)
        XCTAssertEqual(disabled, ["braces"])
    }

    func testMergeSelfRequiredOptions() throws {
        let args = ["self-required": "log,assert"]
        let config = ["self-required": "expect"]
        let result = try mergeArguments(args, into: config)
        let selfRequired = parseCommaDelimitedList(result["self-required"]!)
        XCTAssertEqual(selfRequired, ["log", "assert"])
    }

    func testMergeAcronyms() throws {
        let args = ["acronyms": "url"]
        let config = ["acronyms": "id,uuid"]
        let result = try mergeArguments(args, into: config)
        let acronyms = parseCommaDelimitedList(result["acronyms"]!)
        XCTAssertEqual(acronyms, ["url"])
    }

    // MARK: add arguments

    func testAddFormatArguments() throws {
        var options = Options(
            formatOptions: FormatOptions(indent: " ", allowInlineSemicolons: true)
        )
        try options.addArguments(["indent": "2", "linebreaks": "crlf"], in: "")
        guard let formatOptions = options.formatOptions else {
            XCTFail()
            return
        }
        XCTAssertEqual(formatOptions.indent, "  ")
        XCTAssertEqual(formatOptions.linebreak, "\r\n")
        XCTAssertTrue(formatOptions.allowInlineSemicolons)
    }

    func testAddArgumentsDoesntBreakSwiftVersion() throws {
        var options = Options(formatOptions: FormatOptions(swiftVersion: "4.2"))
        try options.addArguments(["indent": "2"], in: "")
        guard let formatOptions = options.formatOptions else {
            XCTFail()
            return
        }
        XCTAssertEqual(formatOptions.swiftVersion, "4.2")
    }

    func testAddArgumentsDoesntBreakFragment() throws {
        var options = Options(formatOptions: FormatOptions(fragment: true))
        try options.addArguments(["indent": "2"], in: "")
        guard let formatOptions = options.formatOptions else {
            XCTFail()
            return
        }
        XCTAssertTrue(formatOptions.fragment)
    }

    func testAddArgumentsDoesntBreakFileInfo() throws {
        let fileInfo = FileInfo(filePath: "~/Foo.swift", creationDate: Date())
        var options = Options(formatOptions: FormatOptions(fileInfo: fileInfo))
        try options.addArguments(["indent": "2"], in: "")
        guard let formatOptions = options.formatOptions else {
            XCTFail()
            return
        }
        XCTAssertEqual(formatOptions.fileInfo, fileInfo)
    }

    // MARK: options parsing

    func testParseEmptyOptions() throws {
        let options = try Options([:], in: "")
        XCTAssertNil(options.formatOptions)
        XCTAssertNil(options.fileOptions)
        XCTAssertEqual(options.rules, defaultRules)
    }

    func testParseExcludedURLsFileOption() throws {
        let options = try Options(["exclude": "foo bar, baz"], in: "/dir")
        let paths = options.fileOptions?.excludedGlobs.map(\.description) ?? []
        XCTAssertEqual(paths, ["/dir/foo bar", "/dir/baz"])
    }

    func testParseUnexcludedURLsFileOption() throws {
        let options = try Options(["unexclude": "foo bar, baz"], in: "/dir")
        let paths = options.fileOptions?.unexcludedGlobs.map(\.description) ?? []
        XCTAssertEqual(paths, ["/dir/foo bar", "/dir/baz"])
    }

    func testParseDeprecatedOption() throws {
        let options = try Options(["ranges": "nospace"], in: "")
        XCTAssertEqual(options.formatOptions?.spaceAroundRangeOperators, .remove)
    }

    func testParseNoSpaceOperatorsOption() throws {
        let options = try Options(["no-space-operators": "...,..<"], in: "")
        XCTAssertEqual(options.formatOptions?.noSpaceOperators, ["...", "..<"])
    }

    func testParseNoWrapOperatorsOption() throws {
        let options = try Options(["no-wrap-operators": ".,:,*"], in: "")
        XCTAssertEqual(options.formatOptions?.noWrapOperators, [".", ":", "*"])
    }

    func testParseModifierOrderOption() throws {
        let options = try Options(["modifier-order": "private(set),public,unowned"], in: "")
        XCTAssertEqual(options.formatOptions?.modifierOrder, ["private(set)", "public", "unowned"])
    }

    func testParseParameterizedModifierOrderOption() throws {
        let options = try Options(["modifier-order": "unowned(unsafe),unowned(safe)"], in: "")
        XCTAssertEqual(options.formatOptions?.modifierOrder, ["unowned(unsafe)", "unowned(safe)"])
    }

    func testParseInvalidModifierOrderOption() throws {
        XCTAssertThrowsError(try Options(["modifier-order": "unknowned"], in: "")) { error in
            XCTAssertEqual("\(error)", "'unknowned' is not a valid modifier (did you mean 'unowned'?) in --modifier-order")
        }
    }

    func testParseSpecifierOrderOption() throws {
        let options = try Options(["specifier-order": "private(set),public"], in: "")
        XCTAssertEqual(options.formatOptions?.modifierOrder, ["private(set)", "public"])
    }

    func testParseSwiftVersionOption() throws {
        let options = try Options(["swift-version": "4.2"], in: "")
        XCTAssertEqual(options.formatOptions?.swiftVersion, "4.2")
    }

    // MARK: parse rules

    func testParseRulesCaseInsensitive() throws {
        let rules = try parseRules("strongoutlets")
        XCTAssertEqual(rules, ["strongOutlets"])
    }

    func testParseAllRule() throws {
        let rules = try parseRules("all")
        XCTAssertEqual(rules, FormatRules.all.compactMap {
            $0.isDeprecated ? nil : $0.name
        })
    }

    func testParseInvalidRuleThrows() {
        XCTAssertThrowsError(try parseRules("strongOutlet")) { error in
            XCTAssertEqual("\(error)", "Unknown rule 'strongOutlet'. Did you mean 'strongOutlets'?")
        }
    }

    func testParseOptionAsRuleThrows() {
        XCTAssertThrowsError(try parseRules("import-grouping")) { error in
            XCTAssert("\(error)".contains("'sortImports'"))
        }
    }

    // MARK: lintonly

    func testLintonlyRulesContain() throws {
        let options = try Options(["lint": "", "lint-only": "wrapEnumCases"], in: "")
        XCTAssert(options.rules?.contains("wrapEnumCases") == true)
        let arguments = argumentsFor(options)
        XCTAssertEqual(arguments, ["lint": "", "enable": "wrapEnumCases"])
    }

    func testLintonlyRulesDontContain() throws {
        let options = try Options(["lint-only": "unusedArguments"], in: "")
        XCTAssert(options.rules?.contains("unusedArguments") == false)
        let arguments = argumentsFor(options)
        XCTAssertEqual(arguments, ["disable": "unusedArguments"])
    }

    func testLintonlyMergeOptionsAdd() throws {
        var options = try Options(["lint": "", "disable": "unusedArguments"], in: "")
        try options.addArguments(["lint-only": "unusedArguments"], in: "")
        XCTAssert(options.rules?.contains("unusedArguments") == true)
    }

    func testLintonlyMergeOptionsRemove() throws {
        var options = try Options(["enable": "wrapEnumCases"], in: "")
        try options.addArguments(["lint-only": "wrapEnumCases"], in: "")
        XCTAssert(options.rules?.contains("wrapEnumCases") == false)
    }

    // MARK: Edit distance

    func testEditDistance() {
        XCTAssertEqual("foo".editDistance(from: "fob"), 1)
        XCTAssertEqual("foo".editDistance(from: "boo"), 1)
        XCTAssertEqual("foo".editDistance(from: "bar"), 3)
        XCTAssertEqual("aba".editDistance(from: "bbb"), 2)
        XCTAssertEqual("foob".editDistance(from: "foo"), 1)
        XCTAssertEqual("foo".editDistance(from: "foob"), 1)
        XCTAssertEqual("foo".editDistance(from: "Foo"), 1)
        XCTAssertEqual("FOO".editDistance(from: "foo"), 3)
    }

    func testEditDistanceWithEmptyStrings() {
        XCTAssertEqual("foo".editDistance(from: ""), 3)
        XCTAssertEqual("".editDistance(from: "foo"), 3)
        XCTAssertEqual("".editDistance(from: ""), 0)
    }

    // MARK: Warnings

    func testDeprecatedRuleWarning() {
        let warnings = warningsForArguments(["rules": "specifiers"])
        XCTAssertEqual(warnings.count, 1)
        XCTAssert((warnings.first ?? "").contains("rule is deprecated"))
    }

    func testDeprecatedOptionWarning() {
        let warnings = warningsForArguments(["insert-lines": "enabled"])
        XCTAssertEqual(warnings.count, 1)
        XCTAssert((warnings.first ?? "").contains("option is deprecated"))
    }

    func testUnusedOptionWarning() {
        let warnings = warningsForArguments([
            "disable": "sortImports",
            "import-grouping": "testable-bottom",
        ])
        XCTAssertEqual(warnings.count, 1)
        XCTAssert((warnings.first ?? "").contains("option has no effect"))
    }

    func testLintOnlyRuleDoesntTriggerUnusedOptionWarning() {
        let warnings = warningsForArguments([
            "lintonly": "sortImports",
            "import-grouping": "testable-bottom",
        ])
        XCTAssertEqual(warnings, [])
    }

    func testLintOnlyRuleDoesntTriggerUnusedOptionWarning2() throws {
        let options = try Options([
            "lint-only": "sortImports",
            "import-grouping": "testable-bottom",
        ], in: "")
        let arguments = argumentsFor(options, excludingDefaults: true)

        // This is a bug / known issue - since --lintonly rules aren't tracked through
        // conversion to Options, resulting in a false positive for 'option has no effect'
        let warnings = warningsForArguments(arguments)
        XCTAssertEqual(warnings.count, 1)
        XCTAssert((warnings.first ?? "").contains("option has no effect"))

        // This is the solution to the aforementioned bug
        XCTAssertEqual(warningsForArguments(arguments, ignoreUnusedOptions: true), [])
    }
}
