#!/usr/bin/env bash

# -------------------------------------------------------------------------------- #
# Description                                                                      #
# -------------------------------------------------------------------------------- #
# A script to work out the root of a given git repo.                               #
# -------------------------------------------------------------------------------- #

# -------------------------------------------------------------------------------- #
# Get Git Root                                                                     #
# -------------------------------------------------------------------------------- #
# Look at a supplied dir to see if it cointains a git repo and if so calculate the #
# root of that repo.                                                               #
# -------------------------------------------------------------------------------- #

function get_git_root()
{
    local root
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
                echo "$1 is not a valid directory"
                return 1
            fi
            cd "${1}" || return 1
        fi

        #
        # If we are in a .git directory we need to get out of it
        #
        if git rev-parse --is-inside-git-dir > /dev/null 2>&1; then
            while [[ $(git rev-parse --is-inside-git-dir) == true ]]; do
                cd ..
            done
        fi

        #
        # Check to see if we are in a real git repo dir or not
        #
        if git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
            root=$(git rev-parse --show-toplevel)
            retval=0
        else
            root="${PWD} is not a git repo"
            retval=1
        fi

        echo "${root}"
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
        echo "Testing: ${i}"
        if root=$(get_git_root "${i}"); then
            echo "Repo Root = $root"
        else
            echo "Error: $root"
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

