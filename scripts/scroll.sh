#!/bin/bash

max_length=24
interval=1

get_title() {
    echo "$(playerctl metadata --format '{{ title }} - {{ artist }}')"
} 
# TODO
scroll_text() {
    local text=$(get_title)
	local length=${#text}

	local buff="$text"
   
	while true; do
		if [ $length -le $max_length ]; then
        	echo "$text"
        	continue
    	fi

		local new_text=$(get_title)

		if [ "$new_text" != "$text" ]; then
        	text="$new_text"
        	buff="$text$text"
    	fi

		if [ $length -le $max_length ]; then
        	echo "$text"
		else 
			local current_text="${buff:$0:$max_length}"
			echo -ne $current_text
			first_char="${text:0:1}"
			remaining_string="${text:1}"
			buff="${text}${first_char}"
		fi

		sleep $interval

    done
}

while true; do
	title=$(get_title)
	if [ -z "$title" ]; then 
		echo "[No track avaible]"
	else 
		echo "[${title:0:$max_length}]"
	fi
	sleep $interval;
done

