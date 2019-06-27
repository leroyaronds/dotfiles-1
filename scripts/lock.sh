#!/bin/bash
#

# Stop music
if command -v cmus-remote >/dev/null; then
	cmus-remote --stop
fi

# Lock screen
i3lock -c 000000 -f -n
