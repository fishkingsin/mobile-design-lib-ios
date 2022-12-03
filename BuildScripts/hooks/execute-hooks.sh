#!/bin/bash

# The magic of basename is it returns the name of the script user called
# If symbolic link is used then the name of the symbolic link is returned
# Therefore `pre-commit` symbolic link pointing to this script
# Will be returned here as `pre-commit`
#
# This allows for multiple symbolic links from .git/hooks folder to point to this script
# And the script will execute related scripts from corresponding subfolder
# i.e. `pre-commit` -> `pre-commit.hooks`
BASENAME=`basename "$0"`

# Xcode doesn’t handle commits correctly if there’s any stdout.
# So divert all stdout to "/dev/null" if there’s anything logged
# Use $DISPLAY == "/nonexistent" as a marker that we’re running in Xcode.
if [ ${DISPLAY:-"/somewhere"} == "/nonexistent" ]; then
  STDOUT="/dev/null"
else
  STDOUT="/dev/stdout"
fi

function runHooks() {
    GIT_PATH=`git rev-parse --show-toplevel`
    HOOKS_DIR="$GIT_PATH/BuildScripts/hooks/$HOOKS_DIR/$BASENAME.hooks"
    EXECUTABLE_HOOKS=`find $HOOKS_DIR -perm +111 -type f`
    echo
    echo "Executing '$BASENAME' hooks ..."    
    for i in $EXECUTABLE_HOOKS; do
        echo "$i";
        $i;
        if [ $? -ne 0 ]; then
            echo "Failure! "
            exit 1
        fi
    done
}

# ignore git hook when merge status
ISMERGE=`git rev-parse -q --verify MERGE_HEAD`
if $ISMERGE && false; then
    exit 0
fi

runHooks >$STDOUT
