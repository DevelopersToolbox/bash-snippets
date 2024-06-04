#!/usr/bin/env bash

# -------------------------------------------------------------------------------- #
# Description                                                                      #
# -------------------------------------------------------------------------------- #
# Replace template variables in a file with values from an associative array.      #
# -------------------------------------------------------------------------------- #

# -------------------------------------------------------------------------------- #
# Ref Array                                                                        #
# -------------------------------------------------------------------------------- #
# Take the name of an array and create a vaid reference to it.                     #
# -------------------------------------------------------------------------------- #

function ref_array()
{
    local varname="$1"
    local export_as="$2"
    local code

    code=$(declare -p "$varname")

    echo "${code/$varname/$export_as}"
}

# -------------------------------------------------------------------------------- #
# Replace Variables                                                                #
# -------------------------------------------------------------------------------- #
# Take the name of an array and create a vaid reference to it.                     #
# -------------------------------------------------------------------------------- #

function replace_variables()
{
    eval "$(ref_array "$1" array)"
    filename="${2}"

    local i
    local search
    local replace

    # shellcheck disable=SC2154
    for i in "${!array[@]}"; do
        search="${i}"
        replace="${array[$i]}"

        if grep -q "${search}" "${filename}"; then
            sed -i '' "s/${search}/${replace}/g" "${filename}"
            printf "Replaced %s with %s\n" "${search}" "${replace}"
        fi
    done
}

# -------------------------------------------------------------------------------- #
# Run Tests                                                                        #
# -------------------------------------------------------------------------------- #
# A VERY simple test function to ensure that it all works                          #
# -------------------------------------------------------------------------------- #

function run_tests()
{
    declare -A config

# shellcheck disable=SC2034
    config=(
        ['{{ USERNAME_PLACE_HOLDER }}']='admin'
        ['{{ PASSWORD_PLACE_HOLDER }}']='password'
    )

    replace_variables "config" "test.sh"
}

# -------------------------------------------------------------------------------- #
# Main()                                                                           #
# -------------------------------------------------------------------------------- #
# This is the actual 'script' and the functions/sub routines are called in order.  #
# -------------------------------------------------------------------------------- #

run_tests "$@"

# -------------------------------------------------------------------------------- #
# End of Script                                                                    #
# -------------------------------------------------------------------------------- #
# This is the end - nothing more to see here.                                      #
# -------------------------------------------------------------------------------- #
