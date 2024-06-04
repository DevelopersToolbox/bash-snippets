#!/usr/bin/env bash

# -------------------------------------------------------------------------------- #
# Description                                                                      #
# -------------------------------------------------------------------------------- #
# This is a demonstration on how to use colours.                                   #
#                                                                                  #
# NOTE: This is a truncated example and a full working solution is avaiable at     #
# https://github.com/WolfSoftware/bash-colour-include.                             #
# -------------------------------------------------------------------------------- #

function set_colours()
{
    # Foreground Colours
    fgRed=''
    fgYellow=''

    # Background Colours
    bgBlack=''
    bgWhite=''

    # Misc Features
    reset=''

    # Test to see if the terminal has colour support and if so set the variables to
    # the corresponding control codes.
    if test -t 1; then

        # see if it supports colors...
       ncolors=$(tput colors)

        if test -n "${ncolors}" && test "${ncolors}" -ge 8; then
            fgRed=$(tput setaf 1)
            fgYellow=$(tput setaf 3)

            bgBlack=$(tput setab 0)
            bgWhite=$(tput setab 7)

            reset=$(tput sgr0)
        fi
    fi

}

# -------------------------------------------------------------------------------- #
# Run Tests                                                                        #
# -------------------------------------------------------------------------------- #
# A VERY simple test function to ensure that it all works                          #
# -------------------------------------------------------------------------------- #

function run_tests()
{
    set_colours

    echo "${bgBlack}${fgRed}This should be red text${reset}"
    echo "${bgBlack}${fgYellow}This should be yellow text${reset}"
    echo "${bgWhite}${fgRed}This should be red on a white background${reset}"
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
