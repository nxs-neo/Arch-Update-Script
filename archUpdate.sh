#!/bin/sh

R='\033[1;4;31m'
G='\033[1;4;32m'
B='\033[1;4;34m'
Y='\033[1;4;33m'
NORMAL='\033[0m'

__pcmn () {

	echo
	echo "${Y}Updating...${NORMAL}"
	echo
	if [ "$1" = "-ay" ]; 
	then 
		sudo pacman -Syu --noconfirm
	fi
	if [ "$1" = "-a" ]; 
	then 
		sudo pacman -Syu
	else
		sudo pacman -Syu --noconfirm
	fi


}

__fltpk () {

	echo
	echo "${B}Updating...${NORMAL}"
	echo
	if [ "$1" = "-ay" ];
	then 
		flatpak -y update
	fi
	if [ "$1" = "-a" ];
	then 
		flatpak update
	else
		flatpak -y update
	fi
}

__aur () {

	echo
	echo "${R}Updating...${NORMAL}"
	echo
	if [ "$1" = "-ay" ]; 
	then 
		yay -Syu --aur --noconfirm
	fi
	if [ "$1" = "-a" ]; 
	then 
		yay -Syu --aur 
	else
		yay -Syu --aur --noconfirm
	fi
}

update () {
  

	if [ -z "$1" ]; 
	then 
		__pcmn
		__fltpk
		__aur		
	fi

	while [ "$#" -gt 0 ]; do
		case "$1" in
			-a|--ask)
				echo "${Y}Do you want to update Pacman packages?${NORMAL}"
				read -r yn
				if (true) then
					case $yn in
						yes|Yes|YES|y|Y ) __pcmn "-a";;
						no|NO|No|n|N ) ;;
						* ) echo "${R}invalid response${NORMAL}" ;;
					esac
				fi

				echo ""
				echo "${B}Do you want to update Flatpak packages?${NORMAL}"
				read -r yn
				case $yn in 
					yes|Yes|YES|y|Y ) __fltpk "-a";;
					no|NO|No|n|N ) ;;
					* ) echo "${R}invalid response${NORMAL}" ;;
				esac	

				echo ""
				echo "${R}Do you want to update __aur packages?${NORMAL}"
				read -r yn
				case $yn in 
					yes|Yes|YES|y|Y ) __aur "-a"; return;;
					no|NO|No|n|N ) return;;
					* ) echo "${R}invalid response${NORMAL}" ;;
				esac
				echo "${G}DONE!!${NORMAL}"		
			;;


			-ay)
				echo "${Y}Do you want to update Pacman packages?${NORMAL}"
				read -r yn
				if (true) then
					case $yn in
						yes|Yes|YES|y|Y ) __pcmn "-ay";;
						no|NO|No|n|N ) ;;
						* ) echo "${R}invalid response${NORMAL}" ;;
					esac
				fi

				echo ""
				echo "${B}Do you want to update Flatpak packages?${NORMAL}"
				read -r yn
				case $yn in 
					yes|Yes|YES|y|Y ) __fltpk "-ay";;
					no|NO|No|n|N ) ;;
					* ) echo "${R}invalid response${NORMAL}" ;;
				esac	

				echo ""
				echo "${R}Do you want to update __aur packages?${NORMAL}"
				read -r yn
				case $yn in 
					yes|Yes|YES|y|Y ) __aur "-ay"; return;;
					no|NO|No|n|N ) return;;
					* ) echo "${R}invalid response${NORMAL}" ;;
				esac
				echo "${G}DONE!!${NORMAL}"		
			;;

			-h|--help)
				echo ""
				echo "Arch Update Script written by Neo"
				echo
				echo "OPTIONS: "
				echo "default behaviour: run updates for all package managers without asking"
				echo "-a or --ask : ask what package managers to update for. "
				echo "-h or --help : run this help dialogue"
				echo "-s or --shutdown : update and shutdown"
				echo "-r or --reboot or --restart : update and reboot"
				echo
				return
			;;

			-s|--shutdown) 
				__pcmn
				__fltpk
				__aur
				shutdown now
			;;

			-r|--reboot|--restart)
				__pcmn
				__fltpk
				__aur
				reboot
			;;

			*)
				echo "Invalid Parameter"
				return
			;;
		esac
	done
}

