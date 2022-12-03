#!/bin/bash

function install_hooks() {

  echo "Installing git hooks ..."

  SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

  REPO_ROOT=`git rev-parse --show-toplevel`
  HOOKS_DIR="$REPO_ROOT/BuildScripts/hooks"
  GIT_PATH=`git rev-parse --show-toplevel`/.git

  mkdir -p $GIT_PATH/hooks

  # Each *.hooks subfolder contains scripts to be installed as git hook
  # All it takes is to strip off ".hooks" from each found folder name
  # i.e. pre-commit.hooks -> pre-commit
  HOOKS_TO_INSTALL=`(cd $HOOKS_DIR && ls -d *.hooks | sed 's/\.hooks//')`
  for i in $HOOKS_TO_INSTALL; do
    (cd $GIT_PATH/hooks && rm $i > /dev/null 2>&1; ln -s $HOOKS_DIR/execute-hooks.sh $i; echo "Installed '$i' hook")
  done

  echo "Install complete."

}

install_hooks
