<p align="center">
    <a href="https://github.com/DevelopersToolbox/">
        <img src="https://cdn.wolfsoftware.com/assets/images/github/organisations/developerstoolbox/black-and-white-circle-256.png" alt="DevelopersToolbox logo" />
    </a>
    <br />
    <a href="https://github.com/DevelopersToolbox/bash-snippets/actions/workflows/pipeline.yml">
        <img src="https://img.shields.io/github/workflow/status/DevelopersToolbox/bash-snippets/pipeline/master?style=for-the-badge" alt="Github Build Status">
    </a>
    <a href="https://github.com/DevelopersToolbox/bash-snippets/releases/latest">
        <img src="https://img.shields.io/github/v/release/DevelopersToolbox/bash-snippets?color=blue&label=Latest%20Release&style=for-the-badge" alt="Release">
    </a>
    <a href="https://github.com/DevelopersToolbox/bash-snippets/releases/latest">
        <img src="https://img.shields.io/github/commits-since/DevelopersToolbox/bash-snippets/latest.svg?color=blue&style=for-the-badge" alt="Commits since release">
    </a>
    <br />
    <a href=".github/CODE_OF_CONDUCT.md">
        <img src="https://img.shields.io/badge/Code%20of%20Conduct-blue?style=for-the-badge" />
    </a>
    <a href=".github/CONTRIBUTING.md">
        <img src="https://img.shields.io/badge/Contributing-blue?style=for-the-badge" />
    </a>
    <a href=".github/SECURITY.md">
        <img src="https://img.shields.io/badge/Report%20Security%20Concern-blue?style=for-the-badge" />
    </a>
    <a href="https://github.com/DevelopersToolbox/bash-snippets/issues">
        <img src="https://img.shields.io/badge/Get%20Support-blue?style=for-the-badge" />
    </a>
    <br />
    <a href="https://wolfsoftware.com/">
        <img src="https://img.shields.io/badge/Created%20by%20Wolf%20Software-blue?style=for-the-badge" />
    </a>
</p>

## Overview

This is a collection of useful(ish) bash snippets. The snippets are all simple self-contained pieces of code (a class or subroutine), but non of them are large enough to require having a repository in their own right.

## Bash Snippets

| Name | Description |
| --- | --- |
| [abs.sh](src/abs/abs.sh) | The Math. abs() function returns the absolute value of a number. That is, it returns x if x is positive or zero, and the negation of x if x is negative. |
| [array-contains.sh](src/array-contains/array-contains.sh) | Check to see if an array contains a specific value. |
| [array-to-string.sh](src/array-to-string/array-to-string.sh) | Concert an array to a string with a custom seperator and a final optional value. | 
| [center-text.sh](src/center-text/center-text.sh) | Center any given text on the screen (optional define the screen width). |
| [check-prerequisites.sh](src/check-prerequisites/check-prerequisites.sh) | Check prerequisite commands are installed. |
| [compare-versions.sh](src/compare-versions/compare-versions.sh) | Compare two version strings with optional custom delimiter. |
| [contains.sh](src/contains/contains.sh) | Check to see if one string contains another. |
| [error-messages.sh](src/error-messages/error-messages.sh) | Display error, warning and success messages. |
| [get-confirmation.sh](src/get-confirmation/get-confirmation.sh) | Get user confirmation for an action. |
| [get-git-root.sh](src/get-git-root/get-git-root.sh) | Get the root directory of a given git repo (and handle correctly when it isn't a git repo). |
| [get-script-info.sh](src/get-script-info/get-script-info.sh) | Get information about a script (full path and script name). |
| [get-terraform-version.sh](src/get-terraform-version/get-terraform-version.sh) | Get the current terraform version. |
| [get-version-string.sh](src/get-version-string/get-version0string.sh) | Extra a symver version from a string. |
| [is-git-repo.sh](src/is-git-repo/is-git-repo.sh) | Check if a given directory contains a git repo. |
| [rollingback.sh](src/rollingback/rollingback.sh) | Using signals to create rollback functions for cleaner scripting. |
| [stacktrace.sh](src/stacktrace/stacktrace.sh) | Provide a stack trace for from main to the point of of calling the stacktrace. |
| [strict-mode.sh](src/strict-mode/strict-mode.sh) | An example of a 'strict' mode setup for bash scripts. |
| [sudo-librarian-puppet.sh](src/sudo-librarian-puppet/sudo-librarian-puppet.sh ) | Run librarian-puppet via sudo without changing default sudoers file (Debian 9 / Puppet 5). |
| [terminal-or-not.sh](src/terminal-or-not/terminal-or-not.sh) | A script to allow to determine if your script is attached to a terminal, pipe or redirection. |
| [untag.sh](src/untag/untag.sh) | A simple script to remove ALL tags from a git repo. |
| [using-colour.sh](src/using-colour/using-colour.sh) | An example of how to use colour (see [bash-colour-include](https://github.com/DevelopersToolbox/bash-colour-include) for a full working solution). |
| [using-set.sh](src/using-set/using-set.sh) | Using 'set' for more robust shell scripting. |
| [variable-replace.sh](src/variable-replace/variable-replace.sh) | Replace template variables in a file with values from an associative array. |
| [verbose-mode.sh](src/verbose-mode/verbose-mode.sh) | Demonstration of script wide verbose/silent mode. |

