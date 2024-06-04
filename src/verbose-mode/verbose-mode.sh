#!/usr/bin/env bash

# -------------------------------------------------------------------------------- #
# Description                                                                      #
# -------------------------------------------------------------------------------- #
# This is a simple script to display some text in the center of the screen.        #
# -------------------------------------------------------------------------------- #

VERBOSE=false

# -------------------------------------------------------------------------------- #
# Set Verbose Mode                                                                 #
# -------------------------------------------------------------------------------- #
# This is a simple function that will enable verbose mode based on a global        #
# variable. It does this by cloning stdout and stderr and then redirecting the     #
# original file descriptors to /dev/null.                                          #
# -------------------------------------------------------------------------------- #

function set_verbose_mode()
{
    exec 3>&1
    exec 4>&2

    if [[ "${VERBOSE}" = true ]]; then
        echo "Verbose output enabled"
    else
        exec 1>/dev/null
        exec 2>/dev/null
    fi
}

# -------------------------------------------------------------------------------- #
# Output Wrapper                                                                   #
# -------------------------------------------------------------------------------- #
# A wrapper to use instead of echo which will handle the forcing of messages to be #
# displayed even when verbose mode is off.                                         #
# -------------------------------------------------------------------------------- #

function output()
{
    if [[ -n $1 ]]; then
        if [[ -n $2 ]] && [[ "${2}" = forced ]]; then
            echo "$1" 1>&3 2>&4
        else
            echo "$1"
        fi
    fi
}

# -------------------------------------------------------------------------------- #
# Run the Tests                                                                    #
# -------------------------------------------------------------------------------- #
# -------------------------------------------------------------------------------- #

function run_tests()
{
    set_verbose_mode

    output "I won't be visible when verbose=false"
    output "I will be visible no matter what" forced
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

