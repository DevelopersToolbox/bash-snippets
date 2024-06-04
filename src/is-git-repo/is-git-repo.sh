#!/usr/bin/env bash

# -------------------------------------------------------------------------------- #
# Description                                                                      #
# -------------------------------------------------------------------------------- #
# A script to work out if a directory contains a git repo.                         #
# -------------------------------------------------------------------------------- #

# -------------------------------------------------------------------------------- #
# Is Git Repo                                                                      #
# -------------------------------------------------------------------------------- #
# Look at a supplied dir to see if it cointains a git repo.                        #
# -------------------------------------------------------------------------------- #

function is_git_repo()
{
    local retval

    #
    # Execute everything as a subshell to avoid messing up users current directory position
    #
    (
        #
        # If we are checking a directory which is not the current one then cd to the specificed directory
        #
        if [[ -n $1 ]]; then
            if [[ ! -d $1 ]]; then
                return 1
            fi
            cd "${1}" || return 1
        fi

        #
        # Check to see if we are in a real git repo dir or not
        #
        # The return value is always true if you are in a git repo.
        #
        # The output can be true or false depending where in the repo you are so we ignore this
        #
        if git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
            retval=0
        else
            retval=1
        fi
        return $retval
    )
}

# -------------------------------------------------------------------------------- #
# Run Tests                                                                        #
# -------------------------------------------------------------------------------- #
# A VERY simple test function to ensure that it all works                          #
# -------------------------------------------------------------------------------- #

function run_test()
{
    declare -a dirs=('./' '/home' '/thiswillerror')

    ## now loop through the above array
    for i in "${dirs[@]}"
    do
        echo -n "${i} is "
        if is_git_repo "${i}"; then
            echo "a git repo"
        else
            echo "not a git repo"
        fi
    done
}

# -------------------------------------------------------------------------------- #
# Main()                                                                           #
# -------------------------------------------------------------------------------- #
# This is the actual 'script' and the functions/sub routines are called in order.  #
# -------------------------------------------------------------------------------- #

run_test "$@"

# -------------------------------------------------------------------------------- #
# End of Script                                                                    #
# -------------------------------------------------------------------------------- #
# This is the end - nothing more to see here.                                      #
# -------------------------------------------------------------------------------- #

