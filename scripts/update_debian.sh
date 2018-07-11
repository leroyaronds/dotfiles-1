#!/bin/bash
#
# apt-get with options
APT="sudo apt-get --quiet --assume-yes"
#
$APT update && $APT upgrade && $APT autoremove && $APT autoclean
