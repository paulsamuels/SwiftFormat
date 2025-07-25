# Change Log

## [0.57.2](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.57.2) (2025-07-14)

- Updated `trailingCommas` rule to handle function declarations with generic arguments.
- Updated `--trailing-commas always` to preserve trailing commas rather than unnecessarily removing trailing commas in some edge cases.
- Fixed spurious deprecation message when using some non-deprecated options.

## [0.57.1](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.57.1) (2025-07-14)

- Fixed issue where trailing commas were unexpectedly removed from initializer argument lists when using `--trailing-commas always`.
- Fixed issue where `redundantPublic` rule didn't handle extensions on types defined in public extensions.
- Added `@Bindable` to list of SwiftUI property wrappers used by `organizeDeclarations` rule.
- Fixed case-sensitivity issue with `preferFileMacro` rule.

## [0.57.0](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.57.0) (2025-07-13)

- Options now use `--kebab-case`. Existing option names without dashes remain supported for backwards compatibility. Some options have been renamed to improve clarity.
- Added support for `:this` and `:previous` in comment directives.
- Added support for formatting code blocks in Markdown files.
- Added support for multiple `--config` file arguments.
- Added `singlePropertyPerLine` rule to convert property declarations defining multiple properties into separate declarations.
- Added `redundantMemberwiseInit` rule to remove explicit memberwise initializers that are identical to the `struct`'s compiler-synthesized initializer.  
- Added `redundantPublic` rule to remove public access control from properties of internal types.
- Added `modifiersOnSameLine` rule to keep declaration modifiers on the same line.
- Added `throwingTests` rule to prefer using `try` and `throws` in unit tests rather than `try!`.
- Added `noGuardInTests` rule to prefer convert guard statements in unit tests to `try #require(...)` / `#expect(...)` or `try XCTUnwrap(...)` / `XCTAssert(...)`.
- Added `urlMacro` rule to convert `URL(string: "...")!` initializers to a provided `#URL("...")` macro.
- Added `--trailing-commas collections-only` and `--trailing-commas multi-element-lists` options to `trailingCommas` rule.
- Added `--type-blank-lines insert` option to `blankLinesAtStartOfScope` and `blankLinesAtEndOfScope` rules.
- Added `--wrap-string-interpolation` option to support disabling line wrapping within string interpolation.
- Added `--line-between-guards` option to `blankLinesAfterGuardStatements` rule.
- Added support for SARIF output format.
- Improved performance of the `docComments` rule.
- Fixed bug in `docComments` rule where trailing comments would be converted to doc comments.
- Fixed bug where `redundantNilInit` rule would ignore type bodies with conformances.
- Fixed bug where `wrapEnumCases` didn't handle some nested types correctly.
- Fixed issue where `#` characters in config files couldn't be escaped.
- Fixed issue where SwiftFormat for Xcode app would generate invalid config files with unescaped `#` characters.
- Fixed issue where `--wrap-return-type never` didn't respect `--allman true`.

## [0.56.4](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.56.4) (2025-06-15)

- Fixed issue where `trailingCommas` rule would not insert trailing commas in function declarations with return type
- Fixed issue where `trailingCommas` rule would not insert trailing commas in array literals following `!` operator
- Fixed issue where `unusedArguments` rule would ignore function declarations with trailing commas
- Fixed issue where `void` rule would not handle `()` types in typealiases
- Fixed issue where `redundantLet` rule did not detect code inside result builders when nested in conditional compilation blocks

## [0.56.3](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.56.3) (2025-06-04)

- Fixed issue where `trailingCommas` rule would insert commas in closure types and tuple types used in typealaises (not supported in Swift 6.1)

## [0.56.2](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.56.2) (2025-05-27)

- Fixed issues where `trailingCommas` rule would insert commas in `@escpaing` or `@Sendable` closure types (not supported in Swift 6.1)
- Fixed issue where `privateStateVariables` rule handled `@Previewable` attributes on previous line incorrectly

## [0.56.1](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.56.1) (2025-05-13)

- Fixed several issues where `trailingCommas` rule would insert commas in places not actually supported by Swift 6.1
- Fixed issue where `--wrapeffects` option would incorrectly unwrap `async let` properties following function call
- Fixed issue where `redundantEquatable` rule would incorrectly remove `==` implementation in factor of synthesized implementation even if type contained non-Equatable properies like tuples
- Fixed issue where `extensionAccessControl` rule would incorrectly hoist `public` ACL in `@preconcurrency` conformances
- Fixed issue where `organizeDeclarations` rule would sometimes break property declarations with if expression values

## [0.56.0](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.56.0) (2025-05-12)

- Added `wrapMultilineFunctionChains` rule to wrap chained method calls
- Added `environmentEntry` rule to update SwiftUI `EnvironmentValues` definitions to use the `@Entry` macro
- Added `redundantEquatable` rule to remove explicit `Equatable` conformances that would be compiler-synthesized
- Added `preferSwiftTesting` rule to migrate XCTest-based tests to Swift Testing
- Added `swiftTestingTestCaseNames` rule to remove redundant "test" prefix from Swift Testing test case methods.
- Added `preferCountWhere` rule to prefer `count(where:)` over `filter(_:).count`
- Added `fileMacro` rule to prefer either `#file` or `#fileID`, which have the same behavior in Swift 6 and later
- Added `blankLinesAfterGuardStatements` rule to remove blank lines between consecuitve guard statements, and add blank line after last guard statement.
- Added `privateStateVariables` rule to add `private` access control to `@State` properties
- Added `emptyExtensions` rule to remove extensions that contain no declarations or conformances
- Added `--preserveacronyms` option to `acronyms` rule
- Added `--wrapreturntype never` option to `wrapArguments` rule
- Updated `trailingCommas` to support Swift 6.1 trailing comma functionality
- `opaqueGenericParameters` now supports protocol requirements without a body
- `--wrapeffects` and `--wrapreturntype` now support protocol requirements and closure types
- Fixed indentation of trailing closures after chained multiline method call when using same-line closing parens
- `blankLinesAtStartOfScope` rule now supports switch cases and closure capture / parameter lists
- Fixed issue where type under `organizeDeclarations` line count threshold would ignore `swiftformat:sort` directives
- Fixed issue where `organizeDeclarations` rule would unexpectedly remove non-mark comments
- Compiling SwiftFormat now requires Swift 5.7+
- SwiftFormat prerelease builds can now be installed via Homebrew using `brew install swiftformat --head`. Prerelease builds are subject to breaking changes.

## [0.55.6](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.55.6) (2025-04-29)

- Fixed parsing bugs related to parameter packs (`repeat`, `each` keywords)
- Fixed bug where `propertyTypes` rule could cause build failure in properties with `some` type
- Fixed bug where `--callsiteparen balanced` would have no effect when using `--closingparen same-line`
- Fatal error messages now include the name of the currently-running rule
- Docker build now uses Swift 6.0.3

## [0.55.5](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.55.5) (2025-01-20)

- Fixed bug with `yodaConditions` rule mangling generic function calls
- Fixed indenting of guard `else` or opening brace following `if`/`switch` expression
- The `organizeDeclarations` rule no longer treats properties with `didSet` as computed
- Improved formatting support for async and throwing closures

## [0.55.4](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.55.4) (2024-12-22)

- Fixed inconsistent indenting of wrapped `where` clause for `switch ... case` statements
- Fixed bug where `unusedArguments` could remove required arguments in some cases
- The `sortTypealiases` rule now correctly handles `any` keyword

## [0.55.3](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.55.3) (2024-11-26)

