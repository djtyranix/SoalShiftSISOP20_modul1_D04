#!/bin/bash

echo -e "\n1.a)"
echo -e "Region dengan profit paling sedikit:"
region=$(awk -F '[\t:]' 'FNR==1 {next}{a[$13]+=$21;min=a[$13]}END{for(i in a) print a[i],i}' Sample-Superstore.tsv | sort -g -k 1 | awk '(NR==1) {print $2}')
echo $region

echo -e "\n1.b)"
echo -e "2 State dengan profit paling sedikit:"
awk -F '[\t:]' -v region="$region" '{if($13 == region )a[$11]+=$21} END {for(i in a) print a[i]"="i}' Sample-Superstore.tsv | sort -g -k 1 > state.txt
awk -F '=' '{print $2}' state.txt | head -2

echo -e "\n1.c)"
echo -e "10 produk yang memiliki profit paling sedikit:"
state1=`awk -F '=' '(NR==1){print $2}' state.txt`
state2=`awk -F '=' '(NR==2){print $2}' state.txt`
echo -e "\n$state1:"
awk -F '[\t:]' -v state1="$state1" '{if($11 == state1 ) a[$17]+=$21} END {for(i in a) print a[i],i}' Sample-Superstore.tsv | sort -g -k 1 | awk '(NR<=10){for(i=2;i<NF;i++) printf "%s", $i OFS; printf "%s", $NF ORS}'
echo -e "\n$state2:"
awk -F '[\t:]' -v state2="$state2" '{if($11 == state2 ) a[$17]+=$21} END {for(i in a) print a[i],i}' Sample-Superstore.tsv | sort -g -k 1 | awk '(NR<=10) {for(i=2;i<NF;i++) printf "%s", $i OFS; printf "%s", $NF ORS}'
