#!/usr/bin/env bash

# -------------------------------------------------------------------------------- #
# Description                                                                      #
# -------------------------------------------------------------------------------- #
# A simple script to show how to programatically get the terraform version.        #
# -------------------------------------------------------------------------------- #

# -------------------------------------------------------------------------------- #
# Get Terraform Version                                                            #
# -------------------------------------------------------------------------------- #
# Programatically get the terraform version.                                       #
# -------------------------------------------------------------------------------- #

function get_terraform_version()
{
    local terraform_version

    command=$(command -v "terraform")
    if [[ -z $command ]]; then
        echo "Terraform is not installed - Aborting"
        exit
    fi

    terraform_version=$(terraform --version | head -n 1)
    terraform_version=${terraform_version##* }                  # retain the part after the last space
    terraform_version=${terraform_version#?}                    # strip the first letter

    if [[ -z ${terraform_version} ]]; then
        echo "Could not determine terraform version - Aborting"
        exit
    fi

    echo "${terraform_version}"
}

# -------------------------------------------------------------------------------- #
# Run Tests                                                                        #
# -------------------------------------------------------------------------------- #
# A VERY simple test function to ensure that it all works                          #
# -------------------------------------------------------------------------------- #

function run_tests()
{
    tf_version=$(get_terraform_version)
    echo "${tf_version}"
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

