#!/bin/sh

source ./extension.inc

echo $RED 'Hello in red!'

echo $BLU

add_a_us

BOLD=`tput bold` # redefined

echo $BOL

echo "$"

source ./scripts/tag-release.inc

tagRelease '1.0.0'

loadlib () {
  source "$1.sh"
}

loadlib "issue206"
