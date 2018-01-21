# XCode 9.2 Server build bot is unable to compile large projects

This repository is intended to demonstrate the bug reported to Apple as incident *36711458*.

It seems a build bot (tested with *XCode 9.2 (9C40b)*) is unable to compile a project if the number of files in a target exceeds some limit.

The branch *does_work* of this repository contains a target with 2099 files to be compiled. A build bot configured to integrate this branch is working:

![Screenshot of build phases](/Assets/Compiling_2099_files_succeeded/buildphases.png?raw=true)

![Screenshot of the successful integration](/Assets/Compiling_2099_files_succeeded/screenshot.png?raw=true)

If the 2100th file is added [to the target](https://github.com/chkpnt/ManyFiles/compare/does_not_work...does_work), the build is unable to succeed: According to the build [log](/Assets/Compiling_2100_files_failed/xcodebuild.log), the build phase `Compile Sources` is missing the step `CompileSwiftSources normal arm64 com.apple.xcode.tools.swift.compiler` which leads to a linker failure in a subsequent step:

![Screenshot of the unsuccessful integration](/Assets/Compiling_2100_files_failed/screenshot.png?raw=true)

You can find the log files in this repository under [Assets](/Assets).

Using *xcodebuild* on the command line is not failing in both cases.

## Assumption
I do not think the issue depends on the concrete number of files to be compiled: An other project I'm working with is able to be compiled by the build bot when its build target contains 1384 files, but a commit where the target contains 1392 files is failing in the same way as this project:
The number of files is less than here, but their file names are quite longer.

On my system `getconf ARG_MAX` results in 262144, maybe the build bot is reaching this limit.
