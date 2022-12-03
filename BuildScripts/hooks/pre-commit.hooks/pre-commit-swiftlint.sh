#!/bin/bash

# Git Hook for SwiftLint
# Runs at every commit and checks for an error.
# For the test, you can run `git commit` with an empty` commit message`
# https://github.com/aitemr/awesome-git-hooks/blob/master/pre-commit/pre-commit-swiftlint

export PATH=/usr/local/bin:$PATH

echo "SwiftLint Start..."
echo "$PWD"

# Export files in SCRIPT_INPUT_FILE_$count to lint against later
count=0
while IFS= read -r file_path; do
    export SCRIPT_INPUT_FILE_$count="$file_path"
    count=$((count + 1))
done < <(git diff --name-only --cached --diff-filter=d | grep ".swift$")
export SCRIPT_INPUT_FILE_COUNT=$count

if [ "$count" -eq 0 ]; then
    echo "No files to lint!"
    exit 0
fi
echo "Found $count lintable files! Linting now.."

RESULT=$($LINT lint --use-script-input-files --quiet --config .swiftlint.yml)

if [ -z "$RESULT" ]; then
    printf "SwiftLint Finished.\n"
else
    echo ""
    printf "SwiftLint Failed. Please check below:\n"

    while read -r line; do
        FILEPATH=$(echo "$line" | cut -d : -f 1)
        L=$(echo "$line" | cut -d : -f 2)
        C=$(echo "$line" | cut -d : -f 3)
        TYPE=$(echo "$line" | cut -d : -f 4 | cut -c 2-)
        MESSAGE=$(echo "$line" | cut -d : -f 5 | cut -c 2-)
        DESCRIPTION=$(echo "$line" | cut -d : -f 6 | cut -c 2-)
        printf '\n %s\n' "$TYPE"
        echo "    $FILEPATH:$L:$C"
        echo "    $MESSAGE - $DESCRIPTION"
    done <<< "$RESULT"

    printf "\nCOMMIT ABORTED. Please fix them before commiting.\n"

    exit 1
fi
