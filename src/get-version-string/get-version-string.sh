#!/usr/bin/env bash

#
# Extract a version from a string
#

function get_version_string()
{
    raw_string="${1:-}"

    # shellcheck disable=SC2001
    version=$(echo "${raw_string}" | sed 's/[^0-9.]*\([0-9.]*\).*/\1/')
    echo "${version}"
}

get_version_string "my version is 1.2.3"
get_version_string "my version is-1.2.3"
get_version_string "my version is (1.2.3)"
