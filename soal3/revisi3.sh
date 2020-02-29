#!/bin/bash
rm -f wget.log
dir=`pwd`

for i in $(seq 1 28)
do
        wget -O $dir/downloads/pdkt_kusuma_$i -a $dir/wget.log https://loremflickr.com/320/240/cat
        echo -e $i
done
grep "Location" $dir/wget.log > location.log
cat wget.log >> wget.log.bak

arrdup=($(awk 'BEGIN { FS="[/ ]" } a[$5]++  { print NR }' location.log))
len=${#arrdup[@]}
for ((i=0; i<$len; i=i+1))
do
  mv -f $dir/downloads/pdkt_kusuma_${arrdup[i]} $dir/duplicate/duplicate_$i
done
for j in $(ls $dir/downloads)
do
  mv $dir/downloads/$j $dir/kenangan/kenangan_$((k++))
done
