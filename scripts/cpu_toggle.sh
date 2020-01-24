#!/bin/bash
#
# Available modes : performance powersave
#
CURRENT_MODE=$(cat /sys/devices/system/cpu/cpufreq/policy0/scaling_governor)

if [ $CURRENT_MODE == "powersave" ]; then
	sudo cpufreq-set --governor performance
else
	sudo cpufreq-set --governor powersave
fi

NEW_MODE=$(cat /sys/devices/system/cpu/cpufreq/policy0/scaling_governor)

notify-send "CPU: ${CURRENT_MODE} -> ${NEW_MODE}"
