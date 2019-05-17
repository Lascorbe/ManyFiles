# XCode 10.2.x is unable to compile large Swift modules

Open radar link: http://www.openradar.me/50886131

## Summary:

When a Swift project is big enough, the build system generates a SwiftC command that does not fit the command line length on the host system (`ARG_MAX` limit), failing to build the project. SwiftC support passing parameters via response files (i.e., swiftc @foo.txt where foo.txt contains the arguments) just as clang and many other compilers do. So the compiler feature is present in Swift 5.0, but Xcode appears to still need to be updated to write its command line arguments to a @params file in order for it to work. Therefore, it is not possible to build large swift modules (between 1000-2000 swift files depending on the length of the project path).

Swift PRs fixing the issue can be found here:
- https://github.com/apple/swift/pull/15853
- https://github.com/apple/swift/pull/16362

Forum thread here:
https://forums.swift.org/t/swift-compilation-reaching-arg-max-limit-causing-xcode-build-failure/6494/3

Stackoverflow response with a summary of the issue:
https://stackoverflow.com/questions/48457585/zombie-archiving-failed-using-integration-menu/48525938#48525938

## Steps to Reproduce:

1. Clone https://github.com/Lascorbe/ManyFiles project (a fork of previous work by Gregor Dschung: https://github.com/chkpnt/ManyFiles).
2. Open ManyFiles.xcodeproj in Xcode
3. Build project
4. Build fails with error:

#### With the new build system

unable to spawn process (Argument list too long)

#### With the legacy build system

Build operation failed without specifying any errors. Individual build tasks may have failed for unknown reasons. One possible cause is if there are too many (possibly zombie) processes; in this case, rebooting may fix the problem. Some individual build task failures (up to 12) may be listed below.

## Expected Results:

Xcode builds the module.

## Actual Results:

Xcode fails to build the module.

## Version/Build:

Xcode 10.2.1 (10E1001)

## Configuration:

macOS 10.14.4, Swift 5
