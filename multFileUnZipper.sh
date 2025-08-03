#!/bin/bash





#TODO:
#Create  a function so that while the file contents exists in the destination, update the
#name of the new file with number at end

Destination=$(pwd)
Source=$(pwd)
RemoveOriginal=0
Seperate=0

#Options
while getopts "d:s:rm" option; do
	case $option in
		d) Destination=$OPTARG;;
		s) Source=$OPTARG;;
		m) Seperate=1;;
		r) RemoveOriginal=1;;
		\?) echo "Error: Invalid Option!"
		exit;;
	esac
done

if [ ! -d "$Source" ]; then
	echo "Error: Source directory does not exist!"
	exit
fi

if [ ! -d "$Destination" ]; then
	echo "Destination does not exist! Create it? y/n"
	read input

	if [ $input = "Y" ] || [ $input = "y" ]; then
		mkdir "$Destination"
	else
		exit
	fi
	
fi

#MAIN CODE
#TODO: Check if a folder already exists then rename the new folder to something different
for i in "$Source"/*; do
	file=$(basename "$i")
	mime=$( file -b --mime-type "$i")
	mime="${mime##*/}"
	remove=1
	case "$mime" in

		"zip")
			#unzip zip
			
			if [ $Seperate = 1 ]; then
				newFileName=${file%".zip"}
				unzip "$Source/$file" -d "$Destination/$newFileName"
			else
				#if [-d "$Destination/$file" ]
				unzip "$Source/$file" -d "$Destination"
			fi;;
		"x-tar")
			#unzip tar
			#if [-d "$Destination/$file" ]
			tar -xf "$Source/$file" -C "$Destination";;
		"x-7z-compressed")
			#unzip tar
			#if [-d "$Destination/$file" ]
			7z x "$Source/$file" -o"$Destination";;

		"x-bzip2")
			#unzip tar
			#if [-d "$Destination/$file" ]
			tar -xjf "$Source/$file" -C "$Destination";;

		"gzip")
			#unzip tar.gz
			#if [-d "$Destination/$file" ]
			tar -xzf "$Source/$file" -C "$Destination";;

		*)
			remove=0;;


	esac

		if (( $RemoveOriginal == 1  &&  $remove == 1 )); then
			rm "$i"
		fi
done

