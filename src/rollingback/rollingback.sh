#!/usr/bin/env bash

# -------------------------------------------------------------------------------- #
# Description                                                                      #
# -------------------------------------------------------------------------------- #
# This is a simple script to demonstrate how rollbacks can be used.                #
# -------------------------------------------------------------------------------- #

# -------------------------------------------------------------------------------- #
# Global Variables                                                                 #
# -------------------------------------------------------------------------------- #
# This is an array that is used to store the rollback functions that need to run.  #
# -------------------------------------------------------------------------------- #

rollback_stack=( )

# -------------------------------------------------------------------------------- #
# ABC                                                                              #
# -------------------------------------------------------------------------------- #
# A dummy demo rollback function.                                                  #
# -------------------------------------------------------------------------------- #

function abc()
{
    echo "abc----$1";
}

# -------------------------------------------------------------------------------- #
# DEF                                                                              #
# -------------------------------------------------------------------------------- #
# A dummy demo rollback function.                                                  #
# -------------------------------------------------------------------------------- #

function def()
{
    echo "def----$1";
}

# -------------------------------------------------------------------------------- #
# Add Rollback                                                                     #
# -------------------------------------------------------------------------------- #
# Add a rollback function to the stack.                                            #
# -------------------------------------------------------------------------------- #

function add_rollback()
{
    rollback_stack[${#rollback_stack[*]}]=$1;
}

# -------------------------------------------------------------------------------- #
# Run Rollback                                                                     #
# -------------------------------------------------------------------------------- #
# Run all of the rollback function.                                                #
#                                                                                  #
# It is important to understand that rollbacks are run in the opposite order to    #
# which they are added as the rollback is a 'stack' [aka a LIFO].                  #
#                                                                                  #
# It is 'important' to unset the traps before running the rollback otherwise       #
# errors in the rollback code could trigger another rollback and a possible loop.  #
# -------------------------------------------------------------------------------- #

function run_rollbacks()
{
    unset_traps

    printf '\nTrap Triggers - Running Rollbacks\n\n'

    while [ ${#rollback_stack[@]} -ge 1 ]; do
        ${rollback_stack[${#rollback_stack[@]}-1]} rollback;
        unset rollback_stack[${#rollback_stack[@]}-1];
    done

    exit
}

# -------------------------------------------------------------------------------- #
# Set Traps                                                                        #
# -------------------------------------------------------------------------------- #
# We only want the rollbacks to run on error - so we set up traps to catch the     #
# errors and handle the rollbacks.                                                 #
# -------------------------------------------------------------------------------- #

function set_traps()
{
    trap run_rollbacks INT TERM EXIT
}

# -------------------------------------------------------------------------------- #
# Unset Traps                                                                      #
# -------------------------------------------------------------------------------- #
# Once everything has run cleanly we want to reset the traps, otherwise exiting    #
# the script will cause the rollbacks to run undoing all the scripts good work.    #
# -------------------------------------------------------------------------------- #

function unset_traps()
{
    trap - INT TERM EXIT
}

# -------------------------------------------------------------------------------- #
# Run Tests                                                                        #
# -------------------------------------------------------------------------------- #
# A VERY simple test function to ensure that it all works.                         #
# -------------------------------------------------------------------------------- #

function run_tests()
{
    set_traps

    add_rollback abc
    add_rollback def

    printf '\nSleeping for the next 10 seconds - try hitting '\''control C'\'' to see the rollbacks in action\n\n'
    sleep 10
    printf '\nSleeping Over - Exiting cleanly\n\n'

    unset_traps
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
