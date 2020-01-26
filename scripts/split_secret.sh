#!/bin/bash
#
# Number of parts needed to recreate original
N=4
# Number of parts created in total
M=6
FILE=$1
#
gfsplit -n $N -m $M $FILE