- Fixed bug where `sortTypealiases` rule could mangle generic types, or ones using the `any` keyword
- The `preferKeyPaths` rule now only uses `\\.self` for Swift 6 and later (fix din't land yet in 5.10)
- Added speculative fix for plugin `artifactbundle` not working on `ubuntu-latest`

## [0.55.2](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.55.2) (2024-11-24)

- Fixed bug where `unusedArguments` failed to remove arguments that matched switch variable bindings
- Fixed bug where `unusedArguments` failed to remove arguments that matched nested function call labels
- Fixed spurious lint errors for `blankLinesAtStartOfScope` when using `organizeDeclarations` rule
- Fixed bug where indentation errors were incorrectly reported as `wrap` rule lint errors
- The `preferKeyPaths` rule now handles the `\\.self` case for Swift 5.10 and later
- Fixed parsing of keyPaths beginning with `\.?`

## [0.55.1](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.55.1) (2024-11-20)

- Fixed bug where `docCommentsBeforeModifiers` got confused by `enum` cases that match modifier names
- Fixed bug where `wrapEnumCases` would mangle nested or successive `enum` declarations
- Artifact Bundle now includes pre-built binary for ARM-based Linux systems

## [0.55.0](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.55.0) (2024-11-16)

- Added `docCommentsBeforeModifiers` rule to hoist doc comments above declaration modifiers
- Added `unusedPrivateDeclarations` rule to remove unused `private` or `fileprivate` declarations
- Added `propertyTypes` rule to control the use of inferred or explicit types for properties
- Renamed the `--redundanttype` option to `--propertytypes` as it's shared by both rules
- Added `--ranges preserve` and `--operatorfunc preserve` options
- Added `--languagemode` option to specify if you are using Swift 5 or 6 language mode
- The `organizeDeclarations` rule can now sort declarations by name/type/visibility/etc
- Fixed `organizeDeclarations` bug where `--beforemarks` unexpectedly matched keywords in function bodies
- Fixed missing lint output for `organizeDeclarations` rule
- Fixed bug in `markTypes` rule for chained protocol extension names
- Renamed the confusing `--onelineforeach` option to `--inlinedforeach`
- Git info can now be used in header comments when formatting code from stdin
- You can now use the `--outputtokens` option to print output as tokens in JSON format
- Each rule and test is now defined in a separate file to make it easier to maintain/contribute
- Updated minimum Swift version for building SwiftFormat to 5.3 (you can still format older Swift code)
- Docker build now uses static Linux SDK

## [0.54.6](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.54.6) (2024-10-07)

- Fixed incorrect wrapping of conditional bodies inside single-line string literals
- Fixed properties inside type with where clause being treated as local scope
- Fixed regression in `wrapMultilineStatementBraces` rule
- Fixed tokenizing of a throwing closure type in a generics clause
- Fixed bug in `parseDeclarations` where incorrect tokens could cause rules to time out
- Fixed issue where `organizeDeclarations` would add extra blank lines if type had blank lines with spaces
- Updated SwiftFormat for Xcode installation instructions for macOS 15 Sequoia
- Added known issue to README for `preferForLoop` rule

## [0.54.5](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.54.5) (2024-09-11)

- Fixed crash in `unusedArguments` rule
- Fixed bug where `preferForLoop` failed if `forEach` contains `guard ... else { return }`

## [0.54.4](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.54.4) (2024-09-07)

- Fixed bug where trailing comma was erroneously inserted into a wrapped array type extension
- Fixed bug where `return` was incorrectly removed inside `catch` statement with `where` clause
- Fixed `opaqueGenericParameters` rule being incorrectly applied to functions with typed `throws`
- Fixed `spaceAroundBrackets` behaving incorrectly inside a macro invocation
- Fixed `unusedArguments` false positive inside multiline string literal
- Fixed a case where removing `return` resulted in non-compiling code for opaque return types
- Redundant `Void` return type is now removed from functions in protocol declarations
- Fixed a bug where `unusedArguments` didn't handle conditional assignment shadowing correctly
- Fixed Xcode 16 Beta warnings related to unhandled files when building SwiftFormat package
- The Swift runtime is now packaged with the installer on Windows as on Linux
- The Windows installer now uses a more conventional directory structure
- SwiftFormat for Windows now supports arm64

## [0.54.3](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.54.3) (2024-07-28)

- Fixed issue where `--wrapeffects never` could unexpectedly remove unrelated code
- Fixed `--condassignment` option (setting this previously had no effect)
- The `redundantReturn` rule no longer removes conditional `return`s if `conditionalAssignment` is disabled
- The `redundantObjc` rule now strips implicit `@objc` attribute for `@IBSegueAction` functions
- Fixed bug where violations for rules that insert new lines were sometimes ignored in lint output

## [0.54.2](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.54.2) (2024-07-22)

- Fixed broken formatter cache, which caused a significant performance regression since 0.54.0
- The `blankLinesBetweenChainedFunctions` rule now removes blank line after comments in the chain
- The `blankLinesBetweenChainedFunctions` rule no longer conflicts with `blankLinesAroundMark`
- Fixed`redundantInternal` removing required `internal` keyword in extensions with `where` clause
- Fixed another case of spurious `return` removal in conditional blocks
- Fixed `redundantNilInit` rule inserting `nil` after `as` keyword

## [0.54.1](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.54.1) (2024-07-10)

- The `--nilInit insert` option is no longer applied to lazy or attributed properties
- The `blankLinesBetweenChainedFunctions` rule now correctly handles comments in the chain
- Fixed indenting of wrapped arguments in `--fragment` mode
- Fixed bug where attributes were mistaken for an accessor in a computer property
- Fixed indenting of commented code after an opening bracket
- Fixed spurious removal of `return` in conditional blocks
- Fixed `--lint` mode reporter output when using `stdin`

## [0.54.0](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.54.0) (2024-06-11)

- Added `blankLineAfterSwitchCase` rule for inserting blank lines after switch cases
- Added `consistentSwitchCaseSpacing` rule for ensuring consistent spacing between switch cases
- Added `redundantProperty` rule for removing variable assignments where value is immediately returned
- Added `redundantTypedThrows` rule for stripping redundant `Never` or `any Error` `throws` types
- Setting `--report` without `--reporter` type now raises an error if type can't be inferred
- Added XML reporter for Checkstyle-compatible lint reporting (use the `--reporter xml` option)
- Added `--typedelimiter` option for controlling spacing around the colon in type definitions
- Added `--initcodernil` option for returning `nil` instead of asserting in unavailable `init?(coder:)`
- The `fileHeader` rule now uses git info for `created` date (if available) instead of file system
- Added git `author`, `author.name` and `author.email` tokens for file header templates
- Added `--callsiteparen` option for controlling closing paren placement at function call sites
- The `wrapAttributes` rule can now be applied differently to computed properties vs stored properties
- The `wrapAttributes` rule can now be applied differently to complex (parameterized) vs simple attributes
- Replaced `--varattributes` with `--storedvarattrs`, `--computedvarattrs` and `--complexattrs` options
- Added `—-nilinit`  option for controlling whether `redundantNilInit` adds or removes explicit `nil`
- Added ability to organize declarations by type over visibility (use `--organizationmode type`)
- Fixed bug where enabling `organizeDeclarations` for structs caused `sortDeclarations` to have no effect
- Fixed bug where if statement body could be incorrectly parsed as a trailing closure
- Improved attribute handling in `opaqueGenericParameters rule`
- SwiftFormat now recognizes `init` and `_modify` property accessors
- Fixed bug with `preferForLoop` rule and tuple argument matching
- Extended `conditionalAssignment` rule to handle more cases
- Added `--condassignment after-property` option
- Fixed await being hoisted outside of macro arguments
- Fixed unsafe adding/removal of `self` within macros
- Added `os_log` to `--selfrequired` defaults

## [0.53.10](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.53.10) (2024-05-18)

- Fixed creation of spurious `stdout` directory when using `--output stdout`
- Fixed `unusedArguments` false positive for multiline function call arguments
- Fixed parsing of generic arguments containing attributes or `~` operator
- Fixed spurious errors about missing `--report` or `--reporter` arguments
- Fixed `strongifiedSelf` removing required backticks around nonisolated `self`
- Deprecated explicit `default` value for `--reporter` (introduced in 0.53.9)
- Added support for `sending` keyword 

## [0.53.9](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.53.9) (2024-05-12)

- Fixed bug in `unusedArguments` when shadowing function argument with conditional assignment declaration
- Individual `--lint` errors are no longer shown in `--quiet` mode (restores pre-0.53.8 behavior)

## [0.53.8](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.53.8) (2024-04-22)

- Added `--strict` option to emit non-zero exit code after applying changes in formatting mode
- The `enumNamespaces` rule is no longer applied to structs with macros that have generic arguments
- The `opaqueGenericParameters` rule is no longer applied to structs with macros or attributes
- Fixed another case where `redundantParens` spuriously removed parens inside a closure
- Fixed bug where `redundantInit` mishandled a `.init` after a ternary operator 

## [0.53.7](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.53.7) (2024-04-14)

- Fixed bug with `redundantParens` where first parens inside a closure were spuriously removed
- Fixed `wrapEnumCases` rule mangling unindented cases
- The `wrapEnumCases` rule no longer wraps cases inside inline enum declarations
- Improved the `redundantInit` metatype heuristic to reduce false positives 

## [0.53.6](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.53.6) (2024-04-11)

- Fixed bug where a space was incorrectly added before a `.` operator inside attribute arguments
- The `redundantType` rule no longer strips required explicit type from `@Model` class default values
- Fixed issue where `redundantInit` didn't work on collection types
- The `redundantParens` rule now correctly handles `@MainActor` closures
- Fixed bug where required parens were removed around `each X` parameter pack expressions
- Fixed issue where `--wrapreturntype if-multiline` didn't work with arrays, dictionaries, tuples, or generic types
- The `spaceAroundParens/Brackets` rules now correctly insert a space after `borrowing`/`consuming` and `isolated`
- Fixed spurious line breaks inserted between scoped `import` statements
- Added `--doccomments preserve` option to preserve all doc comments, even if not followed by a declaration

## [0.53.5](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.53.5) (2024-03-17)

- Fixed bug with trailing comma being inserted into wrapped capture list
- Fixed bugs with parsing `nonisolated(unsafe)` modifiers
- Fixed bug with hoisting `try` or `async` after a string literal expression
- Fixed issue with parsing expressions containing generic arguments
- Lint warnings are now displayed as errors when not running in `--lenient` mode
- Improved error message for unexpected `static`/`class` modifiers
- Added Swift 6.0 to list of supported Swift versions

## [0.53.4](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.53.4) (2024-03-09)

- The `enumNamespaces` rule is no longer applied to structs with attributes or macros
- The new `nonisolated(unsafe)` modifier is now handled correctly
- Added support for `do throws(Type) { ... }` clauses

## [0.53.3](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.53.3) (2024-03-02)

- The `preferForLoop` rule now correctly singularizes loop conditions that end with "cases"
- Fixed bug where `preferForLoop` mangled throwing or async `forEach` expressions
- Fixed extension body not being sorted if `organizeDeclarations` was enabled but excluded declaration type
- Fixed conditionalAssignment bugs with `@unknown default` cases
- Fixed some unsafe applications of the `enumNamespaces` rule
- Added preliminary support for typed `throws`

## [0.53.2](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.53.2) (2024-02-17)

- Fixed bug where `hoistAwait` rule could move `await` before `try` keyword
- Fixed bug where `redundantSelf` rule was confused by `@MainActor` annotation
- Fixed edge case where `unusedArguments` removed required argument inside `guard`

## [0.53.1](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.53.1) (2024-01-26)

- Fixed bug where `fileHeader` could duplicate headers containing a colon
- The `redundantInternal` rule no longer strips `internal` from `import` statements
- Fixed false positive with `unusedArguments` rule

## [0.53.0](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.53.0) (2024-01-07)

- Added `preferForLoop` rule to convert `forEach { ... }` calls to regular `for` loops
- Added `wrapLoopBodies` rule to wrap single-line loop bodies over multiple lines
- Added `noExplicitOwnership` rule to remove unwanted `borrowing` and `consuming` modifiers
- Added `wrapMultilineConditionalAssignment` rule to wrap `if` or `switch` expressions to new line
- The `wrapAttributes` rule no longer unwraps attributes if they would exceed `--maxwidth`
- The `typeSugar` rule's `--shortoptionals` option now defaults to `except-properties`
- Enabled `blankLinesBetweenChainedFunctions` rule by default
- Enabled `blankLineAfterImports` rule by default
- Fixed `self` being incorrectly inserted before `set` clause in computed properties
- Fixed a bug in `parseType()` helper function where qualified types were not recognized
- Fixed Xcode command plugin

## [0.52.11](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.52.11) (2023-12-05)

- Updated `if`/`switch` expression workaround for Swift 5.9 bug to handle `as!` casts
- Fixed indent logic  for wrapped conditional assignment expressions
- Fixed assertion failure in `redundantSelf` rule
- Fixed raw string parsing bug

## [0.52.10](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.52.10) (2023-11-14)

- Fixed `enumNamespaces` rule breaking `import struct`/`class` statements
- Fixed unsafe application of `conditionalAssignment` rule to `switch` statements containing `#if` blocks

## [0.52.9](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.52.9) (2023-11-10)

- Fixed `redundantClosure` removing required closure around conditional statements
- Fixed `redundantClosure` removing closure containing conditional expressions inside a method call
- Fixed `redundantClosure` generating invalid code when the `redundantReturn` rule is disabled
- Fixed issue where if/switch expressions with `as?` cast would break build in Swift 5.9
- Fixed `blankLineAfterImports` introducing spurious blank line before `@preconcurrency` attribute
- Fixed bug where `enumNamespaces` rule wouldn't be applied immediately after an `import` statement
- Fixed issue where `switch` case with multiple `where` clauses could be parsed incorrectly
- The SwiftFormat SPM plugin now formats local dependencies, not just final product targets

## [0.52.8](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.52.8) (2023-10-17)

- Fixed `redundantClosure` rule in cases where an `if`/`switch` expression is not permitted
- The `docComments` rule now correctly handles macro comments
- The `docComments` rule is now only applied to a comment block if all lines match the pattern 

## [0.52.7](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.52.7) (2023-10-06)

- Fixed bug where `conditionalAssignment` and `redundantClosure` rules would be applied incorrectly
- Fixed `redundantClosure` rule leaving stray `try` or `await` keywords behind

## [0.52.6](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.52.6) (2023-10-01)

- Fixed bug where `redundantReturn` rule was incorrectly applied to consecutive `if` statements in Swift 5.9

## [0.52.5](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.52.5) (2023-09-30)

- Fixed bug where `redundantReturn` rule could break fallible initializers in Swift 5.9
- Fixed incorrect application of `docComments` rule inside `#if` statements
- The `docComments` rule no longer treats comments starting with `Note:` as a special directive
- Fixed incorrect indenting inside `#if` statements immediately preceded by a comment
- Removed arbitrary unwrap threshold for `braces` rule when no `--maxwidth` is specified
- You can now include operators in the `--asynccapturing` list

## [0.52.4](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.52.4) (2023-09-17)

- Fixed `docComments` rule incorrectly replacing comments inside switch cases and if/guard conditions
- Fixed `redundantLet` rule removing required `let` inside `ViewBuilder` modifiers
- Fixed `redundantLet` rule removing required `let` after `@MainActor` or `@Sendable`
- Fixed bug when using `--wrapconditions after-first` if first line of condition is a comment
- Added more context to "failed to terminate" error message to aid tracking down issues
- Updated `sortTypealiases` rule to also remove duplicate protocols in declaration
- Added some fixes to support parameter packs in Swift 5.9

## [0.52.3](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.52.3) (2023-09-02)

- Fixed incorrect hoisting of `try` inside multiline string literal interpolations
- Fixed incorrect hoisting of `try` inside generic type initializer calls
- Fixed case where parens were incorrectly removed around optional function calls
- Fixed bug where early `return` statements added while debugging would be incorrectly removed

## [0.52.2](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.52.2) (2023-08-19)

- Fixed static `Self` being incorrectly removed in `let` or `if let` expressions
- Fixed `// swiftformat:disable` directive not working for `redundantReturn` rule
- Fixed spurious assertion failure

## [0.52.1](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.52.1) (2023-08-17)

- Fixed various bugs and edge cases in `redundantStaticSelf` rule
- Fixed bug with `redundantReturn` rule for switch statements containing `fallthrough`
- Fixed `redundantReturn` rule stripping required return from `Void` switch statements
- Fixed some more cases where prefix `/` operator could be mistaken for a regex literal
- The `redundantReturn` rule now handles statements containing comments or raw strings
- Fixed spurious warning for unused options when using `--lintonly` rules
- Including `/` operator in `--nospaceoperators` or `--nowrapoperators` now works again

## [0.52.0](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.52.0) (2023-08-13)

- Added `redundantInternal` rule to remove redundant `internal` access modifiers
- Added `sortTypealiases` rule to sort `typealias` types alphabetically
- Added `headerFileName` rule to ensure filename in header comment matches actual file
- Added `redundantStaticSelf` rule to remove redundant `self` inside static functions
- Added `blankLinesBetweenChainedFunctions` rule to remove blank lines inside function chains
- Added `applicationMain` rule to remove obsolete `@UIApplicationMain` and `@NSApplicationMain` attributes
- Renamed `sortedSwitchCases` rule to `sortSwitchCases` for consistency
- Renamed `sortedImports` rule to `sortImports` for consistency
- Redundant `return` is now correctly removed in switch cases with associated values
- Fixed failure to terminate when removing returns from long switch statement
- Fixed spurious "unexpected static" error in `redundantSelf` rule
- Deliberate blank line before `else` statement is now preserved
- Rule options are now case-insensitive

## [0.51.15](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.51.15) (2023-08-06)

- Fixed regression in `unusedArguments` rule that caused used parameters to be marked unused
- Fixed some additional cases where regex literal was mistaken for `/` operator
- Vertical tab and form feed characters in source file no longer cause spurious errors

## [0.51.14](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.51.14) (2023-08-05)

- Withdrawn

## [0.51.13](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.51.13) (2023-07-18)

- Fixed bug where importing a type caused the `redundantSelf` rule to be silently disabled
- Fixed bug where `unusedArguments` would remove an argument that was used after an `if`
- Fixed Windows support and added Windows release  binaries (thanks to Saleem Abdulrasool)
- Fixed bug where backticks were incorrectly stripped from standalone `$` identifier
- Added support for `package` keyword in `organizeDeclarations` rule

## [0.51.12](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.51.12) (2023-06-13)

- Fixed `hoistTry` bugs with generics, subscripts and collection literals
- Fixed hoisting bugs with statements containing both `try?` and `try`
- Fixed hoisting of `try` inside an optional function
- Fixed function argument wrapping bug
- Fixed bug where nested closure `in` was mistaken for part of a `for` loop
- Added preliminary support for wrapping Swift 5.9 macro declarations
- Added preliminary support for Swift 5.9 `package` access modifier
- Added preliminary support for Swift 5.9 `consume` and `discard` operators
- Added preliminary support for Swift 5.9 `borrowing` and `consuming` modifiers

## [0.51.11](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.51.11) (2023-05-29)

- Fixed unexpected static function error false positive in `redundantSelf` rule
- Fixed failure to report lint error when removing a duplicate blank line at the end of the file
- Fixed bug where `hoistTry` rule failed with more than 10 `try` expressions at the same scope level
- Comments containing `TODO:` directives are no longer converted by the `docComments` rule

## [0.51.10](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.51.10) (2023-05-21)

- Fixed bug in `wrapAttributes` rule due to `class` declaration being mistaken for class-scoped var
- Fixed another case of incorrect indenting inside an `#ifdef` block
- Fixed line breaks being incorrectly removed by `sortedSwitchCases`

## [0.51.9](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.51.9) (2023-05-04)

- Fixed `typeSugar` rule unwrapping Optional `some/any` without inserting required parentheses
- Fixed indenting of function arguments inside an `#ifdef` block after a closing brace
- Fixed comment directive state leaking between rules

## [0.51.8](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.51.8) (2023-05-02)

- Fixed `redundantSelf` removing non-unwrapped weak `self` inside closures
- Fixed `fileprivate` rule making `init` private when inherited by subclass in the same file
- Fixed `hoistPatternLet` rule inserting `let` inside dictionary type literal
- Fixed indenting for chained members inside conditional compilation blocks
- Fixed `unusedArguments` incorrectly removing used argument after conditional compilation block
- Improved `unusedArguments` rule error handling

## [0.51.7](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.51.7) (2023-04-18)

- Fixed `redundantSelf` incorrectly inserting `self` for local variables declared in capture list
- Fixed `blankLineAfterImports` rule inserting blank line before `@_spi` imports
- Fixed `fileHeader` rule ignoring headers containing URLs

## [0.51.6](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.51.6) (2023-04-12)

- Required `self` is now preserved in function bodies inside closures with `[weak self]` captures
- Fixed bug with `hoistTry` inside chains of concatenated interpolated strings
- Fixed indenting of dot-prefixed identifiers inside `#else` and `#elseif` blocks
- Fixed parsing bug in `redundantSelf` rule

## [0.51.5](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.51.5) (2023-04-09)

- Added `--baseconfig` option to replicate old `--config` behavior
- Fixed `self` being incorrectly inserted inside capture list
- Fixed indenting of `.init` inside `#if` statements
- Fixed `redundantInit` glitch inside `#if` statements
- Fixed `redundantSelf` inside `if case` expressions
- Fixed `hoistTry` for strings containing multiple interpolation clauses
- Fixed redundant parens not being removed after `return` keyword
- Fixed spacing after attribute when using `--funcattributes same-line`
- Fixed false positive in collection literals for `unusedArguments`
- Fixed file access permissions errors not being reported

## [0.51.4](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.51.4) (2023-04-01)

- Limited `redundantReturn` inside if / switch expressions to Swift 5.9+
- Fixed `hoistTry` and `hoistAwait` inside multiline string literals
- Fixed invalid indenting of blank lines inside multiline string literals

## [0.51.3](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.51.3) (2023-03-27)

- Fixed `hoistTry` and `hoistAwait` rule breaking string interpolations
- Fixed bug where `opaqueGenericParameters` rule would remove non-redundant generic type
- Fixed parsing bug with trailing closures on optional methods
- Fixed `redundantSelf` rule parsing bug affecting string literals
- Updated if / switch expression features to be enabled only in Swift 5.9+

## [0.51.2](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.51.2) (2023-03-07)

- Fixed `hoistTry` rule breaking multiline function chains
- Added `--asynccapturing` and `--throwcapturing` options for `hoistTry` and `hoistAwait` rules
- Fixed changes in last line of file not being correctly tracked

## [0.51.1](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.51.1) (2023-03-02)

- Fixed `redundantNilInit` removing required `nil` inside Result Builders
- Fixed `redundantLet` removing required `let` inside Result Builder `switch/case` statements
- Fixed `hoistTry` rule removing second `try` inside XCTAssert statements

## [0.51.0](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.51.0) (2023-02-28)

- Added `hoistAwait` and `hoistTry` rules to hoist inline `await`/`try` to start of expression
- Extended `redundantPattern` rule to remove redundant `let` in patterns
- The `wrapMultilineStatementBraces` rules is now applied more consistently
- Updated `redundantReturn`/`Closure` rules to support `if`/`switch` expressions in Swift 5.8
- Added `conditionalAssignment` rule to assign variables using `if`/`switch` expressions in Swift 5.8
- Updated `redundantType` rule to support `if`/`switch` expression assignment Swift 5.8
- Extended `redundantSelf` rule to support implicit `self` in eligible closures in Swift 5.8
- SwiftFormat now ignores `.swiftformat` files when explicit `--config` file is provided
- Added `--wrapenumcases with-values` option to only wrap enum cases with values
- Added `--wrapeffects` option for wrapping function effects
- Removed unsafe `preferDouble` rule

## [0.50.9](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.50.9) (2023-02-16)

- Added GitHub actions log reporter (see `--reporter` option for details)
- Fixed bug where `redundantType` sometimes stripped in cases where it couldn't be inferred
- The `redundantType` rule now supports removing type in more cases where supported
- Made SwiftFormat for Xcode instructions dynamic according to OS version
- Fixed bug where a trailing comma could be left behind by `opaqueGenericParameters` rule
- Fixed bug where `wrapAttributes` rule sometimes wrapped inline attributes like `@MainActor`
- Improved support for `// swiftformat:options` comment directives
- Removed deprecated options from the example `.swiftformat` file

## [0.50.8](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.50.8) (2023-01-29)

- The `redundantBackticks` rule no longer removes required comments around `self`
- Associated type headerdoc comments are now handles correctly by the `docComments` rule
- Fixed mangled comments when using the `sortedSwitchCases` rule
- Hex, octal or binary literals are now sorted correctly in `sortedSwitchCases` rule
- Fixed regression in closed brace indentation (introduced in 0.50.7)
- Fixed unsafe semicolon removal after inferred `var` properties
- Added fileHeader placeholder documentation

## [0.50.7](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.50.7) (2022-12-27)

- Fixed parsing of regex literals preceded by `try` or `await`
- Fixed required parens being removed around `await` keyword
- Fixed indent for nested, wrapped parameters

## [0.50.6](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.50.6) (2022-12-03)

- Fixed regression in `fileHeader` rule where blank lines were removed after header
- Fixed globs matching when command-line tool is invoked from a directory such as `/var/tmp`
- Fixed bug in parsing regex literals beginning with `^` character

## [0.50.5](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.50.5) (2022-11-29)

- Fixed incorrect macOS command line binary that accidentally shipped with 0.50.4

## [0.50.4](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.50.4) (2022-11-23)

- Added Swift package command plugin
- Added `docComments` rule to convert between regular and documentation comments
- Fixed `redundantLet` rule incorrectly stripping `let` inside Result Builders
- Fixed `void` rule in cases where `Void` has been locally shadowed
- Fixed `fileHeader` rule when file only contains header comment
- Fixed unexpected indent and spurious `wrap` warning for blank lines
- Fixed parsing bug in `redundantSelf` rule

## [0.50.3](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.50.3) (2022-10-19)

- Fixed bug where `redundantFileprivate` rule could break Array extensions using type sugar
- Fixed bug and crash in `wrapSingleLineComments` rule relating to long URLs
- Improved `wrapSingleLineComments` handling of comments containing long URLs
- The `opaqueGenericParameters` rule is now correctly applied to initializers and subscripts
- Added some known issues for `opaqueGenericParameters` and `genericExtensions` to README

## [0.50.2](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.50.2) (2022-10-12)

- Fixed `redundantImports` dropping `@_implementationOnly` or `@_exported` annotations
- Fixed `blankLineAfterImports` bug affecting `@_implementationOnly` or `@_exported` imports
- Fixed case where regex literals were incorrectly interpreted as division operators
- Fixed bug with `genericExtensions` and nested generics
- Fixed crash in `opaqueGenericParameters` rule

## [0.50.1](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.50.1) (2022-10-05)

- Fixed bug in `opaqueGenericParameters` where type constraint depended on another type parameter
- Fixed crash in `opaqueGenericParameters` rule where type constraint contained closure type
- Fixed bug where `opaqueGenericParameters` broke variadic parameter expressions
- Fixed several bugs in `wrapSingleLineComments` rule
- Fixed crash in `andOperator` rule

## [0.50.0](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.50.0) (2022-09-28)

- Added `genericExtensions` rule for simplifying conditional type extensions in Swift 5.7
- Added `markTypes` support for type definitions in extensions
- Added `opaqueGenericParameters` rule  to use opaque generic parameter syntax where equivalent
- Added `blankLineAfterImports` rule
- Added `redundantOptionalBinding` rule for simplifying `if let` expressions in Swift 5.7
- Added `--enumnamespaces structs-only` option
- Added `wrapSingleLineComments` rule
- A `--swiftversion` in the `.swiftformat` config now takes precedence over `.swift-version` file
- Multiline string interpolations can now wrap inside parenthesized expression
- Comma-delimited options in descendent `.swiftformat` config files are no longer merged
- SwiftFormat now requires a minimum of Swift 5.1 to build

## [0.49.18](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.49.18) (2022-08-30)

- Fixed bug in `unusedArguments` when argument is shadowed in a `switch` case statement
- Fixed `enumNamespaces` rule breaking `open` class declarations
- Fixed `redundantLet` removing `let` incorrectly in `async let` statement
- Fixed indent regression when using `--xcodeindentation` option

## [0.49.17](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.49.17) (2022-08-16)

- Fixed unexpected token error occurring at end of scope after a `<<` operator
- Fixed bug where function arguments named `async:` would expectedly be indented
- SwiftFormat command-line tool now logs the location and version of .swift-version files it encounters
- Added Docker image (thanks to Arthur Semenyutin for the script, see README for details)

## [0.49.16](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.49.16) (2022-08-15)

- Fixed `async let` indenting regression (broken in 0.49.15)

## [0.49.15](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.49.15) (2022-08-11)

- Fixed illegal wrapping of ternary expressions inside single-line string interpolation
- Fixed bug where `await case` was incorrectly interpreted as ending the current scope
- Fixed issue where `async throws` was indented incorrectly
- Fixed bug where a pair of less-than, greater-than operators could be interpreted as generics
- Fixed case where `andOperator` rule could introduce parser ambiguity

## [0.49.14](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.49.14) (2022-08-02)

- Fixed `unusedArguments` rule incorrectly removing `async` keyword from closure arguments
- Fixed `unusedArguments` not being applied correctly to throwing closures
- Fixed assertion failure when parsing `@unchecked Sendable` enum
- Fixed assertion failure after applying typeSugar rule to array/dictionary extensions
- Fixed line indent after `wrapAttributes` rule is applied
- Fixed issue where redundantClosure would break build for Void closures calling @discardableResult functions
- Added `--typeblankline` option for `blankLinesAtStartOfScope` and `blankLinesAtEndOfScope` rules
- Added support for Xcode `SCRIPT_INPUT_FILE` arguments

## [0.49.13](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.49.13) (2022-07-15)

- Fixed `for...in` mistaken for closure `in` in indent rule
- Fixed incorrect spacing around `@MainActor`

## [0.49.12](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.49.12) (2022-07-13)

- Fixed bug with parsing ternary chains containing chevron
- Added another fix for `/` operator
- Fixed indent after wrapped closure `in`
- Improved rule search in SwiftFormat for Xcode app
- Fixed enum popups in SwiftFormat for Xcode options
- Added prebuilt SPM binary target

## [0.49.11](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.49.11) (2022-06-22)

- Fixed parsing of prefix `/` operator (as used in CasePath library)
- Fixed bug with indenting of trailing closures after a conditional statement
- Fixed bug with `wrapMultilineStatementBraces` rule
- Added Swift 5.6 and 5.7 to supported versions

## [0.49.10](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.49.10) (2022-06-18)

- Added preliminary support for Swift 5.7 regular expression literals
- Fixed conflict between `wrapMultilineStatementBraces` and `indent` rules
- Fixed bug where arguments referenced using `$` prefix were incorrectly marked as unused
- Fixed `enumNamespaces` bug where `class` modifiers were mistakenly converted to `enum`
- Fixed bug where `preferKeyPath` mangled functions using multiple trailing closure syntax
- Unterminated string literals are now treated as an error

## [0.49.9](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.49.9) (2022-05-16)

- Fixed bug where trailing comma was incorrectly added inside collection types
- Fixed some cases where `redundantVoidReturnType` failed to remove `Void`
- Fixed `unusedArguments` regression introduced in 0.49.8

## [0.49.8](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.49.8) (2022-05-03)

- Fixed `redundantInit` rule removing required init when instantiating type variables
- Fixed `unusedArguments` incorrectly marking shadowed parameters as used or unused in some cases

## [0.49.7](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.49.7) (2022-04-03)

- Redundant `self` is now correctly removed in `if let` assignments
- Fixed infinite recursion bug that would cause formatting to time out for some inputs
- Lint failure now returns an error code when using stdin, matching behavior for file inputs
- Fixed bug where parens were incorrectly removed around optional ranges
- Updated `unusedParens` rule for new shorthand `if let` syntax in Swift 5.7
- Updated indenting of function chains to match latest Xcode behavior
- Fixed build error on macOS 10.11 and earlier

## [0.49.6](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.49.6) (2022-03-15)

- Fixed bug where `redundantParens` rule removed required parens in `any` type expressions
- Fixed whitespace behavior around `some`/`any` keywords
- Fixed crash when `// swiftformat:sort` was applied to an enum with only one case
- SwiftFormat can now be built on Windows

## [0.49.5](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.49.5) (2022-03-06)

- Fixed bug where `redundantClosure` incorrectly inlined throwing closures
- Fixed bug where in `--exclude` path matching failed when using `--stdinpath`
- Fixed a bug with `typeSugar` rule when overriding stdlib types locally in your code
- Multiline statement braces are now unwrapped if `wrapMultilineStatementBraces` disabled
- Added `// swiftformat:sort` directive to sort declarations by name
- You can now use `--disable all` or `--enable all` as shorthand for all rules
- The rules in the `Rules.md` file are now grouped by their default/enabled status

## [0.49.4](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.49.4) (2022-02-07)

- Fixed creation date being modified on formatted files
- Fixed case where a closure inside an if condition was mistaken for the body
- Fixed `blockComments` rule removing leading `*`s used as bullet points
- Fixed bug when parsing a raw string containing three consecutive unescaped quotes
- Fixed spurious warning about unused `--wrapparameters` option
- Fixed edge case when using `--allman` indenting

## [0.49.3](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.49.3) (2022-01-26)

- Fixed required `let` being removed inside View Builders
- Fixed `blockComments` rule mangling code on next line after comment (really this time)
- Fixed unsafe removal of `self` inside `if` statements containing postfix operators
- Fixed `--selfrequired` behavior inside interpolated strings
- Fixed indenting of labelled trailing closures

## [0.49.2](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.49.2) (2022-01-16)

- Fixed literal values being incorrectly removed by `redundantType` rule
- Fixed `redundantSelf` rule removing `self` from shadowed variables after an `as`/`is` condition
- Fixed bug where `redundantClosure` rule could break the build for certain `Void` closures
- Fixed parsing error in function calls followed by a subscript
- Fixed `blockComments` rule mangling code on next line after comment
- The `redundantClosure` rule is no longer applied if closure calls a method that returns `Never`
- Fixed meaningless warning for deprecated options

## [0.49.1](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.49.1) (2021-12-09)

- The `blockComments` rule now handles empty leading and trailing comment lines correctly
- Fixed crash in `blockComments` rule
- The `redundantType` rule now handles comma-delimited declarations correctly
- Fixed spurious `self` removal when using `--self init-only` and `--swiftversion 5.4` or above
- Added support for the `unowned(safe)` and `unowned(unsafe)` ownership modifiers
- Fixed `wrapMultilineStatementBraces` error in SwiftFormat for Xcode app

## [0.49.0](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.49.0) (2021-12-04)

- The `redundantType` rule can now remove redundant types for properties initialized with literal values
- The `redundantType` rule now removes types only for local variables by default (to aid compilation performance)
- Added `assertionFailures` rule for automatically converting `assert(false, ...)` to `assertionFailure(...)`
- Added `acronyms` rule to auto-capitalize acronyms (disabled by default)
- Added `preferDouble` rule to replace `CGFloat` with `Double` on Swift 5.5 and above (disabled by default)
- Added `wrapConditionalBodies` rule to unwrap single-line guard and if statements (disabled by default)
- Added `blockComments` rule to replace multiline block comments with line comments (disabled by default)
- Added `blankLinesBetweenImports` rule to remove blank lines between import statements (disabled by default)
- Added `redundantClosure` rule to remove unnecessary closure wrappers
- Added `--lineaftermarks` option to add/remove a blank line after `// MARK:` comments
- Added `--markCategories` option for `organizeDeclarations` rule
- Added `--wrapternary` option for controlling how ternary operators are wrapped
- Added `--wraptypealiases` option for controlling how typealiases are wrapped
- Added `--indentstrings` option for controlling how multiline strings are indented
- Extended `redundantParens` rule to handle more cases
- Extended `wrapMultilineStatementBraces` rule to handle more cases
- Extended `redundantVoidReturnType` rule to apply to closure return values
- Fixed bug where `consecutiveBlankLines` rule would strip linebreaks inside multiline string
- Fixed bug with indenting of wrapped method chains when using `--xcodeindentation`
- SwiftFormat for Xcode app binary is no longer hosted in source repository

## [0.48.18](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.48.18) (2021-11-06)

- Fixed `redundantObjc` bug where `private(set)` prevented `@objc` attribute from being stripped
- Fixed indenting of wrapped member chains in or after `#if`/`#else`/`#endif` blocks
- The `--selfrequired` exclusion list is now applied to nested expressions within function's arguments
- Fixed parsing bug in `redundantSelf` rule that raised spurious error about missing `}`
- Fixed bug where error is `--filelist` files were incorrectly reported

## [0.48.17](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.48.17) (2021-10-18)

- Fixed bug where `trailingCommas` rule added comma to wrapped capture list with comment
- Fixed indenting of closure with wrapped capture list
- Fixed bug where `redundantArguments` rule stripped params used in pattern matching with inline let
- Fixed bug where `redundantArguments` failed to detect shadowed param after tuple assignment
- Fixed compilation error introduced when removing redundant parens with inner spaces

## [0.48.16](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.48.16) (2021-10-12)

- Fixed unexpected indentation of next line after a trailing closure
- Fixed unexpected indentation of `try` expressions
- Fixed bug where `redundantInit` could cause compilation failure
- Fixed indenting of multiple trailing closures

## [0.48.15](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.48.15) (2021-10-08)

- Fixed false positives in `unusedArgument` rule when using `try`/`await`
- Closing paren indent is now balanced for double-indented closures
- Fixed bug where comment directive failed to disable `redundantSelf` rule
- Fixed bug where `redundantSelf` exclusion list was not always applied
- Fixed regression introduced in 0.48.5 affecting indenting of wrapped closure bodies
- SwiftFormat directives are now recognized in the middle of a comment

## [0.48.14](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.48.14) (2021-10-06)

- Fixed some cases where function arguments were incorrectly treated as unused
- Fixed incorrect removal of self for some shadowed variables when swift version is >= 5.4
- Fixed indenting of wrapped method chains after a closing paren
- Rules listed in swiftformat comment directives are now case-insensitive

## [0.48.13](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.48.13) (2021-10-04)

- Fixed bug where `unusedArguments` incorrectly marked shadowed parameters as unused
- Fixed wrapped chained functions after an indented closing paren or square bracket
- Fixed Mint install

## [0.48.12](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.48.12) (2021-10-02)

- The `redundantSelf` rule now removes `self` from shadowed variable references where permitted
- Fixed bug where `self` was not correctly removed on the line following an assignment
- Fixed some cases where `self` was incorrectly removed from `@dynamicMemberLookup` members
- Fixed error raised where removing `self` caused ambiguity with global Swift functions
- Function parameters with shadowed names are now correctly marked as unused
- The `--selfrequired` option now applies to members, not just `@autoclosure` arguments
- Fixed trailing comment placement when using `wrapEnumCases` rule
- Fixed indenting of wrapped chained functions after a closing paren or square bracket
- Fixed bug where `some(Void)` was converted to `someVoid`
- Fixed potential range bounds crash in `editDistance()` function
- Now uses automatic test discovery on Linux instead of XCTestManifests file

## [0.48.11](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.48.11) (2021-07-20)

- Fixed parsing error introduced in 0.48.10 involving inline closures inside conditional statements
- Fixed bug where `redundantSelf` could potentially misidentify tuple labels as local variables

## [0.48.10](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.48.10) (2021-07-18)

- Fixed issue with `redundantBackticks` rule incorrectly removing required backticks around underscore
- Fixed parsing error in `redundantSelf` with guard conditions containing inline closures 

## [0.48.9](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.48.9) (2021-07-09)

- Fixed regression introduced in 0.48.7 where parens around prefix expressions were incorrectly removed

## [0.48.8](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.48.8) (2021-07-08)

- Fixed regression introduced in 0.48.7 where parens around operator literals were incorrectly removed

## [0.48.7](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.48.7) (2021-07-07)

- Fixed bug where `redundantParens` rule could introduce an ambiguity by removing parens around a range argument
- Fixed bug where `unowned(unsafe)` capture argument would be mangled by `unusedArguments` rule
- Fixed spurious double-indenting of trailing closures in some cases

## [0.48.6](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.48.6) (2021-06-23)

- Fixed bug where `actor` variables were incorrectly interpreted as a keyword in certain cases
- The `redundantBackticks` rule no longer removes required backticks around `actor` properties
- Doc comments containing TODO: are no longer converted to regular comments if it would mangle the docs

## [0.48.5](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.48.5) (2021-06-15)

- Fixed bug when parsing generic result builder attributes, leading to incorrect spacing
- Fixed bug where wrapped function body was not double-indented as it should have been
- Parser now correctly handles `isolated` and `nonisolated` modifiers on `actor` members
- Fixed bug where space was incorrectly removed between closure capture list and arguments
- Fixed bug with indenting of wrapped method chains

## [0.48.4](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.48.4) (2021-05-30)

- Added support for `actor` and other async/await syntax introduced in Swift 5.5
- Functions with `@Sendable` closure parameters are now formatted correctly
- The `redundantGet` rule no longer removes effectful get clauses (i.e. `get throws` or `get async`)
- Fixed indenting of postfix expression members inside `#else` and `#elseif` clauses
- The `--typeattributes` option now applies to extension attributes as well as type declarations
- Improved indentation for accessors/method calls in multiline conditionals

## [0.48.3](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.48.3) (2021-05-22)

- Fixed bug where files would not be correctly excluded when using `--stdinpath`
- Fixed bug with `typeSugar` rule affecting optional composed protocol types
- Fixed bug where `hoistPatternLet` would incorrectly add let before `nil` or `true`/`false`

## [0.48.2](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.48.2) (2021-05-16)

- Fixed wrapping of generic property wrapper attributes
- Fixed bug where trailing comma could be inserted inside a collection type signature

## [0.48.1](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.48.1) (2021-05-08)

- Fixed bug where `typeSugar` rule triggered a Swift bug inside case statements
- Fixed double-indenting of trailing closure body on a wrapped line
- Fixed compilation failure when installing SwiftFormat using Swift Package Manager
- Fixed wrapping of name-spaced property wrapper attributes
- Fixed bug where `redundantReturn` rule removed required return inside `catch` statement
- Fixed issue where `redundantType` rule introduced compilation warnings by removing explicit Void type
- Fixed bug where trailing comma could be inserted inside a subscript nested inside a collection
- Fixed spurious space inserted in generic result builder attributes
- Successive reads of the same configuration file while formatting are now cached to improve performance

## [0.48.0](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.48.0) (2021-04-20)

- Added `--emptybraces` option to control how empty braces are formatted
- The `redundantReturn` rule now removes redundant `return` statements in Void functions
- The `redundantParens` rule now removes redundant parens around closure arguments
- Fixed parsing error with complex `guard` statements
- Extended `prefersKeyPath` to support `contains`, `allSatisfy` and `filter` methods
- Fixed matching of excluded paths containing ../
- Added support for using globs/wildcards in input paths
- Eliminated false positives in change list when using `--lint` mode
- File header comments are now inserted after the shebang/hashbang in executable Swift scripts
- Xcode Extension now silently ignores rules requiring file info that isn't available to extensions
- Fixed bug where `wrapEnumCases` rule was incorrectly applied to `if case` or `guard case`
- Added `--report` argument for exporting formatting changes or lint violations as a JSON file
- Improved tab layout in SwiftFormat for Xcode companion app

## [0.47.13](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.47.13) (2021-03-21)

- Fixed bug where `--wrapreturntype if-multiline` would unexpectedly wrap a single-line method
- Multiline chained functions are now indented correctly when using `--xcodeindentation`
- Blank lines are no longer inserted between multiline chained functions separated by comments
- Fixed bug in `hoistPatternLet` rule where `let` would be placed on the wrong line
- Fixed bug where `Void.self` would incorrectly be converted to `().self`
- Fixed incorrect spacing of closure arguments containing attributes
- Trailing commas are no longer incorrectly inserted inside wrapped type signatures
- Added `--lintonly` argument to specify rules that should only be applied in `--lint` mode

## [0.47.12](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.47.12) (2021-02-23)

- Fixed indenting of `switch` cases inside `#if`/`#endif` clauses 
- Explicit `self` is no longer removed inside types using `@dynamicMemberLookup`
- Fixed indenting of wrapped, chained methods when using `--xcodeindentation`
- `await` is no longer treated as a keyword if `--swiftversion` is set to < 6
- Fixed issue where single line method after array would wrap unexpectedly
- Made repository checkoutable on Windows

## [0.47.11](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.47.11) (2021-01-29)

- Fixed bug with `redundandSelf` rule sometimes inserting `self` for a local variable
- Fixed `wrapAttributes` rule not working for convenience `init`s, or vars with `private(set)`
- Fixed bug with indenting of wrapped members when using `--xcodeindentation` mode
- Fixed erroneous space being inserted into keyPaths by `spaceAroundOperators` rule
- Fixed bug with `--nospaceoperators` affecting custom infix operators with closure operands
- Added support for sorting imports by length instead of alphabetically

## [0.47.10](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.47.10) (2020-12-28)

- The `blankLinesBetweenScopes` no longer inserts a blank line before Sourcery comment directives
- Fixed bug where `redundantFileprivate` rule could break code that uses property wrappers
- Fixed crash in `parseDeclarations` helper

## [0.47.9](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.47.9) (2020-12-24)

- Fixed bug with `redundantType` rule removing required type in `if let` expressions
- Fixed a bug in `organizeDeclarations` when file contains a class-bound protocol
- Improved `sortedSwitchCases` ordering
- Removed erroneous space inserted into array initializer by the `spaceAroundParens` rule
- Comments followed by a continuation character in SwiftFormat config files now handled correctly 
- Removed spurious blank lines in console output introduced in 0.47.8
- Improved command-line typo suggestions

## [0.47.8](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.47.8) (2020-12-10)

- Fixed additional cases where `fileprivate` was incorrectly converted to `private` in extensions
- Added preliminary support for upcoming async/await syntax

## [0.47.7](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.47.7) (2020-12-09)

- Fixed critical bug where `fileprivate` was incorrectly converted to `private` in some cases

## [0.47.6](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.47.6) (2020-12-08)
 
- Fixed bug in `redundantReturn` when the `return` statement is not the last line in a block
- Fixed sorting of tuple cases when using `sortedSwitchCases` rule
- Added `--nevertrailing` option for excluding functions from the `trailingClosures` rule
- Added `trailingClosures` exception for Nimble `expect()` function
- The `redundantFileprivate` rule is now applied correctly to extension members
- Fixed some bugs with static members when using the `--redundanttype explicit` option
- SwiftFormat command line tool is now signed for better compliance with Big Sur
- Updated icon for Big Sur (thanks to Jim Puls for the icon design)

## [0.47.5](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.47.5) (2020-11-27)

- Added `--redundanttype` option for controlling how redundant types are resolved
- Numeric case values are now sorted naturally instead of alphabetically
- Fixed bug where `redundantFileprivate` rule broke trailing-closure inits
- Fixed various `enumNamespaces` rule edge-cases
- Broken symlinks no longer raise an error if they are ignored in config
- File creation date can now be used in header formats on Linux
- The `--symlinks` option now works correctly on Linux

## [0.47.4](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.47.4) (2020-11-15)

- Command-line tool now includes an arm64 slice for Apple Silicon
- Increased strictness of grouped extensions logic
- Fixed issue where `markTypes` rule would mistake an import declaration as a type
- Fixed some additional bugs with unhoisting pattern let
- Fixed bug with trailing comma being inserted in capture lists
- Added warning when setting options for disabled rules
- Fixed bug with `sortedImports` mangling file header comment
- Fixed bug with indenting of multiline comments

## [0.47.3](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.47.3) (2020-11-09)

- Fixed bug with `extensionAccessControl` increasing extension access level beyond extended type
- Fixed regression with non-standard .swift-version contents being flagged as an error
- Fixed bug in `hoistPatternLet` rule when using `--patternlet inline`
- Fixed case where `enumNamespaces` was incorrectly applied
- Fixed indenting of wrapped line starting with a closing paren or brace
- Fixed indenting of blocks starting on same line as a switch case
- Fixed indenting of wrapped closure parameter
- Fixed bug in `--allman` inference

## [0.47.2](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.47.2) (2020-10-30)

- The `markTypes`, `organizeDeclarations` and`extensionAccessControl` rules now respect comment directives
- Errors in .swiftformat config files no longer fail silently
- Fixed bug in `--modifierorder` config and added support for SwiftLint modifierorder syntax
- Fixed issue where `hoistPatternLet` breaks compilation due to a quirk in Swift parser
- Fixed bug in `hoistPatternLet` when expression is wrapped or contains spaces
- The `typeSugar` rule is now applied in more cases
- Fixed bug in cache logic resulting in slower formatting when using certain config options
- Fixed crash in `indent` rule
- Fixed bug in wrapped `else` indent

## [0.47.1](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.47.1) (2020-10-26)

- Fixed a crash when using the `fileHeader` rule
- Fixed occasional out-of-bounds crash in `markTypes` rule
- Fixed bug where `wrapArguments` rule unexpectedly indented blank lines inside braces or brackets
- Added `--wrapconditions` option for controlling how multiline conditional statements are wrapped
- Unicode whitespace characters other than space and tab are no longer treated as an error
- Indenting of `else` clauses now matches Xcode 12

## [0.47.0](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.47.0) (2020-10-14)
 
- Indenting of wrapped `if`, `guard`, `while`, etc. now matches Xcode 12 behavior
- Added `--assetliterals` option for managing how image/color literal length is handled
- Added `enumNamespaces` rule to replace classes/structs that only have static members with an enum
- Added `extensionAccessControl` rule to hoist/unhoist access control modifiers inside extensions
- Added `markTypes` rule for automatically inserting `MARK:` comments between type declarations
- Added `sortedSwitchCases` rule to automatically sort grouped switch cases alphabetically
- Added `--wrapreturntype` option to control how return type is wrapped in function declarations
- The `organizeDeclarations` rule is now also applied to extensions
- Updated `--xcodeindentation` behavior for Xcode 12

## [0.46.3](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.46.3) (2020-09-20)

- Fixed bug where `redundantType` rule corrupted assignments involving ternary expressions
- SwiftFormat for Xcode Extension now works in Xcode 12 out of the box

## [0.46.2](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.46.2) (2020-09-05)

- Fixed space being unexpectedly removed before prefix `.` operator by `spaceAroundOperators`
- Fixed bug where a pair of less-than, greater-than operators could be interpreted as generics
- Fixed `organizeDeclarations` rule mistaking function with nested class for a lifecycle method

## [0.46.1](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.46.1) (2020-08-30)

- Fixed bug where computed property bodies were sometimes wrongly identified as closures
- Fixed spurious blank lines in output when formatting
- The `organizeDeclarations` rule no longer inserts blank lines at start/end of scopes
- The `organizeDeclarations` rule now groups typealiases with types instead of properties
- Improved heuristic for matching `// MARK:` comments in `organizeDeclarations`
- Configuration file now allows line continuations using `\` delimiter

## [0.46.0](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.46.0) (2020-08-28)

- Added `organizeDeclarations` rule for grouping and organizing type members
- Added `wrapEnumCases` rule for wrapping enum cases onto separate lines
- Added `wrapSwitchCases` rule for wrapping switch cases onto separate lines
- Added `initCoderUnavailable` rule for marking stub `init(coder:)` implementations as unavailable
- Added `redundantType` rule for removing redundant type annotations from variable declarations
- Added search filter bar for rules in SwiftFormat for Xcode extension
- Selection is now preserved correctly in Xcode 12 when using SwiftFormat extension
- Fixed indenting of wrapped closure arguments when using `--closingparen same-line`
- Fixed spurious space insertion with `spaceAroundOperators` rule in some circumstances
- Switch cases marked with `@unknown` are now indented automatically instead of being ignored
- Wrapped method chains now behave more consistently when using `--xcodeindentation` option
- Removed deprecated `ranges` rule, but un-deprecated the `ranges` option for convenience
- Single-letter command-line flags now behave more usefully (e.g. -o maps to --output)
- Spaces are now permitted in comma-delimited command-line arguments
- Added more helpful feedback for mistyped arguments

## [0.45.6](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.45.6) (2020-08-12)

- Added `--yodaswap` option for more fine-grained control of `yodaConditions` rule
- Fixed indentation of wrapped type declarations when using `--xcodeindentation enabled`
- Fixed alignment of closure braces when using `--allman` style

## [0.45.5](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.45.5) (2020-08-09)

- Fixed .swiftformat configuration file processing when using `--stdinpath` option
- Fixed bug where conditional imports could be mangled by `sortedImports` rule
- Fixed indenting of braces after throwing function with wrapped return type
- Fixed indenting of wrapped `in` keyword inside closure

## [0.45.4](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.45.4) (2020-08-08)

- Improved indenting of wrapped closure braces when using `--allman` indenting
- Fixed crash in `blankLinesBetweenScopes` rule when using `--linerange` argument
- Fixed `indent` rules behavior when using `--linerange` argument
- Audited all rules for `--linerange` compatibility
- Improved `Format Selection` behavior in Swiftformat for Xcode extension
- Fixed bug with `fileHeader` rule stripping formatting comment directives at top of file
- Documented known issue with `preferKeyPath` and `compactMap()` in README file
- The value for `--wrapparameters` now defaults to match `--wraparguments`
- Fixed indenting of wrapped guard else

## [0.45.3](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.45.3) (2020-08-03)

- Added `--linerange` command-line argument for partial file formatting or linting
- Added `--varattributes` option to complement `--funcattributes` and `--typeattributes`
- Fixed spurious "Unexpected static/class ..." warning in `redundantSelf` rule 
- Fixed bug in tokenIndex() calculation when last line does not end in a linebreak
- Fixed bug where `self` was incorrectly removed inside trailing closures on generic type init
- Blank lines are no longer indented when using `--trimwhitespace nonblank-lines`

## [0.45.2](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.45.2) (2020-08-01)

- You can now tweak formatting options inside source files using `// swiftformat:options ...` directive
- The `wrapMultilineStatementBraces` rule is now applied to more statement types
- Fixed spurious lint warnings due to conflict between `braces` and `wrapMultilineStatementBraces` rules
- Fixed several bugs in `redundantSelf` rule relating to for loops
- Fixed bug with indenting of closure arguments
- Fixed unsafe removal of backticks around `init`
- Rules can now raise an error if they encounter malformed code instead of failing silently
- SwiftFormat for Xcode app no longer shows deprecated rules in the rules tab

## [0.45.1](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.45.1) (2020-07-30)

- Fixed bug where `preferKeyPath` was incorrectly applied to function calls and compound expressions
- The `wrapMultilineStatementBraces` rule is now applied to `init` and `subscript` braces
- The `wrapAttributes` rule now handles `init` and `subscript` the same way as functions

## [0.45.0](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.45.0) (2020-07-29)

- Added `wrapAttributes` rule for controlling attribute position
- Added `wrapMultilineStatementBraces` rule for opening braces for wrapped expressions
- Added `preferKeyPath` rule for converting trivial closures to keyPaths in Swift 5.2
- Added `--smarttabs` option to support consistent indenting regardless of `--tabwidth`
- Updated Xcode extension for Xcode 12 and macOS Big Sur
- Added Swift version dropdown to SwiftFormat for Xcode configuration app
- Added `--guardelse` option to control wrapping of `else` clauses in `guard` statements
- Allman braces are now applied to closure braces, which were previously ignored
- The `void` rule now converts `Void()` literals to just `()`
- Improved indenting of closing parentheses and brackets
- Renamed `--empty` option to `--voidtype`, which better describes its function
- Renamed `specifiers` rule to `modifierOrder` for consistency with SwiftLint
- Renamed `--specifierorder` configuration option to `--modifierorder`
- Fixed bug where `--verbose` mode didn't log path for unchanged files
- Improved documentation of `numberFormatting` configuration options
- Added Sublime Text plugin instructions

## [0.44.17](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.44.17) (2020-07-12)

- The `wrapArguments` rule now keeps internal and external parameter labels on the same line
- Multiline string literals are now indented more consistently 
- Fixed infinite recursion bug in the `redundantSelf` rule
- Fixed duplicate file path logging in `--verbose` mode
- Indented braces are now always balanced
- Add `--stdinpath` option, allowing git pre-commit hook to support file header info
- Updated instructions for git pre-commit hook (again)
- Added inference for `--noSpaceOperators` option

## [0.44.16](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.44.16) (2020-07-02)

- Fixed bug in `--output stdout` processing
- Reverted git pre-commit hook instructions

## [0.44.15](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.44.15) (2020-07-01)

- Fixed incorrect indenting for double-nested closures
- Added inference for `--wrapparameters` option
- Fixed incorrect `--wraparguments` inference
- The `spaceInsideBraces` rule will no longer add space between nested braces
- Fixed bug in `isStartOfClosure()` helper
- Fixed indent logic for closing braces
- You can now use `--output stdout` even when using a file path for input
- SwiftFormat will now raise an error if missing info needed for `fileHeader` rule
- Improved SwiftFormat for Xcode app icon
- Updated instructions for git pre-commit hook

## [0.44.14](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.44.14) (2020-06-23)

- Added new icon for SwiftFormat for Xcode app (thanks to Vikram Kriplaney for the icon design)
- Fixed `redundantParens` rule stripping parens around `#file` (used to silence warning in Swift 5.3)
- Avoid raising "Malformed .swift-version file" error when using unusual formats (e.g. for beta releases)
- Fixed `redundantBackticks` rule unescaping `get` inside subscript with `where` clause
- Fixed `redundantReturn` failing to remove `return` in function or subscript with `where` clause
- Fixed SwiftFormat for Xcode version number

## [0.44.13](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.44.13) (2020-05-28)

- Fixed indenting of closing bracket when using `wrapArguments` rule
- Added `--shortoptionals` argument to selectively disable shortening of `Optional<T>` to `T?` for properties
- Added `--minversion` argument to specify minimum SwiftFormat version to use for a given codebase

## [0.44.12](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.44.12) (2020-05-27)

- Fixed indenting of chained methods with trailing closures
- SwiftFormat command-line tool now logs the location of .swiftformat configuration files that it encounters

## [0.44.11](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.44.11) (2020-05-23)

- Fixed failure to terminate when wrapping functions after first parameter
- First element in a wrapped collection or function is now correctly indented
- Added workaround for Swift type sugar parsing bug
- The `blankLinesBetweenScopes` rule no longer inserts a blank line before an `#else` block
- Downgraded "No eligible files found" error to a warning
- Removed "Failed to format any files" error, which was sometimes triggered erroneously
- Fixed deprecation warning when building on Linux

## [0.44.10](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.44.10) (2020-05-14)

- Fixed bug where `--specifierorder` option values were sorted alphabetically
- Fixed a couple of bugs in `hoistPatternLet` when `--patternlet` is set to `inline`
- Added support for hoisting/unhoisting `var` and `let` in `do ... catch` patterns
- Added error if `--specifierorder` contains duplicate values

## [0.44.9](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.44.9) (2020-05-05)

- Added `--specifierorder` argument for overriding default order used by `specifiers` rule
- Added `--nowrapoperators` argument for preventing `wrap` rule breaking at specific operators
- The `redundantNilInit` rule no longer removes `nil` defaults from vars in structs using synthesized init
- Fixed indenting of trailing comment delimiter in multiline comments

## [0.44.8](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.44.8) (2020-05-01)

- Fixed a significant performance regression introduced in 0.44.6
- Changed ordering of `override` keyword in specifier lists to match SwiftLint
- Fixed timeout due to infinite recursion when formatting nested comments
- The `trailingSpace` rule is now called before `indent` to avoid noise when linting
- Fixed bug where `unusedArguments` rule ignored all arguments if any was already ignored
- Fixed `redundantParens` rule breaking closure argument lists where argument is named `self`
- Fixed indenting of multiline string interpolations
- Fixed broken formatting of multiline string interpolations
- Fixed crash in `wrap` rule
- The `wrap` rule now favors wrapping function args over wrapping at `.` operator
- Fixed a bug with indenting of pre-formatted multiline comments
- Fixed a misleading error message relating to `--tabwidth` option

## [0.44.7](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.44.7) (2020-04-04)

- Fixed indenting of wrapped closures after a switch statement
- Fixed bug with `redundantNilInit` removing `nil` for properties using parameterized property wrappers
- Fixed `redundantRawValues` rule not removing values for back-tick-escaped case names
- Improved error messages for misnamed rules
- Documentation improvements

## [0.44.6](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.44.6) (2020-03-21)

- Fixed timeout when formatting files containing multiple trailing closures
- Added `--filelist` argument for specifying input source files list in a standalone file
- Fixed bug in the git pre-commit hook suggested in the README file

## [0.44.5](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.44.5) (2020-03-11)

- Fixed bug with indenting of chained closures
- Fixed bug where wrapped braces were over-indented
- Fixed indenting of comments inside enum declarations
- Improved consistency of `--xcodeindentation` output with Xcode's built-in formatting
- Extension braces are now correctly wrapped
- Switch statement braces are now correctly wrapped
- Fixed bug where `duplicateImports` rule could remove a required `@testable` import

## [0.44.4](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.44.4) (2020-02-27)

- Allman braces are now applied correctly for lines that end in a numeric literal
- Blank line is now removed when stripping a redundant `return` keyword on its own line
- Fixed space being inserted before the `.` in a nested PropertyWrapper expression
- Fixed `return` being incorrectly removed inside `if` statements containing an un-parenthesized closure

## [0.44.3](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.44.3) (2020-02-20)

- Fixed incorrect indenting of closing multiline string delimiter
- Fixed bug where `redundantReturn` rule incorrectly removed `return` after a brace without leading space
- Fixed edge case where closures without surrounding parentheses were misinterpreted in if statements
- Fixed failure to wrap braces after a struct or init declaration

## [0.44.2](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.44.2) (2020-02-02)

- Fixed crash in line wrapping logic
- Fixed several cases where braces were not correctly moved according to `wrap` rule
- Prevented wrapping of image and color literals
- Fixed bug with `trailingClosures` rule breaking unwrap operators

## [0.44.1](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.44.1) (2020-01-26)

- Fixed `spaceInsideComments` rule mangling preformatted comments with multiple slashes
- Fixed `redundantFileprivate` breaking code relying on type-inference for `init`
- Reverted overly aggressive argument wrapping change in 0.44.0
- Fixed `redundantParens` rule breaking `#if` statements without space before argument
- Fixed `// swiftformat:disable` directives not affecting `wrap` or `wrapArguments` rules
- Fixed bug where `yodaConditions` rule caused formatting to never terminate
- Fixed crash in `fileHeader` rule

## [0.44.0](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.44.0) (2020-01-15)

- Xcode Extension now includes Lint File option
- Xcode Extension now preserves selection after formatting
- Improved range-based formatting in Xcode Extension
- Wrapping of function calls can now be configured separately from function declarations via the `--wrapparameters` option
- Numerous improvements to wrapping and indenting logic (thanks to @AnthonyMDev for the fixes)
- Fixed indent logic for unbalanced closing parens
- Fixed `self` being removed incorrectly inside if statements
- Fixed duplicate lint warnings
- Fixed failure to fix indent at start of file
- Fixed reported line index for `consecutiveBlankLines` rule

## [0.43.5](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.43.5) (2020-01-04)

- Fixed bug where `redundantBreak` rule removed entire line if break appeared after a semicolon
- Fixed a couple of cases where `redundantSelf` failed to remove `self` as expected

## [0.43.4](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.43.4) (2020-01-02)

- Fixed regression in `indent` rule` that could cause multiline strings to become mis-formatted
- Fixed bug in `--nospaceoperators` option where `..<` operator was rejected
- Added instructions for installing SwiftFormat for Xcode via Homebrew cask

## [0.43.3](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.43.3) (2019-12-31)

- Deprecated `ranges` rule and `--ranges` option (use `--nospaceoperators` with `spaceAroundOperators` rule instead)
- The `redundantSelf` rule no longer removes self in cases where property requires backtick escaping
- Fixed bug with `--nospaceoperators` potentially removing required spaced near linebreaks
- Fixed spurious lint warnings in `spaceAroundOperators`, `indent` and `wrap` rules
- Improved wrapping heuristic for closures to avoid splitting expressions if avoidable
- Fixed indenting of closing brace for line-wrapped closures
- Fixed `indent` rule performance regression introduced in 0.43.2
- Added warnings for deprecated options in config file

## [0.43.2](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.43.2) (2019-12-28)

- Added `--nospaceoperators` option for selectively removing space around specific operators
- Allow `self` in lazy vars when Swift 4 and above
- Fixed spurious lint warning when using a custom header with `fileHeader` rule
- Fixed bugs with indenting of consecutive comments
- Fixed resolving of macOS aliases when using `--symlinks follow`
- Added explicit `stdin` parameter option
- Fixed stdin timeout flakiness
- Fixed bug with `andOperator` replacing `&&` with `,` inside ViewBuilders

## [0.43.1](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.43.1) (2019-12-22)

- Fixed indent regression in wrapped `let` expressions
- Fixed failure to remove `return` in `get` accessors

## [0.43.0](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.43.0) (2019-12-18)

- Added per-line warning when running in `--lint` mode
- Significantly improved Xcode integration when running as a build step in `--lint` mode
- Added `--lenient` option to suppress errors when running in `--lint` mode
- Fixed bug where required `self` was sometimes incorrectly removed inside a trailing closure
- Improved `wrap` rule heuristic for prioritizing where a line should be broken
- Fixed bug in `typeSugar` rule affecting namespaced types

## [0.42.0](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.42.0) (2019-11-30)

- Added `wrap` rule for automatic wrapping of long statements or expressions based on `--maxwidth` option
- Fixed bug with `braces` rule inserting a redundant blank line at the start of nested scopes

## [0.41.2](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.41.2) (2019-11-27)

- Fixed bug with `trailingCommas` rule incorrectly inserting a comma into wrapped collection type expressions

## [0.41.1](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.41.1) (2019-11-25)

- Fixed bug with `wrapArguments` rule incorrectly wrapping code inside interpolated String expressions

## [0.41.0](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.41.0) (2019-11-23)

- The `wrapArguments` rule can now automatically wrap functions and collections to `--maxwidth`
- Added `—maxwidth` option to specify the width at which code should wrap (currently only used by `wrapArguments` rule)
- Added `—tabwidth` option to help with code indenting and wrapping when using tabs for indent
- Fixed indenting of code wrapped after the `in` in a `for...in` loop
- Fixed indenting of code wrapped before the `is` in an expression
- Added version check for `redundantBackticks` rule to support fixes in Swift 5
- Fixed error when parsing escaped triple-quote in a multiline string
- Fixed bug where a multiline comments before an opening brace could result in corrupted output
- CLI will now fail if .swiftformat file contains an invalid option, instead of ignoring it
- Added support for formatting Swift package manifest files using Xcode Extension

## [0.40.14](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.40.14) (2019-10-28)

- The `redundantReturn` rule no longer incorrectly removes `return` inside `catch let` statements
- The `andOperator` rule no longer replaces `&&` with `,` inside function builder blocks
- Fixed a bug where `redundantFileprivate` rule incorrectly made overridden `fileprivate init` methods private
- The `fileHeader` rule no longer strips tools version header from `Package.swift` files
- The `todos` rule now recognizes and fixes a wider variety of typos

## [0.40.13](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.40.13) (2019-10-10)

- The `redundantReturn` rule now removes `return` from functions and computed properties in Swift 5.1
- Fixed a bug with `let` hoisting

## [0.40.12](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.40.12) (2019-09-20)

- Fixed crash when compiling with Xcode 11
- Fixed `redundantFileprivate` rule breaking inner types
- Fixed `--quiet` option preventing formatting code to stdout

## [0.40.11](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.40.11) (2019-07-29)

- Added `--xcodeindentation` option to use Xcode-style indentation for guards and enums
- The `redundantNilInit` rule no longer removes `nil` for properties using property wrappers
- Fixed bug where `redundantParens` rule incorrectly stripped Void generic arguments
- The `void` rule is now correctly applied to generic type parameters

## [0.40.10](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.40.10) (2019-06-23)

- The `emptyBraces` rule no longer removes linebreaks in chained `else`/`catch` blocks
- Fixed duplicate `fileHeader` insertion when comment isn't followed by blank line
- SwiftFormat command-line tool no longer times out when encountering an empty file
- Fixed bug in `yodaConditions` rule affecting parenthesized subexpressions
- The `consecutiveBlankLines` rule no longer strips blank lines inside multiline string literals
- The `redundantObjc` rule no longer strips `@objc` annotation from `fileprivate` members
- The `{file}` placeholder in `fileHeader` templates now works correctly

## [0.40.9](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.40.9) (2019-05-27)

- Fixed another case of `redundantSelf` removing required `self` in closures
- Fixed behavior of `redundantSelf` in cases where `self` is shadowed
- The `redundantObjc` rule no longer strips `@objc` annotation from private members
- Fixed bug where `isEmpty` rule mangled expressions containing an array count
- The `redundantSelf` rule now correctly inserts `self` in code following a declaration
- Fixed bug where `—trailingclosures` option was being ignored
- Removed extra newline when printing content to stdout
- Fixed some bugs in the `fileHeader` rule

## [0.40.8](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.40.8) (2019-04-16)

- Fixed several bugs when using the `--self insert` option

## [0.40.7](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.40.7) (2019-04-12)

- Fixed postfix operator followed by `.` being incorrectly interpreted as infix
- Fixed bug with `andOperator` in repeat/while loops
- Fixed bug with `redundantFileprivate` affecting local subclasses
- Fixed regression with `--self insert` adding `self` to function parameter labels
- Case-differing imports are now preserved

## [0.40.6](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.40.6) (2019-04-10)

- Fixed a regression when parsing a generic type followed by `& SomeProtocol`
- Fixed bug where `--self insert` option failed to insert `self` in the line after a `let` or `var` statement
- Added `--unexclude` file paths option
- Added regression test project suite

## [0.40.5](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.40.5) (2019-04-08)

- Fixed indenting of comments before an `#if`/`#else` clause inside a `switch` statement
- Fixed indenting of `#if` statement followed by comment inside a `switch` statement
- Fixed bug in `self` removal when followed by a `switch` containing an `#ifdef`
- Fixed bug when tokenizing chevron operators
- Fixed bug when tokenizing generic declarations
- Added `init-only` support to explicitSelf inference
- Added inference for inline semicolons

## [0.40.4](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.40.4) (2019-03-23)

- Multiple instances of `--disable` or other comma-delimited config options are now merged instead of replacing previous
- The `redundantParens` rule no longer removes explicit double-parens used to suppress warnings inside `Selector(...)`
- The `trailingCommas` rule no longer breaks calls to `UICollectionView.performBatchUpdates()` 
- Fixed bug in `yodaConditions` rule that broke KeyPaths

## [0.40.3](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.40.3) (2019-03-19)

- Fixed some bugs with the `redundantFileprivate` rule relating to struct members
- The `redundantFileprivate` rule no longer affects members required for protocol conformance
- Fixed a bug with `yodaConditions` rule inside ternary expressions

## [0.40.2](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.40.2) (2019-03-19)

- Fixed a bug where the `redundantParens` rule incorrectly removed parens in a subscript or function invocation
- Fixed a bug with the `trailingClosures` rule removing parens inside some conditional expressions
- Fixed a bug in the `yodaConditions` rule that broke expressions containing subscripts
- Fixed the `--swiftversion` option, which was being ignored under some circumstances
- Fixed bug that caused the `--fragment` and `--conflictmarkers` options to be ignored
- Fixed a bug in the `redundantObjc` rule that incorrectly stripped `@objc` from nested enum types

## [0.40.1](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.40.1) (2019-03-16)

- Fixed bug where `--trailingclosures` would incorrectly remove parentheses before an opening brace
- Fixed SwiftFormat for Xcode appearance when running in dark mode on macOS 10.14 (Mojave)

## [0.40.0](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.40.0) (2019-03-14)

- Added `--trailingclosures` option for whitelisting functions that should use trailing closure syntax
- The `trailingClosures` rule now only applies to a safe subset of methods by default
- Enabled `trailingClosures`  rule by default (use `--disable trailingClosures` to opt out)
- SwiftFormat now infers values to use for indentation, linebreaks, etc. if the associated rules are disabled
- Added new `yodaConditions` rule that moves constant values to the right-hand-side of expressions
- The `--dryrun` and `--lint` modes now only list modified files when running in `--verbose` mode
- Added an automatic timeout for buggy rules, or if a rule gets stuck when processing malformed input
- Fixed a bug in the `wrapArguments` that could corrupt argument lists containing commented lines
- Fixed bug where `wrapArguments` sometimes rewrapped parenthesized expressions
- Rule documentation is now available programmatically via the command-line
- Improved command-line UI, providing additional feedback and more detail in error messages
- Simplified SwiftFormat for Xcode app interface (big thanks to @VinceBurn for the UI implementation)

## [0.39.5](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.39.5) (2019-03-06)

- Fixed bug in `braces` rule where closing brace was not wrapped onto a new line
- Fixed bug with `braces` rule affecting closures inside a `switch` statements
- Relative indentation is now preserved inside multiline comment blocks
- Fixed indenting of `switch` cases using Swift 5's new `@unknown` attribute 
- Fixed some errors in documentation and warning messages
- The .swift-version file parser now permits cases like `3.0-PREVIEW-4`
- Fixed the performance test target, which was broken in Xcode 10.1

## [0.39.4](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.39.4) (2019-03-03)

- Added support for Swift 5's new raw string syntax
- Now correctly detects .swiftformat and .swift-version files placed anywhere in the input path
- The swiftformat command-line tool will no longer fail with an error if all matched files were ignored
- Fixed bug where `braces` rule failed to correctly apply Allman indenting to `switch`  statements
- Disabled the `isEmpty` rule again by default (you can enable it using `--enable isEmpty`)

## [0.39.3](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.39.3) (2019-02-15)

- Fixed a bug with `hoistPatternLet` rule for switch cases without a space
- Fixed a bug in the `typeSugar` rule when referencing nested types
- The .swiftformat configuration file type is now associated with the SwiftFormat for Xcode app

## [0.39.2](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.39.2) (2019-02-14)

- Fixed bug with indenting multi-line strings (introduced in 0.39.1)
- Fixed `redundantParens` bug (introduced in 0.39.1)
- Corrected documentation for `specifiers` rule

## [0.39.1](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.39.1) (2019-02-12)

- Fixed some cases where `redundantParens` failed to remove redundant parentheses
- Fixed rare instance where `indent` rule could incorrectly indent multiline string literals
- Added `Rules.md` file to the repository, providing permalinks to the documentation for each rule
- Rules documentation is now generated automatically from the SwiftFormat source code
- The Xcode Extension app now shows tooltips for rules in the Rules tab
- Fixed unit test failure in certain timezones

## [0.39.0](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.39.0) (2019-02-04)

- Added `redundantFileprivate` rule, which replaces `fileprivate` with `private` where possible
- Added `redundantExtensionACL` rule, to remove redundant access level keywords inside extensions
- Added `typeSugar` rule to replace Array, Dictionary and Optional types with shorthand forms
- Added `redundantObjc` rule, which removes unnecessary `@objc` annotations
- Added `—selfrequired` option for excluding `@autoclosure` arguments from `redundantSelf` rule
- The `isEmpty` rule is now enabled by default, as the risk of false positives is fairly low
- Enhanced the `fileHeader` rule with macros for file name and creation date
- Added AppleScript integration instructions (thanks to @Lutzifer)

## [0.38.0](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.38.0) (2019-01-29)

- Added support for building, running and testing SwiftFormat on Linux
- Added `--swiftversion` option for version-specific features 
- Added `anyObjectProtocol` rule to replace `class` with `AnyObject` in protocol declarations
- Added `redundantBreak` rule that removes unneeded breaks from switch cases
- Added `strongifiedSelf` rule which removed backticks in `if let ``self`` = self {}`
- The `redundantReturn` rule now removes void returns as well as ones that return a value
- Renamed some option values for consistency
- The Xcode Extension app now shows tooltips on Options tab

## [0.37.5](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.37.5) (2019-01-24)

- Fixed another regression in the `redundantReturn` rule

## [0.37.4](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.37.4) (2019-01-22)

- Fixed a regression in the `redundantReturn` rule, causing `return` to be removed when it shouldn't

## [0.37.3](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.37.3) (2019-01-19)

- Fixed bug in `wrapArguments` rule when using the `after-first` mode
- The `elseOnSameLine` rule no longer discards comments between clauses
- Fixed bug with `redundantBackticks` incorrectly stripping backticks inside keyPaths
- Wrapped closure chains inside a var declaration are now wrapped correctly
- Fixed some cases where `redundantReturn` rule was not being applied
- Fixed bug with `braces` rule affecting nested closures

## [0.37.2](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.37.2) (2019-01-01)

- Fixed codesign issues with bundled binaries
- Significantly improved performance when using globs/wildcards in `--exclude` rules
- Added glob syntax documentation to README file

## [0.37.1](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.37.1) (2018-12-18)

- Fixed a bug in the `isEmpty` rule when used inside a function argument
- Fixed bug where log messages included ANSI codes in non-terminal stderr output

## [0.37.0](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.37.0) (2018-12-17)

- Added `isEmpty` rule, which converts instances of `if foo.count == 0 {}` to `if foo.isEmpty` (disabled by default)
- Added `redundantLetError` rule, which removes `let error` from `catch let error {}` because it's implicit
- The `todos` rule now converts `/// MARK:` to `// MARK:`, as the former isn't recognized by Xcode
- Fixed problem with the performance tests target not building locally in Xcode 10.1

## [0.36.0](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.36.0) (2018-12-15)

- Fixed `--exclude` globs matching path prefix instead of whole path (this may break exclude paths that relied on the bug)
- Added new `andOperator` rule for replacing `&&` with `,` in `if`, `while` and `guard` statements
- Added `init-only` option for the `--self` argument, to enable explicit `self` only inside initializers
- Significantly improved performance when using complex `--exclude` rules
- Fixed infinite loop bug in `redundantSelf` rule relating to properties named "type"
- Fixed caching mechanism which was broken by an earlier Swift update
- Fixed spurious error message when `--exclude` option matched no files

## [0.35.10](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.35.10) (2018-12-13)

- Removed spurious `--verbose` argument warning
- Non-swift files are no longer logged as skipped in `--verbose` mode
- Fixed bug with comment indenting inside switch statements
- Fixed crash in wrapArguments rule

## [0.35.9](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.35.9) (2018-11-28)

- Fixed incorrect formatting of generic arguments containing function types
- Fixed inconsistent capitalization of the swiftformat executable in Package.swift

## [0.35.8](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.35.8) (2018-11-23)

- Updated `void` rule to support changes introduced in Swift 4
- Fixed a bug where `#endif` could be incorrectly indented if followed by a comment
- Added `--importgrouping` option to group imports inside by `@testable`
- Fixed a potential bug when loading options in the SwiftFormat for Xcode GUI

## [0.35.7](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.35.7) (2018-10-11)

- Fixed error when tokenizing an `enum` declaration with a `where` clause
- Fixed bug with spacing around an infix operator used before the `#file` keyword
- Fixed bug where `self` was incorrectly removed inside property getters/setters

## [0.35.6](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.35.6) (2018-09-29)

- Fixed bug where `self` could be incorrectly removed inside `#if` blocks
- Fixed some bugs when inserting or removing `self` inside `didSet` handlers
- The `strongOutlets` rule now ignores properties named `delegate` or `dataSource`
- The `wrapCollections` rule now behaves more consistently with nested collection literals
- Added "Open Recent" menu item to the SwiftFormat for Xcode app

## [0.35.5](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.35.5) (2018-09-08)

- Fixed a bug in `redundantParens` rule that affected closure types that take a single tuple argument

## [0.35.4](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.35.4) (2018-09-05)

- Added glob support (unix-style wildcard file pattern matching) for `--exclude` paths
- Added `--quiet` option to disable noncritical output messages when using the swiftformat CLI
- Fixed a bug where an `import func ...` statement caused the `redundantSelf` rule to loop indefinitely
- Disabled ANSI formatting for stderr if stdout is pointing to a terminal interface but stderr isn't
- SwiftFormat is now more tolerant of white space around paths in a .swiftformat configuration file
- A .swiftformat file generated by SwiftFormat will now always end with a linebreak 

## [0.35.3](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.35.3) (2018-08-21)

- Added `--closingparen` option for finer control over function argument wrapping
- Fixed bug in wraparguments/collections options inference
- Skipped files are now logged when running with the `--verbose` option
- SwiftFormat no longer mangles XCUITest tokens in comments by introducing spaces
- Dictionary values wrapped onto a different line from the key are now indented correctly
- Fixed a bug where automatic removal of spaces around range operators could introduce ambiguity
- Disabled ANSI formatting for non-terminal output
- Fixed typo in command-line help

## [0.35.2](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.35.2) (2018-08-10)

- Fixed a bug where `--rules` command incorrectly showed all rules as disabled
- Added close button to SwiftFormat for Xcode application window 

## [0.35.1](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.35.1) (2018-08-08)

- Added support for hierarchical config files with a standard naming convention (see README for details)
- You can now specify excluded file paths and file options such as `--symlinks` in configuration files 
- Standard .swiftformat configuration files are now visible in the SwiftFormat for Xcode open/save dialogs
- The .swiftformat configuration file can now contain comments, which are marked using a hash (#) character
- Improved cache invalidation. It should no longer be necessary to disable the cache in some cases
- Removed Indent from the SwiftFormat for Xcode options, as this is configured using Xcode project settings
- Fixed indent inference (really this time!)

## [0.35.0](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.35.0) (2018-08-04)

- Added `--config` argument for loading an external config file using the command-line tool
- The `--inferoptions` command can now write the result to a config file using the `--output` option
- Added `emptyBraces` rule for removing blank lines inside empty `{}` pairs
- Fixed handling of spaces and other special characters inside the `--header` option when using config files
- Fixed parsing and serialization of `--header` option in Xcode Source Editor Extension
- Fixed a bug in the `specifiers` rule affecting enum cases whose name matches a specifier
- Fixed bug where `redundantSelf` could incorrectly remove `self` from a closure instead a case with a `where` clause
- Fixed indent inference, which would previously calculate the wrong indent value

## [0.34.1](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.34.1) (2018-08-01)

- Added `// swiftformat:disable:next` directive for temporarily disabling a rule on just the following line
- Fixed bug where the `// swiftformat:disable all` directive could result in file contents being stripped
- Fixed a bug where `--verbose` mode incorrectly reported which rules were applied to each file
- Reset to Defaults menu item in SwiftFormat for Xcode now correctly resets the Infer Format Options setting

## [0.34.0](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.34.0) (2018-07-30)

- You can now configure format options for the Xcode Source Editor Extension (big thanks to @vinceburn for this feature)
- Restored ability to build the swiftformat command-line app using Xcode 9.2 on macOS Sierra
- Xcode Source Editor Extension no longer fails when using Playgrounds with multiple pages 
- The `--wrapelementss` option has been renamed to `--wrapcollections`
- Added new `--wraparguments preserve` and `--wrapcollections preserve` options
- Added `--fractiongrouping` & `--exponentgrouping` options
- Improved formatting of Xcode Source Editor Extension error messages
- Fixed a bug where parens were incorrectly removed after an image literal

## [0.33.13](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.33.13) (2018-07-25)

- Fixed bug where required parens were incorrectly removed from around a closure type
- Added `--lint` mode that is similar to `--dryrun` but returns a non-zero exit code if any files require formatting
- The swiftformat command-line tool now returns a non-zero exit code in the event of a fatal error while formatting

## [0.33.12](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.33.12) (2018-07-23)

- Added `swiftformat:disable all` and `swiftformat:enable all` directives
- Fixed a bug where redundant parens were not always removed correctly
- Fixed errors when parsing custom operators such as `<>`, `|>` or `<<>>`
- Fixed divide-by-zero crash when specifying number groupings with a value of zero
- Rules are now always applied in alphabetical order to ensure consistency
- Fixed the `--conflictmarkers` command-line option

## [0.33.11](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.33.11) (2018-07-05)

- Fixed a bug where `--inferoptions` would always set `--self` to "insert" (this also affected the Xcode extension)
- Fixed bug with `redundantSelf` when parsing nested switch statements
- Fixed a bug in the `redundantParens` rule that incorrectly removed parens after an indexed tuple (e.g. `foo.1(bar)`)
- Spaces are now correctly removed around parens or square brackets after an indexed tuple

## [0.33.10](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.33.10) (2018-07-03)

- Fixed a bug where `sortedImports` rule could strip code between `import` statements
- Fixed a case where `self` was removed incorrectly inside a switch case condition

## [0.33.9](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.33.9) (2018-07-01)

- Fixed incorrect formatting of `!=` operator when used as a function reference
- Fixed some additional cases where `self` was not inserted or removed correctly

## [0.33.8](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.33.8) (2018-06-25)

- Fixed issue where `self` could be incorrectly inserted inside a `where` clause
- Fixed a bug where generics could be misidentified as greater-than / less-than operators
- Fixed formatting of `#if` blocks around case statements
- The `hoistPatternLet` rule no longer hoists the `let or `var` when there are no named variables
- Fixed nondeterministic behavior when applying spacing rules
- Fixed warning when compiling with Xcode 10 beta

## [0.33.7](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.33.7) (2018-05-18)

- Fixed an issue where headerdoc comments could be stripped by `fileHeader` rule
- Fixed a bug with handling absolute paths

## [0.33.6](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.33.6) (2018-04-18)

- Fixed a bug where a space could be incorrectly removed after a `try?` or `as?` operator
- Both the SwiftFormat command line tool and framework can now be built using Swift Package Manager
- Added .pre-commit-hook.yaml file for checking that formatter has been applied when committing
- The SwiftFormat command line tool can now be installed using Mint (see README for details) 

## [0.33.5](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.33.5) (2018-03-16)

- Fixed critical bug in `sortedImports` where code between blocks of import statements could be removed
- Fixed bug where wrapped arguments could be double-indented under some circumstances

## [0.33.4](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.33.4) (2018-02-26)

- Fixed a bug in the `unusedArguments` rule that could caused type names to get mangled in closure argument lists
- Fixed bug in `sortedImports` that could cause import statement to be moved above the file header comment

## [0.33.3](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.33.3) (2018-02-21)

- Fixed a bug in the `duplicateImports` rule that caused imports of specific types from the same module to be incorrectly stripped
- Fixed bugs with how the `duplicateImports` and `sortedImports` rules handle imports separated by semicolons or spanning multiple lines 
- Fixed a bug with `redundantParens` rule incorrectly removing parens around tuples whose first and last elements were closures
- Fixed a bug where the `redundantParens` rule incorrectly removed parens inside compound expressions

## [0.33.2](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.33.2) (2018-02-20)

- The `fileHeader` rule can now be disabled in an individual file by prefixing header with `// swiftformat:disable fileHeader`
- Fixed a bug in the `specifiers` rule that could mangle code if the previous line ended with certain identifiers
- Fixed typo in `--insertlines` deprecation warning message

## [0.33.1](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.33.1) (2018-02-10)

- Fixed bug preventing host app rule configuration from being read by the Xcode extension
- Added `duplicateImports` rule for removing duplicate import statements automatically
- Deprecated `--insertlines`/`--removelines` options - enable or disable the specific rules instead
- Fixed deprecation warnings in Swift 4.1 / Xcode 9.3

## [0.33.0](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.33.0) (2018-02-01)

- Added rules configuration UI to the Xcode Source Editor Extension (thanks @vinceburn and @tonyarnold!)
- Added `blankLinesAtStartOfScope` rule for removing leading blank lines at the start of functions, classes, etc
- Fixed indenting of blank lines within commented code blocks
- Added CONTRIBUTING.md

## [0.32.2](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.32.2) (2018-01-12)

- Fixed bug with parsing spaces inside interpolated values in multiline string literals
- Added instructions for using SwiftFormat on a CI server with Danger

## [0.32.1](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.32.1) (2017-12-07)

- Added `--dryrun` option, for testing SwiftFormat without making any file changes
- Fixed Xcode plugin, which was not deployed correctly in the previous release
- Fixed `spaceAroundOperators` rule not inserting space after a switch case or default clause colon

## [0.32.0](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.32.0) (2017-11-29)

- Added `swiftformat:` comment directives for enabling/disabling rules inside a source file (see README for details)
- Added `blankLinesAroundMark` rule, which inserts a blank line before and after a `// MARK:` comment
- When using the `--self insert` option, `self` is now inserted automatically in more places than it could be before
- Fixed some bugs in the `redundantSelf` rule that caused `self` not to be removed in some cases when it should
- Exposed the command-line formatting functions as part of the public API when using the SwiftFormat framework

## [0.31.0](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.31.0) (2017-11-24)

- Switched to a more conventional MIT license
- Added `strongOutlets` rule that removes weak from `@IBOutlet` properties in accordance with Apple guidelines
- Added `sortedImports` rule for sorting `import` statements alphabetically
- Fixed warnings in Xcode 9.1 and dropped support for compiling framework with Swift 3.1
- Fixed a bug where a double quote was incorrectly inserted into multiline strings
- Fixed a bug where the `--comments ignore` option was ignored for comments inside `switch` statements
- Code that has been temporarily commented out should no longer be re-indented

## [0.30.2](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.30.2) (2017-11-19)

- Fixed incorrect indenting of case statements for cases with `where` clauses containing `<` operator
- Fixed bug where parens were incorrectly removed around closures in loop or branch conditions
- Added compatibility workaround for `self` being incorrectly removed in tests that use the Nimble framework

## [0.30.1](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.30.1) (2017-11-10)

- Fixed error when parsing a subscript with default value inside a `switch` statement
- Nil default values are no longer removed inside `Codable` structs/classes, as this can break the implementation

## [0.30.0](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.30.0) (2017-10-27)

- Space is now inserted between the operator name and opening paren in an operator function declaration
- Added `--operatorfunc` option to control whether operator should be followed by a space in a function declaration
- Added `--elseposition` option to control whether `else`, `catch` & `while` should appear on same line as preceding `}`
- Added `--indentcase` option to control whether `case` statements should be indented inside a `switch`
- Comments immediately before a `default:` clause are now indented level with the `default` keyword
- Fixed bug where backticks would be incorrectly removed when using ``Any`` as an identifier
- Error messages are now displayed correctly in the Xcode editor extension
- Added test coverage statistics using Slather and Coveralls

## [0.29.9](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.29.9) (2017-10-22)

- Fixed critical bug where `hoistPatternLet` rule could corrupt tuples in a switch case clause
- Comments immediately before a case statement are now indented level with the case

## [0.29.8](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.29.8) (2017-10-11)

- Fixed bug where space was incorrectly removed around postfix/suffix range operators

## [0.29.7](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.29.7) (2017-10-08)

- Added support for Swift 4 keyPath syntax

## [0.29.6](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.29.6) (2017-09-21)

- Fixed bug in `hoistPatternLet` rule when formatting `case let` patterns with outer parens
- The `redundantParens` rule now correctly removes the outer parens in the aforementioned case
- Fixed performance regression introduced in 0.29.5

## [0.29.5](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.29.5) (2017-09-04)

- Fixed bounds crash when parsing an empty string literal at the end of a file
- SwiftFormat now compiles without modification in Xcode 9 using Swift 3.2 or 4.0

## [0.29.4](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.29.4) (2017-08-21)

- Fixed a bug where `self` could be incorrectly inserted if local variable is declared inside an `#if` block

## [0.29.3](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.29.3) (2017-07-31)

- Added support for Swift 4's multi-line string literal syntax
- Fixed a bug with handling inline comments inside an array literal

## [0.29.2](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.29.2) (2017-07-03)

- Fixed critical bug where space was incorrectly inserted around unary range operators
- Fixed bug where `self` could be incorrectly inserted before `type(of:)` if using `--self insert` option
- Fixed space being incorrectly inserted after postfix operator inside a subscript or collection literal
- Wrapped `case is Type` statements are now indented correctly

## [0.29.1](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.29.1) (2017-06-29)

- Fixed bug where `redundantInit` rule removed a required init in some cases

## [0.29.0](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.29.0) (2017-06-20)

- Changed specifier order from `private(set) public` to `public private(set)`
- Added `redundantInit` rule to remove explicit `init` references where they aren't needed
- Fixed indentation of class declarations with protocols wrapped onto multiple lines

## [0.28.6](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.28.6) (2017-05-31)

- Fixed bug where consecutive `if` statements containing `<` and `>` were misidentified as a generic argument list
- Fixed space being removed between a closure capture list and subsequent arguments under some circumstances
- Fixed extra space added before prefix operators inside brackets or parens

## [0.28.5](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.28.5) (2017-05-14)

- The `redundantParens` rule no longer removes parens after a function call inside a `where` clause
- Fixed bug where nil default value was incorrectly removed from lazy var declarations

## [0.28.4](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.28.4) (2017-04-26)

- Fixed bug where `self` was incorrectly inserted inside an `if case let` condition
- Fixed incorrect insertion of `self` inside a pattern let clause

## [0.28.3](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.28.3) (2017-04-20)

- Fixed bug where `self` was incorrectly removed in a closure immediately after a var declaration
- Fixed incorrect insertion of `self` before a subscript `get` or `set` block
- Fixed incorrect insertion of `self` after an `import class` statement
- Fixed bug where `self` was not inserted after a return statement

## [0.28.2](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.28.2) (2017-03-30)

- Fixed error when parsing an `enum` declaration inside a `switch` statement
- Fixed incorrect removal of backticks when accessing an overloaded `Type` member

## [0.28.1](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.28.1) (2017-03-28)

- Fixed a bug where `redundantSelf` rule incorrectly removed `self` after a `repeat...while` loop
- Fixed some bugs where `--self insert` option wrongly added `self` in places it shouldn't have
- Improved the documentation of rules and options in the README file and command-line help

## [0.28.0](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.28.0) (2017-03-24)

- Added `--self insert` option to optionally insert `self` when accessing member variables/functions
- The `--self` and `--stripunusedargs` arguments can now be inferred automatically using `--inferoptions`
- SwiftFormat now detects and rejects source files that contain merge conflict markers
- Added `--conflictmarkers` option to optionally ignore conflict markers (e.g. if they clash with a custom operator)
- The `redundantSelf` rule now correctly strips `self` from computed var setters and getters
- The `redundantSelf` rule now handles static and class variables/functions correctly
- Fixed a potential bug where command-line tool might get stuck in an infinite loop
- Fixed a bug where a invalid source code could causes variables to be incorrectly removed
- Fixed some bugs in error reporting

## [0.27.1](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.27.1) (2017-03-21)

- Fixed trailing space that was incorrectly added to blank lines when `redundantSelf` rule is disabled
- Fixed a bug where `self` could be incorrectly removed when using nested function declarations
- Fixed a bug where `self` could be incorrectly removed inside class functions
- Improved formatting and inferoptions performance

## [0.27.0](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.27.0) (2017-03-17)

- Added `--exclude` command-line option for excluding specific files or folders from formatting
- Improved grouping and logging of formatting errors when running in `--verbose` mode
- Fixed a bug when using prefix operators with with shorthand class or enum members like `-.someValue`
- Fixed some more cases where `self` was incorrectly removed, or wasn't removed when it should have been
- Fixed some cases where backtick escaping was incorrectly removed around reserved words
- Fixed a bug where `--patternlet inline` could incorrectly move `let` inside a tuple assignment
- Fixed parsing of custom operators containing chevrons, e.g. `<?>`
- Fixed redundant `return` not being removed from closures in a var declaration
- Fixed a performance regression introduced in version 0.26.2
- Fixed bug where `Void()` literal was replaced by `()()` when using `--empty tuple`

## [0.26.2](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.26.2) (2017-03-15)

- Fixed critical bug where `return` was incorrectly removed after a `#selector` or `#keyPath` directive
- Fixed several more critical cases where `self` could be incorrectly removed
- Fixed case where identifier could be mistaken for a keyword after `self` was removed
- Fixed some cases where `self` should have been removed but wasn't
- Added tvOS support to the podspec

## [0.26.1](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.26.1) (2017-03-14)

- Fixed critical bug where `self` could be incorrectly removed inside lazy var declarations

## [0.26.0](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.26.0) (2017-03-13)

- Added `redundantSelf` rule for removing the `self` prefix from member references in cases where it isn't needed
- Added `--verbose` command-line option for tracking which rules were applied to each file
- Added `--patternlet` command-line option for toggling behavior of the `hoistPatternLet` rule
- Fixed bug where escaped arguments were treated as unused
- Fixed some `unusedArguments` cases
- The `redundantBackticks` rule now handles more cases

## [0.25.2](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.25.2) (2017-03-09)

- Fixed bug where `return` keyword could be incorrectly removed inside a conditional statement
- Fixed bug where backtick escaping would be incorrectly removed from `Self`

## [0.25.1](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.25.1) (2017-03-08)

- Fixed bug where unused arguments in a failable initializer could be incorrectly formatted
- Fixed bug where backtick escaping would be incorrectly removed from certain reserved identifiers

## [0.25.0](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.25.0) (2017-03-07)

- The `stripHeaders` rule is now `fileHeaders`, which can strip or replace header comments with a template (see README)
- Added `hoistPatternLet` rule that moves `let` and `var` to the beginning of `switch/case` patterns
- Added `redundantReturn` rule that strips the `return` keyword from single-line closures
- Added `redundantBackticks` rule that removes unnecessary backtick escaping of keywords

## [0.24.7](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.24.7) (2017-02-28)

- Fixed a bug where switch cases containing a `..<` operator were parsed incorrectly, resulting in wrong indentation
- Fixed a potential bug where source code could be truncated after an error when running with `--fragment` enabled
- Command-line tool installation via CocoaPods no longer requires a minimum deployment target of iOS 9 / macOS 10.11

## [0.24.6](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.24.6) (2017-02-16)

- Fixed critical bug where automatic removal of Void return type in closures could alter the type signature
- Command-line tool can now be installed via CocoaPods

## [0.24.5](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.24.5) (2017-02-12)

- Fixed critical bug where trailing commas were incorrectly added to array or dictionary type declarations

## [0.24.4](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.24.4) (2017-02-09)

- Fixed format rules not being applied when processing input from stdin
- Fixed allman brace formatting of optional computed vars
- Allman brace rule now removes the blank line immediately after an opening brace

## [0.24.3](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.24.3) (2017-01-26)

- Fixed critical bug where unused `inout` closure arguments were mangled
- Fixed critical bug where comma was incorrectly inserted into subscript expressions
- Fixed critical bug where functions named "get" could be incorrectly stripped 
- Unused arguments are now handled correctly in `init` and `subscript` functions
- Fixed bug where `_` was doubled up for unused closure arguments

## [0.24.2](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.24.2) (2017-01-20)

- Unused arguments are now handled correctly in non-Void functions
- Fixed another bug where keywords used as function argument names were not parsed correctly
- Fixed bug when parsing generics containing a `&` protocol-combining operator
- Fixed bug where parsing error location was reported incorrectly

## [0.24.1](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.24.1) (2017-01-19)

- Fixed crash in Xcode extension when formatted file has no changes
- Fixed caching bug that meant enabled/disabled rules were not taken into account
- Unix shebang/hashbang directive at start of a source file is no longer treated as an error

## [0.24](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.24) (2017-01-18)

- Fixed a critical bug where closure arguments could be mangled by the `unusedArguments` rule
- Added `trailingClosures` rule, to automatically convert closure arguments to trailing closure syntax
- Added `--enable` option to enable optional rules such as `trailingClosures` (which is disabled by default)
- Added `--stripunusedargs` option to provide more fine-grained control of the `unusedArguments` rule
- Added `--decimalgrouping`, `--hexgrouping`, `--binarygrouping` and `--octalgrouping` options
- Added `--exponentcase` option for controlling the case of "e" in exponential literals, e.g. `3.4e-5`
- Merged `hexLiterals` rule into new `numberFormatting` rule that handles case and grouping of numbers
- Renamed `--hexliterals` option to `--hexliteralcase`
- The `void` rule now converts `(_: Void)` to `()` automatically
- The `redundantParens` rule now removes empty `()` before a trailing closure
- Fixed some bugs with floating-point hex literal support
- Fixed bug where keywords used as function argument names were not parsed correctly
- Added Swift Package Manager support

## [0.23.1](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.23.1) (2017-01-14)

- Fixed critical bug where closure return types could be mangled by the `unusedArguments` rule
- Fixed issue where console text appeared as black instead of the user's chosen default color

## [0.23](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.23) (2017-01-09)

- You can now specify a whitelist of specific rules to apply using the `--rules` option
- Input files are now processed concurrently, yielding a ~2x speed improvement
- SwiftFormat now continues if it encounters an error when processing multiple files
- Improved error messaging, and added color-coding to the command-line output
- `--inferoptions` now accepts multiple space-delimited file paths, or piped input, just like formatting
- `redundantVoidReturnType` now removes Void return from closures as well as ordinary functions
- `unusedArguments` now works on closures as well as ordinary functions
- `unusedArguments` is now more effective at detecting when an argument is unused 
- Fixed crash in `wrapArguments` rule due to linebreak being incorrectly removed after a single-line comment
- Format rules displayed using the `--rules` option are now sorted alphabetically

## [0.22](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.22) (2017-01-03)

- Fixed critical bug where `>=` operator was misidentified as end of generic argument list
- Added `redundantRawValues` rule to remove string enum literals that match the associated case name
- Added `redundantVoidReturnType` rule to remove unnecessary `Void` return type from function declarations
- Added `unusedArguments` rule, to replace unused arguments in function declarations with an underscore
- Fixed bug with `--inferoptions` and argument wrapping
- Fixed bug where extra space was added inside empty `TODO:` comments

## [0.21](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.21) (2016-12-19)

- Added `redundantLet` rule to remove unnecessary `let` keyword in statements like  `let _ = foo()`
- Added `redundantPattern` rule to simplify wildcard patterns like `.foo(_, _)` to just `.foo`
- Rules are now run repeatedly until no changes are detected, fixing an issue where changes could be missed
- Fixed a bug where extra space was inserted between `?` and `.` in optional chaining expressions
- A space is no longer added between a comment and the following comma
- Fixed some performance regressions

## [0.20](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.20) (2016-12-09)

- Added `redundantNilInit` rule, to remove unnecessary nil initialization of Optional vars
- The `trailingCommas` rule now removes trailing commas for inline array literals
- Fixed bug in `void` rule when handling chains of throwing functions
- Fixed some performance regressions

## [0.19](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.19) (2016-12-02)

- Fixed a critical bug where `redundantParens` rule failed to insert space before a prefix operator
- Fixed a crash when encountering generic arguments followed by ...
- Added `--disable` option for individually disabling rules without needing to recompile
- Added `--rules` command to display all the supported rules (useful in conjunction with `--disable`)
- Added `--wraparguments` option for controlling how function arguments are wrapped
- Added `--wrapelements` option for controlling how array and dictionary elements are wrapped
- Added `--symlinks` option for specifying if symlinks/aliases should be followed and formatted
- Fixed bug where symlinks to Swift files would be replaced by a copy of the file

## [0.18](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.18) (2016-11-17)

- Added `--inferoptions` command line argument for auto-configuring format options from existing source
- Added `--ifdef` command line argument for controlling how `#if`...`#endif` clauses are indented
- Added `--hexliterals` command line argument for specifying the case to use for hex literals
- Added `redundantGet` rule to remove unneeded `get {}` clause in read-only computed properties
- Fixed bug where `redundantParens` rule merged identifiers on either side of a removed paren
- `redundantParens` now removes unneeded parens from expressions and closure arguments

## [0.17.2](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.17.2) (2016-11-11)

- Fixed critical bug with `redundantParens` rule removing required parens around a closure
- Fixed bug with indenting of wrapped closures after a var declaration

## [0.17.1](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.17.1) (2016-11-09)

- Xcode Source Editor Extension now works with Playground files
- Fixed operator being incorrectly formatted when file ends with a single-line comment
- Fixed bug where the space at the start of a single line comment could increase after each format
- Fixed bug where `--cache clear` just ignored cache without actually clearing it
- Added `--cache ignore` option, which replicates previous `--cache clear` behavior

## [0.17](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.17) (2016-11-08)

- Added cache, allowing SwiftFormat to skip formatting for files that haven't changed
- Added `stripHeaders` rule to remove Xcode's copyright header comments (off by default)
- Disabled `linebreakAtEndOfFile` rule when formatted text is a fragment
- Fixed bug where generics were wrongly formatted if followed by a greater-than sign in the same file
- Fixed space incorrectly added after `#available`, `#colorLiteral`, etc
- Fixed several bugs with indenting of blocks containing wrapped lines

## [0.16.4](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.16.4) (2016-11-07)

- SwiftFormat is now ~3X faster!
- Fixed bug with spacing after an `@convention()` attribute
- Fixed bug where the space at the start of a multi-line comment could increase after each format
- Fixed bug where wrong indent was applied to wrapped array literal values
- Fixed bug where K&R indenting would remove the linebreak before an inline block

## [0.16.3](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.16.3) (2016-11-03)

- Fixed bug with operators containing chevrons
- Fixed wrong indent after where statement in switch case

## [0.16.2](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.16.2) (2016-11-03)

- Fixed bug with spacing of deeply nested generic arguments, or generic operator functions
- Fixed spacing of `@autoclosure(escaping)` syntax (only used in Swift 2.2)
- Fixed bug where `(Void) throws -> Void` was handled incorrectly

## [0.16.1](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.16.1) (2016-11-03)

- Fixed critical bug where `redundantParens` would remove parens from tuple in `switch` condition
- Fixed incorrect spacing around attributes that have arguments, e.g. `@convention(block)`
- `--comments ignore` command line option now disables leading space insertion in single-line comments

## [0.16](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.16) (2016-11-02)

- Added `redundantParens` rule to remove parens around `if`, `while` and `switch` conditions
- Added ability to specify multiple file paths for processing in a single command
- Fixed a bug with the formatting of `repeat ... while` loops
- Added performance tests
- API refactoring

## [0.15](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.15) (2016-10-27)

- Added `allman` command line option to enable Allman-style indenting instead of default K&R style
- Added `removelines` command line option to disable automatic removal of blank lines
- Added `insertlines` command line option to disable automatic blank line insertion
- Added `trimwhitespace` command line option for disabling truncation of blank lines
- Added `comments` command line option for disabling indenting of comments
- Added `experimental` command line option for opting-in to bleeding-edge features
- Fixed broken `commas` command line option from version 0.14
- Made `blankLinesBetweenScopes` rule less aggressive

## [0.14](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.14) (2016-10-21)

- Xcode Source Editor Extension now automatically infers formatting options from the file
- Wrapped function arguments and array/dictionary literal value indenting now works more like Xcode
- Added `void` rule for normalizing how `Void` return values are represented
- Added `empty` command line option for configuring the void rule
- Added `commas` command line option for disabling trailing commas
- Improved formatting of fragments containing unbalanced braces

## [0.13](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.13) (2016-10-17)

- Added Xcode Source Editor Extension (thanks @tonyarnold!)
- Fixed indenting of the line after a return statement (which is treated as the return value)

## [0.12.1](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.12.1) (2016-10-14)

- Fixed stripping of space after `@escaping`, `@autoclosure` and `inout`
- Fixed stripping of trailing linebreaks when using --fragment option

## [0.12](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.12) (2016-10-08)

- Linewrapped `case` elements are now vertically aligned
- The `else` keyword in a `guard` statement is no longer indented
- The `elseOnSameLine` rule is no longer applied if previous `} is not on its own line
- Fixed handling of `case` after comma in an `if` statement
- Added support for formatting partial file fragments
- Reduced compilation time by ~500ms

## [0.11.4](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.11.4) (2016-10-05)

- Fixed critical bug where optionals with a default value were not handled correctly
- Fixed rare bug where code would be incorrectly indented after a custom operator declaration

## [0.11.3](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.11.3) (2016-10-04)

- Fixed spacing between closure capture list and arguments
- Fixed incorrect indenting of closures after an `if` statement, and other braced clauses

## [0.11.2](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.11.2) (2016-10-04)

- Fixed incorrect indenting of closures inside `for` loops, and other braced clauses

## [0.11.1](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.11.1) (2016-10-04)

- Fixed incorrect wrapping of chained closures
- Improved the logic for wrapped lines; now behaves more like Apple's implementation
- Fixed some bugs in command line tool when file paths contain escaped characters

## [0.11](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.11) (2016-09-24)

- Fixed handling of `prefix` and `postfix` specifiers
- Fixed bug where trailing comma was added to empty array or dictionary literal
- Fixed bug where trailing whitespace was added at the start of doc comments
- Improved correctness of numeric literal parsing
- Converted to Swift 3 syntax

## [0.10](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.10) (2016-09-18)

- The `blankLinesAtEndOfScope` rule no longer removes trailing blank lines if immediately followed by other code
- The `blankLinesBetweenScopes` rule now adds a blank line after a scope as well as before it
- The `blankLinesBetweenScopes` rule no longer affects single-line functions, classes, etc.
- Fixed formatting of `while case` and `for case ... in` statements
- Fixed bug when using `switch` as an identifier inside a `switch` statement
- Fixed parsing of numeric literals containing underscores
- Fixed parsing of binary, octal and hexadecimal literals

## [0.9.6](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.9.6) (2016-09-16)

- Fixed parsing error when `switch` statement is followed by `enum`
- Fixed formatting of `guard case` statements

## [0.9.5](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.9.5) (2016-09-14)

- Fixed a number of cases where the use of keywords as identifiers was not being handled correctly

## [0.9.4](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.9.4) (2016-09-14)

- Fixed bug where parsing would fail if a `switch/case` statement contained `default` or `case` identifiers (valid in Swift 3)

## [0.9.3](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.9.3) (2016-09-12)

- Fixed bug where functions would be prefixed with an additional blank line if the preceding line had a trailing comment

## [0.9.2](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.9.2) (2016-09-09)

- Fixed bug where `case` expressions containing a colon would not be parsed correctly

## [0.9.1](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.9.1) (2016-09-08)

- Fixed bug where `trailingCommas` rule would place comma after a comment instead of before it

## [0.9](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.9) (2016-09-07)

- Added `blankLinesBetweenScopes` rule that adds a blank line before each class, struct, enum, extension, protocol or function
- Added `specifiers` rule, for normalizing the order of access modifiers, etc
- Fixed indent bugs when wrapping code before or after a `where` or `else` keyword
- Fixed indent bugs when using an operator as a value (e.g. let greaterThan = >)

## [0.8.2](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.8.2) (2016-09-01)

- Fixed bug where consecutive spaces would not be removed in lines that appeared after a `//` comment
- SwiftFormat will no longer try to format code containing unbalanced braces
- Added pre-commit hook instructions

## [0.8.1]() (2016-08-31)

- Fixed formatting of `/*! ... */` and `//!` headerdoc comments, and `/*: ... */` and `//:` Swift Playground comments

## [0.8](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.8) (2016-08-31)

- Added new `ranges` rules that adds or removes the spaces around range operators (e.g. `0 ..< count`, `"a"..."z"`)
- Added a new `--ranges` command-line option, which can be used to configure the spacing around range operators 
- Added new `spaceAroundComments` rule, which adds a space around /* ... */ comments and before // comments
- Added new `spaceInsideComments` rule, which adds a space inside /* ... */ comments and at the start of // comments
- Added new `blankLinesAtEndOfScope` rule, which removes blank lines at the end of braces, brackets and parens
- Removed double blank line at end of file

## [0.7.1](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.7.1) (2016-08-29)

- Fixed critical bug where failable generic init (e.g. `init?<T>()`) was not handled correctly

## [0.7](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.7) (2016-08-28)

- swiftformat command-line tool now correctly handles paths with `\` escaped spaces, or paths in quotes
- Removed extra space added inside `@objc` selectors
- Fixed incorrect spacing for tuple bindings
- Fixed space before enum case inside closure

## [0.6](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.6) (2016-08-26)

- Refactored how switch/case is handled, and fixed a bunch of bugs
- Better indenting logic, now handles multiple closure arguments in a single function call

## [0.5.1](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.5.1) (2016-08-25)

- Fixed critical bug where double unwrap (e.g. `foo??.bar()`) was not handled correctly
- Fixed bug where `case let .SomeEnum` was not handled correctly

## [0.5](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.5) (2016-08-25)

- swiftformat command-line tool now supports reading from stdin/writing to stdout
- Added new `linebreaks` rule for normalizing linebreak characters (defaults to LF)
- More robust handling of linebreaks and whitespace within comments
- Trailing whitespace within comments is now stripped, as it was for other lines

## [0.4](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.4) (2016-08-24)

- Added new `semicolons` rule, which removes semicolons wherever it's safe to do so
- Added `--semicolons` command-line argument for enabling inline semicolon stripping
- The `todos` rule now corrects `MARK :` to `MARK:` instead of `MARK: :`
- Paths containing ~ are now handled correctly by the command line tool
- Fixed some bugs in generics and custom operator parsing, and added more tests
- Removed trailing whitespace on blank lines caused by the `indent` rule

## [0.3](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.3) (2016-08-23)

- Fixed several cases where generics were misidentified as operators
- Fixed a bug where a comment on a line before a brace broke K&R indenting
- Fixed a bug where a comment on a previous line caused incorrect indenting for wrapped lines
- Added new `todos` rule, for ensuring `TODO:`, `MARK:`, and `FIXME:` comments are formatted correctly
- Whitespace at the start of comments is now handled differently, but it shouldn't affect output

## [0.2](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.2) (2016-08-22)

- Fixed formatting of generic function types
- Fixed indenting of `if case` statements
- Fixed indenting of `else` when separated from `if` statement by a comment
- Changed `private(set)` spacing to match Apple standard
- Added swiftformat as a build phase to SwiftFormat, so I'm eating my own dogfood

## [0.1](https://github.com/nicklockwood/SwiftFormat/releases/tag/0.1) (2016-08-22)

- First release
