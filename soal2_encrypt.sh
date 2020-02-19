#!/bin/bash

file=$1
namafile=${file%.txt}
hour=$(date +%H)
shift=0
awalhurufbesar=65
awalhurufkecil=97
batashurufbesar=90 #huruf besar terakhir
batashurufkecil=122 #huruf kecil terakhir
jarakhuruf=26
newchar=""

if [ $hour == $shift ]
then
	shift=24
else
	shift=$hour
fi

foo=$namafile #line21

for (( i=0; i<${#foo}; i++))
do
	temp=$(echo "${foo:$i:1}")
	asciinum=$(printf "%d\n" "'$temp")
	
	if [ $asciinum -le $batashurufbesar ]
	then
		let new_asciinum=$asciinum+$shift
		
		if [ $new_asciinum -gt $batashurufbesar ]
		then
			let new_asciinum=$new_asciinum-$jarakhuruf
		fi
	elif [ $asciinum -ge $awalhurufkecil ]
	then
		let new_asciinum=$asciinum+$shift
		
		if [ $new_asciinum -gt $batashurufkecil ]
		then #line41
			let new_asciinum=$new_asciinum-$jarakhuruf
		fi
	fi
	
	newchar=$newchar$(printf "\\$(printf '%03o' "$new_asciinum")")
done

mv $file $newchar.txt

date +%H > $newchar.log


