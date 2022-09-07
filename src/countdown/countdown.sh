#!/usr/bin/env bash

# -------------------------------------------------------------------------------- #
# Description                                                                      #
# -------------------------------------------------------------------------------- #
# This is a simple script to display a countdown timeer with optional message.     #
# -------------------------------------------------------------------------------- #

# -------------------------------------------------------------------------------- #
# Countdown                                                                        #
# -------------------------------------------------------------------------------- #
# Loop for the required numbers of seconds and display the message. We have to     #
# re-eval each time to ensure that the string is updated correctly.                #
# -------------------------------------------------------------------------------- #

function countdown()
{
    local seconds=${1:-0}
    local message=${2:-''}

    while [ "${seconds}" -gt 0 ]; do
        eval_message=$(eval "echo ${message}")
        echo -ne "${eval_message}\033[0K\r"
        sleep 1
        : $((seconds--))
    done
    echo
}

# -------------------------------------------------------------------------------- #
# Test                                                                             #
# -------------------------------------------------------------------------------- #
# A VERY simple test function to ensure that it all works                          #
# -------------------------------------------------------------------------------- #

function run_tests()
{
    # shellcheck disable=SC2016
    countdown 3 'Processing will start in $seconds seconds. Press Ctrl+C to abort'
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
