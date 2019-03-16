#!/usr/bin/env bash
#
# ./make - a .PHONY makefile is worse than a bash script.
#
set -eu -o pipefail

orbname=dnephin/multirepo
default=validate

validate() {
    circleci orb validate orb.yaml
    [ -f .circleci/config.yml ] && circleci config validate
}

publish() {
    local version=${version-"dev:testing"}
    circleci orb publish orb.yaml $orbname@$version
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
