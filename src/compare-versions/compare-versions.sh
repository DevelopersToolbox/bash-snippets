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

function compare_versions()
{
    if [[ $1 == "${2}" ]]; then
        return 0
    fi

    if (($# == 3)); then
        IFS=$3
    else
        IFS=.
    fi

    local i ver1  ver2

    read -r -a ver1 <<< "${1}"
    read -r -a ver2 <<< "${2}"

    max=$(( ${#ver1[@]} > ${#ver2[@]} ? ${#ver1[@]} : ${#ver2[@]} ))

    for ((i=0; i<max; i++))
    do
        if ((10#${ver1[i]:-0} < 10#${ver2[i]:-0})); then
            return 2
        elif ((10#${ver1[i]:-0} > 10#${ver2[i]:-0})); then
            return 1
        fi
    done
    #if [ "$arem" '<' "$brem" ]; then
    #    return 2
    #elif [ "$arem" '>' "$brem" ]; then
    #    return 1
    #fi
    return 0
}

function test_wrapper()
{
    if (($# < 2)) || (($# > 4)); then
        echo "Incorrect number of arguments"
        return 255
    fi

    if (($# == 4)); then
        compare_versions "${1}" "${2}" "${4}"
    else
        compare_versions "${1}" "${2}"
    fi

    case $? in
        255) op='!!';;
        0) op='=';;
        1) op='>';;
        2) op='<';;
        *)
    esac

    if [[ $3 =~ ${op} ]]; then
        echo "    Pass: '$1 $3 $2'"
    else
        echo "    FAIL: Expected '$3', Actual '${op}', Arg1 '$1', Arg2 '$2'"
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
    test_wrapper "3.0.4.10"       "3.0.4.2"        ">"
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
    test_wrapper "2#1"            "2#2"            "<"   "#"
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

