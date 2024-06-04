#!/usr/bin/env bash

# -------------------------------------------------------------------------------- #
# Description                                                                      #
# -------------------------------------------------------------------------------- #
# This is a simple script to display errors, warning and success messages.         #
# -------------------------------------------------------------------------------- #


# -------------------------------------------------------------------------------- #
# Show Error                                                                       #
# -------------------------------------------------------------------------------- #
# A simple wrapper function to show something was an error.                        #
# -------------------------------------------------------------------------------- #

function show_error()
{
    if [[ -n $1 ]]; then
        printf '%s%s%s\n' "${red}" "${*}" "${reset}" 1>&2
    fi
}

# -------------------------------------------------------------------------------- #
# Show Warning                                                                     #
# -------------------------------------------------------------------------------- #
# A simple wrapper function to show something was a warning.                       #
# -------------------------------------------------------------------------------- #

function show_warning()
{
    if [[ -n $1 ]]; then
        printf '%s%s%s\n' "${yellow}" "${*}" "${reset}" 1>&2
    fi
}

# -------------------------------------------------------------------------------- #
# Show Success                                                                     #
# -------------------------------------------------------------------------------- #
# A simple wrapper function to show something was a success.                       #
# -------------------------------------------------------------------------------- #

function show_success()
{
    if [[ -n $1 ]]; then
        printf '%s%s%s\n' "${green}" "${*}" "${reset}" 1>&2
    fi
}

# -------------------------------------------------------------------------------- #
# Get Colours                                                                      #
# -------------------------------------------------------------------------------- #
# A very simple wrapper which can dynamically get the required colours.            #
# -------------------------------------------------------------------------------- #

function get_colours()
{
    local ncolors

    red=''
    yellow=''
    green=''
    reset=''

    if ! test -t 1; then
        return
    fi

    if ! tput longname > /dev/null 2>&1; then
        return
    fi

    ncolors=$(tput colors)

    if ! test -n "${ncolors}" || test "${ncolors}" -le 7; then
        return
    fi

    red=$(tput setaf 1)
    yellow=$(tput setaf 3)
    green=$(tput setaf 2)
    reset=$(tput sgr0)

    readonly red
    readonly yellow
    readonly green
    readonly reset

    declare -g red
    declare -g yellow
    declare -g green
    declare -g reset

}

# -------------------------------------------------------------------------------- #
# Run Tests                                                                        #
# -------------------------------------------------------------------------------- #
# A VERY simple test function to ensure that it all works                          #
# -------------------------------------------------------------------------------- #

function run_test()
{
    get_colours

    show_error "This is an error"
    show_warning "This is a warning"
    show_success "This is a success"
}

# -------------------------------------------------------------------------------- #
# Main()                                                                           #
# -------------------------------------------------------------------------------- #
# This is the actual 'script' and the functions/sub routines are called in order.  #
# -------------------------------------------------------------------------------- #

run_test

# -------------------------------------------------------------------------------- #
# End of Script                                                                    #
# -------------------------------------------------------------------------------- #
# This is the end - nothing more to see here.                                      #
# -------------------------------------------------------------------------------- #

