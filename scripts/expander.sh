#!/bin/bash
#
sleep 1
# Get input from clipboard
INPUT=`xclip -o`

# TextExpansion

if [ "${INPUT}" == "r" ]; then
	OUTPUT="rebuild";
fi

# When output has match copy paste
if [ ! -z "${OUTPUT}" ]; then
#	printf '%s' ${OUTPUT} | xclip -i -selection clipboard;
#	xdotool key --clearmodifiers "ctrl+v";
	xdotool windowactivate --sync $(xdotool getwindowfocus) type $OUTPUT;
fi
