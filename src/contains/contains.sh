#!/usr/bin/env bash

# -------------------------------------------------------------------------------- #
# Description                                                                      #
# -------------------------------------------------------------------------------- #
# This is a simple script to check to see if one string contains another.          #
# -------------------------------------------------------------------------------- #

# -------------------------------------------------------------------------------- #
# Contains (string, substring)                                                     #
# -------------------------------------------------------------------------------- #
# This is a simple function that will check if one string contains another.        #
#                                                                                  #
# Returns 0 if the specified string contains the specified substring, otherwise 1. #
# -------------------------------------------------------------------------------- #

function contains()
{
    string="$1"
    substring="$2"
    if test "${string#*$substring}" != "$string"; then
        return 0    # $substring is in $string
    else
        return 1    # $substring is not in $string
    fi
}

# -------------------------------------------------------------------------------- #
# Test                                                                             #
# -------------------------------------------------------------------------------- #
# A VERY simple test function to ensure that it all works                          #
# -------------------------------------------------------------------------------- #

function run_tests()
{
    local haystack="this is a test string"
    local needle="this"

    if contains "${haystack}" "${needle}"; then
        echo "We found a needle in a haystack"
    else
        echo "We did NOT found a needle in a haystack"
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

