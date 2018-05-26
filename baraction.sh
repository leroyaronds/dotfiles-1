#!/bin/sh
#
while :; do
	CPU_LOAD=$(uptime | sed 's/.*: //;' | cut -d' ' -f1)
	MEM_USED=$(free | grep Mem | awk '{printf "%.1f", $3/$2 * 100.0}')

	echo -e "L: ${CPU_LOAD} - M: ${MEM_USED}%"

	sleep 5
done
