#!/bin/bash

XDG_CONFIG_DIR="$HOME/.config"
CURRENT_DATE=$(date "+%d-%m-%Y")

SWAY_INSTALL=false
WAYBAR_INSTALL=false
NEOFETCH_INSTALL=false
FOOT_INSTALL=false
NVIM_INSTALL=false
ZSH_INSTALL=false
P10K_INSTALL=false
SCRIPTS_INSTALL=false
SWAYLOCK_INSTALL=false
WOFI_INSTALL=false

COPY_METHOD=""
MAKE_BACKUP=true


sway() {
	SWAY_INSTALL=true 
}

waybar() {
	WAYBAR_INSTALL=true
}

neofetch() {
	NEOFETCH_INSTALL=true
}

foot() {
	FOOT_INSTALL=true
}

nvim() {
	NVIM_INSTALL=true
}

zsh() {
	ZSH_INSTALL=true 
}
p10k() { 
	P10K_INSTALL=true
}

scripts() {
	SCRIPTS_INSTALL=true 
}

swaylock() { 
	SWAYLOCK_INSTALL=true
}

wofi() { 
	WOFI_INSTALL=true
}


method() {
	local arg="$1"

	if [ "$arg" == "copy" ]; then
		COPY_METHOD="cp "
	elif [ "$arg" == "softlink" ]; then 
		COPY_METHOD="ln -s "
	elif [ "$arg" == "hardlink" ]; then
		COPY_METHOD="ln "
	else 
		echo "wrong copy method"
		exit 1
	fi
}

make_backup() {
	local arg="$1"
	
	if [ "$arg" = true ]; then
		MAKE_BACKUP=true
	elif [ "$arg" = false ]; then
		MAKE_BACKUP=false
	else 
		echo "worng backup flag"
		exit 1
	fi
}

backup() {
	local CONFIG="$1"
	if [ "$MAKE_BACKUP" == false ]; then
		return
	fi

	if [ -f "$CONFIG" ]; then 
		mv "$CONFIG" "$CONFIG.$CURRENT_DATE"
	fi
}

install_sway() {
	local CONFIG_DIR="$XDG_CONFIG_DIR/sway"
	local CONFIG="$CONFIG_DIR/config"

	mkdir -p "$CONFIG_DIR"
	
	backup "$CONFIG"

	$COPY_METHOD ./sway/config "$CONFIG_DIR"
}

install_waybar() {
	local CONFIG_DIR="$XDG_CONFIG_DIR/waybar"
	local CONFIG="$CONFIG_DIR/config"
	local STYLE="$CONFIG_DIR/style.css"

	mkdir -p "$CONFIG_DIR"

	backup "$CONFIG"
	backup "$STYLE"

	$COPY_METHOD ./waybar/config "$CONFIG_DIR"
	$COPY_METHOD ./waybar/style.css "$CONFIG_DIR"
}

install_neofetch() {
	local CONFIG_DIR="$XDG_CONFIG_DIR/neofetch"
	local CONFIG="$CONFIG_DIR/config.conf"

	mkdir -p "$CONFIG_DIR"

	backup "$CONFIG"

	$COPY_METHOD ./neofetch/config.conf "$CONFIG_DIR" 
}

install_foot() {
	local CONFIG_DIR="$XDG_CONFIG_DIR/foot"
	local CONFIG="$CONFIG_DIR/foot.ini"

	mkdir -p "$CONFIG_DIR"

	backup "$CONFIG"
	$COPY_METHOD ./foot/foot.ini "$CONFIG_DIR" 
}

install_nvim() {
	local CONFIG_DIR="$XDG_CONFIG_DIR/nvim"
	local CONFIG="$CONFIG_DIR/init.vim"

	mkdir -p "$CONFIG_DIR"

	backup "$CONFIG"

	$COPY_METHOD ./nvim/init.vim "$CONFIG_DIR"

	nvim -c 'PlugInstall' -c 'qa'
}

install_p10k() {
	local CONFIG_DIR="$HOME"
	local CONFIG="$CONFIG_DIR/.p10k.zsh"

	backup "$CONFIG"

	$COPY_METHOD ./p10k/.p10k.zsh "$CONFIG_DIR"
}

install_scripts () {
	local SCRIPTS_DIR="$XDG_CONFIG_DIR/scripts"

	mkdir -p "$SCRIPTS_DIR"

	for FILE in "./scripts"/*; do
		if [ -f "$FILE" ]; then
			if [ -f "$SCRIPTS_DIR/$FILE" ]; then
				make_backup "$SCRIPTS_DIR/$FILE"
			fi

			$COPY_METHOD "./scripts/$FILE" "$SCRIPTS_DIR/$FILE"
		fi
	done
}

install_swaylock() {
	local CONFIG_DIR="$XDG_CONFIG_DIR/swaylock"
	local CONFIG="$CONFIG_DIR/config"

	mkdir -p "$CONFIG_DIR"

	backup "$CONFIG"

	$COPY_METHOD ./swaylock/config "$CONFIG_DIR"
}

install_wofi() {
	local CONFIG_DIR="$XDG_CONFIG_DIR/wofi"
	local CONFIG="$CONFIG_DIR/config"
	local STYLE="$CONFIG_DIR/style.css"

	mkdir -p "$CONFIG_DIR"

	backup "$STYLE"
	backup "$CONFIG"

	$COPY_METHOD ./wofi/config "$CONFIG_DIR"
	$COPY_METHOD ./wofi/style.css "$CONFIG_DIR"
}

install_zsh() {
	local CONFIG_DIR="$HOME"
	local CONFIG="$CONFIG/.zshrc"

	backup "$CONFIG"

	$COPY_METHOD ./zsh/.zshrc "$CONFIG_DIR"
}


if [ "$SWAY_INSTALL" = true ]; then
	install_sway
fi

if [ "$WAYBAR_INSTALL" = true ]; then
	install_waybar
fi

if [ "$NEOFETCH_INSTALL" = true ]; then
	install_neofetch
fi

if [ "$FOOT_INSTALL" = true ]; then
	install_foot
fi

if [ "$NVIM_INSTALL" = true ]; then
	install_nvim
fi

if [ "$ZSH_INSTALL" = true ]; then
	install_zsh
fi

if [ "$P10K_INSTALL" = true ]; then
	install_p10k
fi

if [ "$SCRIPTS_INSTALL" = true ]; then
	install_scripts
fi

if [ "$SWAYLOCK_INSTALL" = true ]; then
	install_swaylock
fi

if [ "$WOFI_INSTALL" = true ]; then
	install_wofi
fi

