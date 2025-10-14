#!/usr/bin/env bash

source /etc/os-release

if [[ "ID" == "artix" ]]; then
	echo "Artix Detectado!"
	echo "Detectando o Init..."
	if [ -z "$(sudo pacman -Qs openrc)" ]; then
		init="openrc"
		echo "Init detectado: OpenRC"
	elif [ -z "$(sudo pacman -Qs runit)" ]; then
		init="runit"
		echo "Init detectado: Runit"
	elif [ -z "$(sudo pacman -Qs s6-base)" ]; then
		init="s6-base"
		echo "Init detectado: S6"
	elif [ -z "$(sudo pacman -Qs dinit)" ]; then
		init="dinit"
		echo "Init detectado: dinit"
	fi
	
	lightDM="lightdm-${init}"
	
	echo $lightDM
else
	lightDM="lightdm"
fi
