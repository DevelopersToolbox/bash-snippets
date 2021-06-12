#!/usr/bin/env bash

# -------------------------------------------------------------------------------- #
# Description                                                                      #
# -------------------------------------------------------------------------------- #
# This is a simple script to check to see if an array contains a value.            #
# -------------------------------------------------------------------------------- #

# -------------------------------------------------------------------------------- #
# Contains (string, substring)                                                     #
# -------------------------------------------------------------------------------- #
# This is a simple function that will check if and array contains a value.         #
#                                                                                  #
# Returns 0 if the specified string contains the specified substring, otherwise 1. #
# -------------------------------------------------------------------------------- #

function array_contains()
{
    local -n haystack=$1
    local needle=$2

    for i in "${haystack[@]}"; do
        if [[ $i == "${needle}" ]]; then
            return 0
        fi
    done

    return 1
}

# -------------------------------------------------------------------------------- #
# Test                                                                             #
# -------------------------------------------------------------------------------- #
# A VERY simple test function to ensure that it all works                          #
# -------------------------------------------------------------------------------- #

function run_tests()
{
# shellcheck disable=SC2034
    array_of_numbers=( "1" "2" "3" )
    local needle1="3"
    local needle2="4"

    if ! array_contains array_of_numbers "${needle1}"; then
        echo "$needle1 not found"
    else
        echo "$needle1 found"
    fi

    if ! array_contains array_of_numbers "${needle2}"; then
        echo "$needle1 not found"
    else
        echo "$needle1 found"
    fi
}

# -------------------------------------------------------------------------------- #
# Main()                                                                           #
# -------------------------------------------------------------------------------- #
# This is the actual 'script' and the functions/sub routines are called in order.  #
# -------------------------------------------------------------------------------- #

run_tests

# -------------------------------------------------------------------------------- #
# End of Script                                                                    #
# -------------------------------------------------------------------------------- #
# This is the end - nothing more to see here.                                      #
# -------------------------------------------------------------------------------- #

