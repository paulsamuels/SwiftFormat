# Contributing to SwiftFormat

Are you interested in contributing to SwiftFormat? Fantastic!

Here's what you need to know:

## Code of Conduct

There will be zero tolerance for rudeness or bullying. If you think somebody else's comment or pull request is stupid, keep it to yourself. If you are frustrated because your issue or pull request isn't getting the attention it deserves, feel free to post a comment like "any update on this?", but remember that we are all busy, and other peoples' priorities don't necessarily match yours.

Abusive contributors will be blocked and/or reported, regardless of how valuable their code contributions may be.

## Branches and Versioning

SwiftFormat follows the principles of [Semantic Versioning](http://semver.org/spec/v2.0.0.html) (semver), however since SwiftFormat is still pre-1.0, the rules are a little less strict. In general, 0.0.x releases are for bug fixes and non-breaking changes, and 0.x.0 releases are for breaking changes.

Since SwiftFormat is an application as well as a framework, "breaking changes" refers to the behavior of the formatter as well as the API. The addition of new (enabled-by-default) rules, or changes to the behavior of an existing rule are considered to be breaking, even if they do not affect the framework API.

The SwiftFormat repository has 2 main branches:

* main - the currently shipping version
* develop - the upcoming version

Many projects use main for development, but users often check main for documentation or to download the executable app, so to avoid confusion the source and documentation on main should reflect the latest tagged version of SwiftFormat at all times.

## Your First Pull Request

Making your first pull request can be scary. If you have trouble with any of the contribution rules, **make a pull request anyway**. A PR is the start of a process not the end of it.

All types of PR are welcome, but please do read these guidelines carefully to avoid wasting your time and ours. If you are planning something big, or which might be controversial, it's a great idea to create an issue first to discuss it before writing a lot of code.

Types of PR:

* Documentation fixes - if you've found a typo, or incorrect comment, either in the README or a code comment, feel free to create a PR directly against the **main** branch.

* Minor code fixes - a typo in a method name or a trivial bug fix should be made against the **develop** branch.

* Major code changes - significant refactors or new functionality should usually be raised as an issue first to avoid wasted effort on a PR that's unlikely to land. This is mainly for your own sake, not ours, so if you prefer to make suggestions in code form then that's fine too. As with fixes, PRs should be made against the **develop** branch.

## Copyright and Licensing

Any new source files that you add should include the standard license header used in all the existing files. You may include your own name as the author for files that you created or replaced.

By contributing code to SwiftFormat, you are implicitly agreeing to license it under the terms described in the LICENSE.md file. Please do not submit code that you did not write or are not authorized to redistribute.

Inclusion of 3rd party frameworks is **not** permitted, regardless of the license. Small sections of code copied from somewhere else *may* be acceptable, provided that the terms of the original license are compatible with SwiftFormat's LICENSE.md, and that you include a comment linking back to the source.

## Code Style

SwiftFormat's source code mostly follows the [Ray Wenderlich Style Guide](https://github.com/raywenderlich/swift-style-guide) very closely with the following exception:

- Use the Xcode default of 4 spaces for indentation.

## Documentation

Code should be commented, but not excessively. In general, comments should follow the principle of *why, not what*, but it's acceptable to use "obvious" comments as headings to break up large blocks of code. Public methods and classes should be commented using the `///` headerdoc style.

When making user-facing changes, please update the README.md file if applicable. There is no need to update CHANGELOG.md or bump the version number.

## Tests

All significant code changes should be accompanied by a test.  

Tests are run automatically on all pull requests, branches and tags. These are the same tests that run in Xcode at development time.

There is a separate Performance Tests scheme that you should run manually if your code changes are likely to affect performance.

Test cases for individual rules can be ran via the command line using the `./Scripts/test_rule.sh` script. For example:

```sh
$ ./Scripts/test_rule.sh blankLinesAtStartOfScope
$ ./Scripts/test_rule.sh indent
$ ./Scripts/test_rule.sh wrap
```

## Tips

* Use existing helpers in `ParsingHelpers.swift` or `FormattingHelpers.swift` where possible. There are existing parsing helpers for many parts of the Swift grammar, like: 
  * Types (`parseType(at:)`) 
  * Declarations (`parseDeclarations()`)
  * Expressions (`parseExpressionRange(startingAt:)`)
  * Properties (`parsePropertyDeclaration(atIntroducerIndex:)`)
  * Functions (`parseFunctionDeclaration(keywordIndex:)`)
  
* Define helpers in extensions on `Formatter` at the bottom of the Rule file. These should be `internal` to improve discoverability. Helpers used by multiple rules should be moved to `ParsingHelpers`.
  * Before writing new parsing helpers, consider checking if any existing rule has parsing helpers that could be reused.

## Prerelease builds

If you contribute a new rule or option, it would be published in the following major version release. To start using the new rule or option right away in your own project, you could use a prerelease build of the `develop` branch. More information is available [here](https://github.com/nicklockwood/SwiftFormat#prerelease-builds).

## Renaming a Rule Option

* Add a copy of the option in `OptionDescriptor.swift` under the `// MARK: - RENAMED` section
* Add `.renamed(to: "newPropertyName")` to the renamed copy of the option
* Rename the `propertyName` of the original option property to the new name

## Release Process


This is relevant only to maintainers:

Run `./Scripts/prepare_release.sh VERSION_NUMBER`. This script:

* Updates version number in SwiftFormat.swift + 3 targets
* Updates SwiftFormat.podspec.json
* Creates a placeholder entry in CHANGELOG.md
* Run tests and ensure they pass
* Archives SwiftFormat (Command Line Tool)
* Replaced binary in CommandLineTool directory

Then complete the following steps manually:

* Fill out the CHANGELOG.md entry
* Tag commit and push to main
* Publish a new release
  * All binaries are built and uploaded to the release automatically
* pod trunk push --allow-warnings

Finally, these steps require App Store Connect access, so only Nick can do them:

* Select SwiftFormat for Xcode and run Product > Archive
* Notarize and export built app
