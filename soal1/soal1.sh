echo -e "\n1.a)"
echo -e "Region dengan profit paling sedikit:"
awk -F '[\t:]' 'FNR==1 {next}{a[$13]+=$21;min=a[$13]}END{for(i in a){if(min>a[i]){min=a[i];r=i}}print r}' Sample-Superstore.tsv

echo -e "\n1.b)"
echo -e "2 State dengan profit paling sedikit:"
awk -F '[\t:]' '{if($13 == "Central")a[$11]+=$21} END {for(i in a) print a[i],i}' Sample-Superstore.tsv | sort -gk1 | awk '(NR<=2) {print $2}'

echo -e "\n1.c)"
echo -e "10 produk yang memiliki profit paling sedikit pada State hasil poin b:"
echo -e "\nTexas:"
awk -F '[\t:]' '{if($11 == "Texas" ) a[$17]+=$21} END {for(i in a) print a[i],i}' Sample-Superstore.tsv | sort -gk1 | awk 'NR<=10 {for(i=2;i<NF;i++) printf "%s", $i OFS; printf "%s", $NF ORS}'
echo -e "\nIllinois:"
awk -F '[\t:]' '{if($11 == "Illinois" ) a[$17]+=$21} END {for(i in a) print a[i],i}' Sample-Superstore.tsv | sort -gk1 | awk 'NR<=10 {for(i=2;i<NF;i++) printf "%s", $i OFS; printf "%s", $NF ORS}'
