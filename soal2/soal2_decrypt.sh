#!/bin/bash

file=$1
namafile=${file%.txt}

while read line
do
	shift=$(echo $line)
done < $namafile.log

awalhurufbesar=65
awalhurufkecil=97
batashurufbesar=90 #huruf besar terakhir
batashurufkecil=122 #huruf kecil terakhir
jarakhuruf=26
newchar=""

foo=$namafile #line21

for (( i=0; i<${#foo}; i++))
do
	temp=$(echo "${foo:$i:1}")
	asciinum=$(printf "%d\n" "'$temp")
	
	if [ $asciinum -le $batashurufbesar ]
	then
		let new_asciinum=$asciinum-$shift
		
		if [ $new_asciinum -lt $awalhurufbesar ]
		then
			let new_asciinum=$new_asciinum+$jarakhuruf
		fi
	elif [ $asciinum -ge $awalhurufkecil ]
	then
		let new_asciinum=$asciinum-$shift
		
		if [ $new_asciinum -lt $awalhurufkecil ]
		then #line41
			let new_asciinum=$new_asciinum+$jarakhuruf
		fi
	fi
	
	newchar=$newchar$(printf "\\$(printf '%03o' "$new_asciinum")")
done

mv $file $newchar.txt

rm $namafile.log

