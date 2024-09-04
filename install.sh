#!/bin/bash

source ./funs.sh

source ./setup.sh

if [ "$SWAY_INSTALL" = true ]; then
	install_sway
	echo "sway config installed"
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

if [ "$WALLPAPERS_INSTALL" = true ]; then
	install_wallpapers
	echo "wallpapers copied"
fi
