#!/bin/sh
#
while :; do
	CPU_LOAD=$(uptime | sed 's/.*: //; s/,//g;' | cut -d' ' -f1)
	CPU_TEMP$(sensors | grep -oP 'Physical.*?\+\K[0-9.]+')
	MEM_USED=$(free | grep Mem | awk '{printf "%.1f", $3/$2 * 100.0}')

	echo "L: ${CPU_LOAD} - T: ${CPU_TEMP} - M: ${MEM_USED}%"

	sleep 5
done
