#!/usr/bin/env bash

# -------------------------------------------------------------------------------- #
# Description                                                                      #
# -------------------------------------------------------------------------------- #
# This is a simple script to check to see if an array contains a value.            #
# -------------------------------------------------------------------------------- #

# -------------------------------------------------------------------------------- #
# Array to string (string, substring)                                              #
# -------------------------------------------------------------------------------- #
# This is a simple function that will take an array and a seperator and create a   #
# string of values.                                                                #
# -------------------------------------------------------------------------------- #

function array_to_string()
{
    separator="$1"
    local -n arr=$2

    regex="$( printf "${separator}%s" "${arr[@]}" )"
    regex="${regex:${#separator}}" # remove leading separator

    if [[ -n $3 ]]; then
        if [[ $regex = *"$separator"* ]]; then
            prefix=${regex%"$separator"*}               # Extract content before the last instance
            suffix=${regex#"$prefix"}                   # Extract content *after* our prefix
            regex=${prefix}${suffix/"$separator"/"$3"}  # Append unmodified prefix w/ suffix w/ replacement
        fi
    fi

    echo "${regex}"
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

    array_to_string ', ' array_of_numbers
    array_to_string ', ' array_of_numbers ' and '
    array_to_string ', ' array_of_numbers ' or '
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

