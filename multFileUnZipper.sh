#!/bin/bash

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





#TODO: Check if a folder already exists then rename the new folder to something different
for i in "$Source"/*; do
	#echo "$i"
	file=$(basename "$i")
	#echo "$file"
	if [[ "$file" = *.zip  ]]; then
		echo "unzipping "$Source/$file" ..." 
		if [ $Seperate = 1 ]; then
			unzip "$Source/$file" -d "$Destination/$file"
		else
			unzip "$Source/$file" -d "$Destination"
		fi
		#echo "Successfully unzipped $file"
		

		if [ $RemoveOriginal = 1 ]; then
			#echo "Removing"
			rm "$i"
			#echo "Removed"
		fi

	fi
done

