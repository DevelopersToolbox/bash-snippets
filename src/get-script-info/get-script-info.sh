#!/usr/bin/env bash

# -------------------------------------------------------------------------------- #
# Description                                                                      #
# -------------------------------------------------------------------------------- #
# This is a simple script to show how to get get the script base path and name.    #
# -------------------------------------------------------------------------------- #

READONLY_INFO=true               # Set the script info to READONLY

# -------------------------------------------------------------------------------- #
# Get Script Info                                                                  #
# -------------------------------------------------------------------------------- #
# Work out some basic facts about the script, how it was called, where it lives,   #
# what it is called etc.                                                           #
# -------------------------------------------------------------------------------- #

function get_script_info()
{
    local ro=${READONLY_INFO:-false}

    [[ $0 != "${BASH_SOURCE[0]}" ]] && IS_SOURCED=true || IS_SOURCED=false

    READONLY=false
    INVOKED_FILE="${BASH_SOURCE[${#BASH_SOURCE[@]} - 1]}"
    INVOKED_PATH="$(dirname "${BASH_SOURCE[${#BASH_SOURCE[@]} - 1]}")"
    FULL_PATH="$( cd -P "$(dirname "${BASH_SOURCE[0]}")" && pwd )"
    FILE_NAME=$(basename "${BASH_SOURCE[0]}")

    if [[ $# -gt 0 ]]; then
        SCRIPT_ARGS=$(printf "'%s', " "${@}")
        SCRIPT_ARGS=${SCRIPT_ARGS::-2}                # Trim off the last comma and space
    else
        SCRIPT_ARGS="None"
    fi

    if [[ "${ro}" = true ]]
    then
        readonly IS_SOURCED
        readonly INVOKED_FILE
        readonly INVOKED_PATH
        readonly FULL_PATH
        readonly FILE_NAME
        readonly SCRIPT_ARGS
    fi

    export READONLY
    export IS_SOURCED
    export INVOKED_FILE
    export INVOKED_PATH
    export FULL_PATH
    export FILE_NAME
    export SCRIPT_ARGS
}

# -------------------------------------------------------------------------------- #
# Run Tests                                                                        #
# -------------------------------------------------------------------------------- #
# A VERY simple test function to ensure that it all works                          #
# -------------------------------------------------------------------------------- #

function run_tests()
{
    get_script_info "${@}"

    echo "Read Only? : ${READONLY}"
    echo "Sourced? : ${IS_SOURCED}"
    echo "Invoked File: ${INVOKED_FILE}"
    echo "Invoked Path: ${INVOKED_PATH}"
    echo "Full Path: ${FULL_PATH}"
    echo "Script Name: ${FILE_NAME}"
    echo "Script Args: ${SCRIPT_ARGS}"
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

