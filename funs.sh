#!/bin/bash

XDG_CONFIG_DIR="$HOME/.config"
CURRENT_DATE=$(date "+%d-%m-%Y")

make_backup() {
	local CONFIG="$1"

	if [ -f "$CONFIG" ]; then 
		mv "$CONFIG" "$CONFIG.$CURRENT_DATE"
	fi
}

sway() {
	local CONFIG_DIR="$XDG_CONFIG_DIR/sway"
	local CONFIG="$CONFIG_DIR/config"

	mkdir -p "$CONFIG_DIR"

	make_backup "$CONFIG"
	
	cp ./sway/config "$CONFIG_DIR" 
}

waybar() {
	local CONFIG_DIR="$XDG_CONFIG_DIR/waybar"
	local CONFIG="$CONFIG_DIR/config"
	local STYLE="$CONFIG_DIR/style.css"

	mkdir -p "$CONFIG_DIR"

	make_backup "$CONFIG"
	make_backup "$STYLE"
	
	cp ./waybar/config "$CONFIG_DIR"
	cp ./waybar/style.css "$CONFIG_DIR"
}

neofetch() {
	local CONFIG_DIR="$XDG_CONFIG_DIR/neofetch"
	local CONFIG="$CONFIG_DIR/config.conf"

	mkdir -p "$CONFIG_DIR"

	make_backup "$CONFIG"

	cp ./neofetch/config.conf "$CONFIG_DIR" 
}

foot() {
	local CONFIG_DIR="$XDG_CONFIG_DIR/foot"
	local CONFIG="$CONFIG_DIR/foot.ini"

	mkdir -p "$CONFIG_DIR"

	make_backup "$CONFIG"

	cp ./foot/foot.ini "$CONFIG_DIR" 
}

nvim() {
	local CONFIG_DIR="$XDG_CONFIG_DIR/nvim"
	local CONFIG="$CONFIG_DIR/init.vim"

	mkdir -p "$CONFIG_DIR"

	make_backup "$CONFIG"

	cp ./nvim/init.vim "$CONFIG_DIR"

	nvim -c 'PlugInstall' -c 'qa'
}

p10k() {
	lcal CONFIG_DIR="$HOME"
	local CONFIG="$CONFIG_DIR/.p10k.zsh"

	make_backup "$CONFIG"

	cp ./p10k/.p10k.zsh "$CONFIG_DIR"
}

scripts () {
	local SCRIPTS_DIR="$XDG_CONFIG_DIR/scripts"

	mkdir -p "$SCRIPTS_DIR"

	for FILE in "./scripts"/*; do
		if [ -f "$FILE" ]; then
			if [ -f "$SCRIPTS_DIR/$FILE" ]; then
				make_backup "$SCRIPTS_DIR/$FILE"
			fi

			cp "./scripts/$FILE" "$SCRIPTS_DIR/$FILE"
		fi
	done
}

swaylock() {
	local CONFIG_DIR="$XDG_CONFIG_DIR/swaylock"
	local CONFIG="$CONFIG_DIR/config"

	mkdir -p "$CONFIG_DIR"

	make_backup "$CONFIG"

	cp ./swaylock/config "$CONFIG_DIR"
}

wofi() {
	local CONFIG_DIR="$XDG_CONFIG_DIR/wofi"
	local CONFIG="$CONFIG_DIR/config"
	local STYLE="$CONFIG_DIR/style.css"

	mkdir -p "$CONFIG_DIR"

	make_backup "$STYLE"
	make_backup "$CONFIG"

	cp ./wofi/config "$CONFIG_DIR"
	cp ./wofi/style.css "$CONFIG_DIR"
}

zsh() {
	local CONFIG_DIR="$HOME"
	local CONFIG="$CONFIG/.zshrc"

	make_backup "$CONFIG"

	cp ./zsh/.zshrc "$CONFIG_DIR"
}
