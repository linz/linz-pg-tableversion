#!/usr/bin/env bash

set -o errexit -o noclobber -o nounset -o pipefail -o xtrace
shopt -s failglob inherit_errexit

script_dir="$(dirname "${BASH_SOURCE[0]}")"

# shellcheck source=test/ci/install-latest.bash
. "${script_dir}/install-latest.bash" "$1"

make install
# shellcheck disable=SC2154
make PREPAREDB_UPGRADE_FROM="$installed_package_version" installcheck-loader-upgrade
