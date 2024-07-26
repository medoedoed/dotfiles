#!/bin/bash

max_length=24
interval=1

get_title() {
    echo "$(playerctl metadata --format '{{ title }} - {{ artist }}')"
} 
title="none"
buff="none"


# text without scrolling
plain_text() {
	while true; do
		title=$(get_title)
		if [ -z "$title" ]; then 
			echo "[No track avaible]"
		else 
			echo "[${title:0:$max_length}]"
		fi
		sleep $interval;
	done
}


title="none"
buff="none"

#text with scrolling
scroll_text() {
	while true; do
		c=${buff:0:1}
		buff=${buff:1}
		buff="$buff$c"


		cur_title=$(get_title)

		if [ ! "$title" == "$cur_title" ]; then
			title="$cur_title"
			buff="$title  "

		fi

		echo "[${buff:0:$max_length}"]

		sleep $interval
	done
}

# change for plain text -->
scroll_text

