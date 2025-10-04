#!/usr/bin/env bash

aurHelper () {
	if ! [ -z "$(command -v yay)" ]; then
		echo "## AUR Helper Detectado: Yay"
		aurHelperFound="Yay"

	elif ! [ -z "$(command -v paru)" ]; then
		echo "## AUR Helper Detectado: Paru"
		aurHelperFound="Paru"
	else
		sudo pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com
		sudo pacman-key --lsign-key 3056513887B78AEB
	
		sudo pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst' --noconfirm --needed
		sudo pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst' --noconfirm --needed
	
		sudo sed -i '$a\[chaotic-aur]\nInclude = /etc/pacman.d/chaotic-mirrorlist' /etc/pacman.conf
		
		sudo pacman -Syu yay --noconfirm --needed
		aurHelperFound="Yay"
	fi
}

${aurHelperFound} -S xlibre-input-libinput xlibre-xserver --noconfirm
	
