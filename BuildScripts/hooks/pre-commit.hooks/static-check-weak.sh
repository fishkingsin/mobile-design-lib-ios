#!/bin/bash

set -e
git diff --cached --name-only -- '*.swift' | while read FILE; do
    start=$(date +%S)
    if echo "$FILE" | grep -i -E 'Tests.swift|Test.swift|Mock|WXViewControllable.swift'
    then
        echo "No need to check file: $FILE"
    else
        cat "$FILE" | while read line;do
        if [[ $(echo "$line" | grep "var viewControllable") ]]; then
            if echo "$line" | grep 'UIViewController?'; then
                if echo "$line" | grep 'weak'; then
                    echo "good to see you add weak"
                else
                    echo "File:${FILE}"
                    echo "RIBS need a weak refrence to viewControllable"
                    exit 1
                fi
            fi
        fi
        done
    fi
done



