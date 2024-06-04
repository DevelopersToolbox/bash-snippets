#!/usr/bin/env bash

#
# Calculate the absolute value of a given number
#
function abs()
{
    (( $1 < 0 )) && echo "$(( $1 * -1 ))" || echo "$1"
}

abs 1
abs 0
abs -1
