#!/usr/bin/env bash

# -------------------------------------------------------------------------------- #
# Description                                                                      #
# -------------------------------------------------------------------------------- #
# This is a simple script to request confirmation from a user.                     #
# -------------------------------------------------------------------------------- #

# -------------------------------------------------------------------------------- #
# Get Confirmation                                                                 #
# -------------------------------------------------------------------------------- #
# A simple function which prompts the user for a yes/no response.                  #
#                                                                                  #
# A default prompt is used if one is not supplied, and the function will loop      #
# until a valid response is given.                                                 #
# -------------------------------------------------------------------------------- #

function get_confirmation()
{
    local valid_response=false
    local return_value=0

    while [[ "$valid_response" = false ]]
    do
        read -r -p "${1:-Are you sure? [y/N]} " response
        case $response in
            [yY][eE][sS]|[yY])
                valid_response=true
                return_value=1
                ;;
            [nN][oO]|[nN])
                valid_response=true
                return_value=0
                ;;
            *)
                ;;
        esac
    done
    echo $return_value
}

# -------------------------------------------------------------------------------- #
# Test                                                                             #
# -------------------------------------------------------------------------------- #
# A VERY simple test function to ensure that it all works                          #
# -------------------------------------------------------------------------------- #

function run_tests()
{
    response=0

    while [[ $response == 0 ]]
    do
        response=$(get_confirmation "Do you want to exit? [y/N]")
    done
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

