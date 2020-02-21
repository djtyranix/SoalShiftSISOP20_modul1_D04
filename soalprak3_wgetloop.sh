#!/bin/bash

a=0
b=1

while [ $a -lt 28 ]
do
	wget https://loremflickr.com/320/240/cat -o wget.log
	let a=$a+$b
done
