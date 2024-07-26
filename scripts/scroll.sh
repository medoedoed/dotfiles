#!/bin/bash

max_length=24
interval=1

get_title() {
    playerctl metadata --format '{{ title }} - {{ artist }}'
} 

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


#text with scrolling
scroll_text() {
    buff=""

    while true; do
        cur_title=$(get_title)

        if [ "$title" != "$cur_title" ]; then
            title="$cur_title"
            buff="$title   "  
        fi

        if [ ${#buff} -gt "$max_length" ]; then
            echo "[${buff:0:$max_length}]"
            buff=${buff:1}${buff:0:1}  
        else
			echo "[${buff:0:${#buff}-3}]"
        fi

        sleep $interval
    done
}
# change for plain text -->
scroll_text

