#!/bin/bash

git diff --diff-filter=d --staged --name-only | grep -e '\(.*\).swift$' | while read line; do
  swiftformat "${line}";
  git add "$line";
done
