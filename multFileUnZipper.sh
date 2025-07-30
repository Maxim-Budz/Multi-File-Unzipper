#!/bin/bash

for i in ./*; do
	file=$(basename "$i")	
	if [[ $file = *.zip  ]]; then
		echo "unzipping $file to "$1" ..."
		unzip $file -d $1
	fi
done

