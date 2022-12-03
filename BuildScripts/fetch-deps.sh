#!/bin/bash

set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# check swiftlint
export PATH="$PATH:/opt/homebrew/bin"
if which swiftlint > /dev/null; then
    echo "SwiftLint  installed"
else
    echo "warning: SwiftLint not installed, use local swiftlint instead"
    ln -s "$SCRIPT_DIR/swiftlint" "/usr/local/bin/swiftlint"
fi

if which swiftformat > /dev/null; then
    echo "Swiftformat  installed"
else
    echo "warning: Swiftformat not installed, use local Swiftformat instead"
    ln -s "$SCRIPT_DIR/swiftformat" "/usr/local/bin/swiftformat"
fi

# install git hooks
./BuildScripts/hooks/install.sh


