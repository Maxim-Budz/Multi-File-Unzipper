#!/bin/bash

Destination=$(pwd)
Source=$(pwd)
RemoveOriginal=false
Seperate=false
#Options

while getopts "d:s:rm" option; do
	case $option in
		d) Destination=$OPTARG;;
		s) Source=$OPTARG;;
		m) Seperate=true;;
		r) RemoveOriginal=true;;
		\?) echo "Error: Invalid Option!"
		exit;;
	esac
done

#Check if directories exist and if not create the destination.


if [ ! -d "$Source" ]; then
	echo "Error: Source directory does not exist!"
	exit
fi

if [ ! -d "$Destination" ]; then
	echo "Destination does not exist! Create it? y/n"
	read input

	if [ $input = "Y" ] || [ $input = "y" ]; then
		mkdir $Destination
	else
		exit
	fi
	
fi



#MAIN CODE
echo "Starting unzip..."
echo "Source: $Source"
echo "Destination: $Destination"

for i in ./*; do
	file=$(basename "$i")
	
	if [[ $file = *.zip  ]]; then
		echo "unzipping $file ..."

		if [$Seperate]; then
			unzip $file -d $Destination"/$file"
		else
			unzip $file -d $Destinationi
		fi
		echo "Successfully unzipped $file"
		

		if [$RemoveOriginal]; then
			echo "Removing"
			rm $i
			echo "Removed"
		fi

	fi
done

