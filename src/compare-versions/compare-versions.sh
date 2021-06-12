#!/usr/bin/env bash

# -------------------------------------------------------------------------------- #
# Description                                                                      #
# -------------------------------------------------------------------------------- #
# This is a simple script to compare 2 version strings.                            #
# -------------------------------------------------------------------------------- #

# -------------------------------------------------------------------------------- #
# Compare Version                                                                  #
# -------------------------------------------------------------------------------- #
# Compare 2 version strings, they can be different lengths, and the delimiter can  #
# also be specificed.                                                              #
#                                                                                  #
# Caveat: This only works for numeric version strings.                             #
# -------------------------------------------------------------------------------- #

function compare_version()
{
    if (($# < 2)) || (($# > 3)); then
        echo "Incorrect number of arguments"
        return 255
    fi

    if [[ "${1}" == "${2}" ]]; then
        return 0
    fi

    if (($# == 3)); then
        local IFS="${3}"
    else
        local IFS=.
    fi

    local i ver1 ver2
    read -r -a ver1 <<< "${1}"
    read -r -a ver2 <<< "${2}"

    # fill empty fields in ver1 with zeros
    if ((${#ver1[@]} != ${#ver2[@]})); then
        for ((i=${#ver1[@]}; i<${#ver2[@]}; i++))
        do
            ver1[i]=0
        done
    fi

    for ((i=0; i<${#ver1[@]}; i++))
    do
        if [[ -z ${ver2[i]} ]]; then
            # fill empty fields in ver2 with zeros
            ver2[i]=0
        fi

        if ((10#${ver1[i]} > 10#${ver2[i]})); then
            return 1
        fi

        if ((10#${ver1[i]} < 10#${ver2[i]})); then
            return 2
        fi
    done

    return 0
}

function test_wrapper()
{
    if (($# < 2)) || (($# > 4)); then
        echo "Incorrect number of arguments"
        return 255
    fi

    if (($# == 4)); then
        compare_version "${1}" "${2}" "${4}"
    else
        compare_version "${1}" "${2}"
    fi

    case $? in
        255) op='!!';;
        0) op='=';;
        1) op='>';;
        2) op='<';;
    esac

    if [[ $3 =~ $op ]]; then
        echo "    Pass: '$1 $3 $2'"
    else
        echo "    FAIL: Expected '$3', Actual '$op', Arg1 '$1', Arg2 '$2'"
    fi
}

# -------------------------------------------------------------------------------- #
# Run Tests                                                                        #
# -------------------------------------------------------------------------------- #
# A VERY simple test function to ensure that it all works                          #
# -------------------------------------------------------------------------------- #

function run_test()
{
    echo "Simple Equivalence tests"
    test_wrapper "1"              "1"              "="
    test_wrapper "5.6.7"          "5.6.7"          "="
    echo

    echo "Advanced Equivalence tests"
    test_wrapper "1.01.1"         "1.1.1"          "="
    test_wrapper "1.1.1"          "1.01.1"         "="
    test_wrapper "1"              "1.0"            "="
    test_wrapper "1.0"            "1"              "="
    test_wrapper "1.0.2.0"        "1.0.2"          "="
    test_wrapper "1..0"           "1.0"            "="
    test_wrapper "1.0"            "1..0"           "="
    echo

    echo "Less than tests"
    test_wrapper "1.2"            "2.1"            "<"
    test_wrapper "2.1"            "2.2"            "<"
    test_wrapper "4.08"           "4.08.01"        "<"
    test_wrapper "3.2"            "3.2.1.9.8144"   "<"
    test_wrapper "1.0"            "1..1"           "<"
    echo

    echo "Greater than tests"
    test_wrapper "2.1"            "1.2"            ">"
    test_wrapper "2.2"            "2.1"            ">"
    test_wrapper "3.0.4.10"       "3.0.4.2"        ">"
    test_wrapper "3.2.1.9.8144"   "3.2"            ">"
    test_wrapper "1..1"           "1.0"            ">"
    echo

    echo "Less than or equal to tests"
    test_wrapper "1.2"            "1.2"            "<="
    test_wrapper "1.2"            "2.1"            "<="
    test_wrapper "4.08"           "4.08.01"        "<="
    test_wrapper "3.2"            "3.2.1.9.8144"   "<="
    test_wrapper "1.0"            "1..1"           "<="
    test_wrapper "1.0"            "1..0"           "<="
    echo

    echo "Greater than tests"
    test_wrapper "1.2"            "1.2"            ">="
    test_wrapper "2.1"            "1.2"            ">="
    test_wrapper "3.0.4.10"       "3.0.4.2"        ">="
    test_wrapper "3.2.1.9.8144"   "3.2"            ">="
    test_wrapper "1..1"           "1.0"            ">="
    test_wrapper "1.0"            "1..0"           ">="
    echo

    echo "Not Equal to tests"
    test_wrapper "2.1"            "1.2"            "<>"
    test_wrapper "2.2"            "2.1"            "<>"
    test_wrapper "3.0.4.10"       "3.0.4.2"        "<>"
    test_wrapper "3.2.1.9.8144"   "3.2"            "<>"
    test_wrapper "1..1"           "1.0"            "<>"
    echo

    echo "Custom delimiter tests"
    test_wrapper "1|01|1"         "1|1|1"          "="    "|"
    test_wrapper "4-08"           "4-08-01"        "<"    "-"
    test_wrapper "3-2"            "3-2-1-9-8144"   "<"    "-"
    test_wrapper "2/1"            "1/2"            ">"    "/"
    test_wrapper "2#1"            "2#2"            "<="   "#"
    test_wrapper "3=0=4=10"       "3=0=4=2"        ">"    "="
    test_wrapper "3^2^1^9^8144"   "3^2"            ">="   "^"
    test_wrapper "1##1"           "1#0"            "<>"   "#"
    echo
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

