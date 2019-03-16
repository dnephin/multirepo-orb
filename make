#!/usr/bin/env bash
#
# ./make - a .PHONY makefile is worse than a bash script.
#
set -eu -o pipefail

orbname=dnephin/multirepo
default=validate

validate() {
    circleci orb validate orb.yaml
    if [ -f .circleci/config.yml ]; then circleci config validate; fi
}

publish() {
    local version=${version-"dev:testing"}
    circleci orb publish orb.yaml $orbname@$version
}

publish_patch() {
    circleci orb publish increment orb.yaml $orbname patch
}

install_precommit() {
    local hook=.git/hooks/pre-commit
    echo "./make validate" > $hook
    chmod +x $hook
}

for arg in "$@"; do case $arg in
  list) declare -F | awk '{print $3}'; exit;;
     *) $arg;;
esac; done

if [ -z "$@" ] && [ ${default-} ]; then $default; fi
