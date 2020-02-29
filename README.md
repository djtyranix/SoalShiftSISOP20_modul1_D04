# Laporan Penjelasan dan Penyelesaian Praktikum Sistem Operasi 2020
## Kelompok D04
1. Michael Ricky (05111840000078)
2. Yaniar Pradityas Effendi (05111840000047)

# Penjelasan dan Penyelesaian Soal Praktikum
## 1. Soal Nomor 1
Whits adalah seorang mahasiswa teknik informatika. Dia mendapatkan tugas praktikum
untuk membuat laporan berdasarkan data yang ada pada file “Sample-Superstore.tsv”.
Namun dia tidak dapat menyelesaikan tugas tersebut. Laporan yang diminta berupa :
a. Tentukan wilayah bagian (region) mana yang memiliki keuntungan (profit) paling
sedikit
b. Tampilkan 2 negara bagian (state) yang memiliki keuntungan (profit) paling
sedikit berdasarkan hasil poin a
c. Tampilkan 10 produk (product name) yang memiliki keuntungan (profit) paling
sedikit berdasarkan 2 negara bagian (state) hasil poin b
Whits memohon kepada kalian yang sudah jago mengolah data untuk mengerjakan
laporan tersebut.
*Gunakan Awk dan Command pendukung

## JAWABAN

Link ke file yang dibuat:
* [soal1.sh](https://github.com/djtyranix/SoalShiftSISOP20_modul1_D04/blob/master/soal1/soal1.sh) - Script pertama

```
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
```

## PENJELASAN
```
echo -e "\n1.a)"
echo -e "Region dengan profit paling sedikit:"
region=$(awk -F '[\t:]' 'FNR==1 {next}{a[$13]+=$21;min=a[$13]}END{for(i in a) print a[i],i}' Sample-Superstore.tsv | sort -g -k 1 | awk '(NR==1) {print $2}')
echo $region
```

-F '[\t:]' untuk separator memisahkan tab  antar kolom. FNR==1 {next} untuk tidak menghiraukan baris pertama yaitu judul kolom. Array dengan key arg ke-13 diisi sum arg ke-21. Pada eof, lakukan isi masing-masing array dan indeksnya. Kemudian di sort -g -k 1 yaitu sorting menurut general arithmetic (ascending) menurut kolom 1 yaitu profit. Kemudian diambil NR==1 untuk nilai profit terkecil dan di print nama regionnya. Hasil print disimpan di variabel region. Dan echo $region untuk display isi variabel region yang merupakan region dengan profit paling sedikit.

```
echo -e "\n1.b)"
echo -e "2 State dengan profit paling sedikit:"
awk -F '[\t:]' -v region="$region" '{if($13 == region )a[$11]+=$21} END {for(i in a) print a[i]"="i}' Sample-Superstore.tsv | sort -g -k 1 > state.txt
awk -F '=' '{print $2}' state.txt | head -2
```

-F '[\t:]' untuk separator memisahkan tab  antar kolom. Menggunakan -v untuk memakai variabel region ke AWK. Jika kolom ke-13 bernilai sama denga nisi variabel region, lalu array dengan key arg ke-11 diisi sum arg ke-21. Pada eof, lakukan for loop dalam array dan print isi array ke-"i", separator “=”, kemudian indeks “I”. Disorting -g -k 1 yaitu secara general arithmetic (ascending) terhadap kolom 1 yaitu nilai array[i]. Kemudian hasil disimpan ke file bernama “state.txt”. Kemudian untuk mencetak 2 state dengan profit terendah, print kolom 2 pada file “state.txt” yaitu nama state-nya dan digunakan head -2 untuk mengambil hanya 2 nilai saja.

```
echo -e "\n1.c)"
echo -e "10 produk yang memiliki profit paling sedikit:"
state1=`awk -F '=' '(NR==1){print $2}' state.txt`
state2=`awk -F '=' '(NR==2){print $2}' state.txt`
```

Passing nilai baris 1 dari file “state.txt” yang merupakan hasil dari 1b sebagai state1 agar kemudian digunakan di nomor 1c.
Serta passing nilai baris 2 dari file yang sama sebagai state2 agar kemudian bisa digunakan di nomor 1c.

```
echo -e "\n$state1:"
awk -F '[\t:]' -v state1="$state1" '{if($11 == state1 ) a[$17]+=$21} END {for(i in a) print a[i],i}' Sample-Superstore.tsv | sort -g -k 1 | awk '(NR<=10){for(i=2;i<NF;i++) printf "%s", $i OFS; printf "%s", $NF ORS}'
```

-F '[\t:]' untuk separator  memisahkan tab  antar kolom. Menggunakan -v untuk memakai variabel state1 ke AWK. Jika kolom ke-11 bernilai sama dengan isi variabel state1, lalu array dengan key arg ke-17 diisi sum arg ke-21. Pada eof, lakukan for loop dalam array a dan print isi array dengan indeks ke-"i" dan indeks “I”-nya. Lalu disorting -g -k 1 yaitu secara general arithmetic (ascending) terhadap kolom nilai array[i] yaitu nilai profit. Kemudian print string nama produk yang memiliki profit paling rendah, batasi hanya 10 produk yang ditampilkan (NR<=10).

```
echo -e "\n$state2:"
awk -F '[\t:]' -v state2="$state2" '{if($11 == state2 ) a[$17]+=$21} END {for(i in a) print a[i],i}' Sample-Superstore.tsv | sort -g -k 1 | awk '(NR<=10) {for(i=2;i<NF;i++) printf "%s", $i OFS; printf "%s", $NF ORS}'
```

Mirip dengan state1. Pertama, -F '[\t:]' untuk separator  memisahkan tab  antar kolom. Menggunakan -v untuk memakai variabel state2 ke AWK. Jika kolom ke-11 bernilai sama dengan isi variabel state1, lalu array dengan key arg ke-17 diisi sum arg ke-21. Pada eof, lakukan for loop dalam array a dan print isi array dengan indeks ke-"i" dan indeks “I”-nya. Lalu disorting -g -k 1 yaitu secara general arithmetic (ascending) terhadap kolom nilai array[i] yaitu nilai profit. Kemudian print string nama produk yang memiliki profit paling rendah, batasi hanya 10 produk yang ditampilkan (NR<=10).

Untuk menjalankan awk, ketik command bash soal1.sh

## 2. Soal Nomor 2
Pada suatu siang, laptop Randolf dan Afairuzr dibajak oleh seseorang dan kehilangan
data-data penting. Untuk mencegah kejadian yang sama terulang kembali mereka
meminta bantuan kepada Whits karena dia adalah seorang yang punya banyak ide.
Whits memikirkan sebuah ide namun dia meminta bantuan kalian kembali agar ide
tersebut cepat diselesaikan. Idenya adalah kalian (a) membuat sebuah script bash yang
dapat menghasilkan password secara acak sebanyak 28 karakter yang terdapat huruf
besar, huruf kecil, dan angka. (b) Password acak tersebut disimpan pada file berekstensi
.txt dengan nama berdasarkan argumen yang diinputkan dan HANYA berupa alphabet.
(c) Kemudian supaya file .txt tersebut tidak mudah diketahui maka nama filenya akan di
enkripsi dengan menggunakan konversi huruf (string manipulation) yang disesuaikan
dengan jam(0-23) dibuatnya file tersebut dengan program terpisah dengan (misal:
password.txt dibuat pada jam 01.28 maka namanya berubah menjadi qbttxpse.txt
dengan perintah ‘bash soal2_enkripsi.sh password.txt’. Karena p adalah huruf ke 16 dan
file dibuat pada jam 1 maka 16+1=17 dan huruf ke 17 adalah q dan begitu pula
seterusnya. Apabila melebihi z, akan kembali ke a, contoh: huruf w dengan jam 5.28,
maka akan menjadi huruf b.) dan (d) jangan lupa untuk membuat dekripsinya supaya
nama file bisa kembali.
HINT: enkripsi yang digunakan adalah caesar cipher.
*Gunakan Bash Script

## JAWABAN

Link ke file yang dibuat:
* [soal2.sh](https://github.com/djtyranix/SoalShiftSISOP20_modul1_D04/blob/master/soal2/soal2.sh) - Script pertama
* [soal2_encrypt.sh](https://github.com/djtyranix/SoalShiftSISOP20_modul1_D04/blob/master/soal2/soal2_encrypt.sh) - Script Enkripsi
* [soal2_decrypt.sh](https://github.com/djtyranix/SoalShiftSISOP20_modul1_D04/blob/master/soal2/soal2_decrypt.sh) - Script Dekripsi

Detail penjalanan script:
* soal2.sh
  ```
  ./soal2.sh <namafile>.txt
  ```
* soal2_encrypt.sh
  ```
  ./soal2_encrypt <namafile>.txt
  ```
* soal2_decrypt.sh
  ```
  ./soal2_decrypt <namafile_terenkripsi>.txt
  ```
## Penjelasan Penyelesaian
Pada soal ini, goal dari soal adalah untuk membuat 2 script. 1 Script digunakan untuk membuat file bernama sesuai dengan argument yang diinput saat menjalankan script, dan script yang lain digunakan untuk melakukan "enkripsi" nama file sesuai dengan algoritma Vigenère Cipher (yang pada dasarnya adalah caesar cipher yang memiliki "custom shift").

Dalam script [soal2.sh](https://github.com/djtyranix/SoalShiftSISOP20_modul1_D04/blob/master/soal2/soal2.sh), untuk membuat suatu random alphanumeric string akan digunakan dev/urandom. File ini digunakan dengan command "cat". Fungsi "Cat" atau concatenate adalah sebuah fungsi yang digunakan untuk melakukan manipulasi file.
```
cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 28 | head -n 1
```
Kode diatas berfungsi untuk melakukan randomisasi string. "tr" digunakan untuk menentukan karakter apa saja yang termasuk dalam string alphanumerik yang akan dibuat (-dc digunakan untuk memberikan constrain isi string). "fold" digunakan untuk menentukan panjang karakter (-w digunakan untuk mengubah default menjadi width). "head -n" digunakan untuk mengeluarkan baris pertama dari file yang nantinya akan dihasilkan oleh fungsi "cat".

Setelah script soal2.sh selesai dilakukan, pengguna akan melakukan "enkripsi" dari nama file yang telah dibuat sebelumnya. Hal ini akan dilakukan oleh script kedua, yaitu [soal2_encrypt.sh](https://github.com/djtyranix/SoalShiftSISOP20_modul1_D04/blob/master/soal2/soal2_encrypt.sh).

## Dalam file tersebut, ada 2 algoritma utama yang digunakan untuk mencari string enkripsi dari nama file berdasarkan Vigenère Cipher.

* Algoritma mencari shift
  Algoritmanya cukup simpel dan straightforward. Dari soal, dapat langsung terlihat bahwa shift ditentukan oleh jam kapan script enkripsi tersebut dijalankan. Berarti, jika jam saat script dijalankan adalah jam 7 malam (secara 24-h clock format), maka shiftnya adalah 19, dan seperti itu seterusnya. Kasus special case terjadi pada jam 12 malam, atau dalam 24-h format adalah 00:00. Jika langsung dimasukkan ke dalam shift, maka tidak akan ada yang berubah dalam nama file karena shiftnya 0. Dalam file ini, pada jam 00:00 sampai 00:59, akan dihitung dengan shift = 24, dengan fakta bahwa 24:00 adalah 00:00.
* Algoritma melakukan cipher
  Untuk melakukan cipher, dibutuhkan adanya variabel yang akan menampung string per karakter setiap kali dilakukan loop sepanjang suatu string. Variabel yang digunakan dalam script ini adalah temp yang berada di dalam perintah for. Untuk penambahan karakter oleh shift yang sudah ditentukan, karakter akan terlebih dahulu di ubah ke bentuk ASCII Code desimal. Kemudian, kode ASCII ini akan ditambah oleh shift yang sudah ditentukan, tetapi untuk beberapa kasus akan muncul karakter yang tidak diinginkan karena range ASCII untuk karakter huruf terbatas. Oleh karena itu, dalam script tersebut memiliki fungsi if dalam for yang digunakan untuk memisahkan karakter lowercase uppercase dan pembatasan karakter huruf di dalamnya. Setelah didapat angka ASCII Code yang baru, lalu akan disimpan ke dalam suatu variabel (dalam script ini adalah newchar). Sebelum disimpan, angka ASCII ini akan dirubah terlebih dahulu ke dalam bentuk huruf kembali.

## Melakukan dekripsi nama file
Untuk melakukan dekripsi nama file, hal yang harus dilakukan hanyalah menjalankan [soal2_decrypt.sh](https://github.com/djtyranix/SoalShiftSISOP20_modul1_D04/blob/master/soal2/soal2_decrypt.sh) dan memasukkan nama file yang ter-cipher untuk di-decipher.

Hal ini dapat dilakukan karena pada file enkripsi, telah ditambahkan fungsi untuk membuat log terkait file tersebut. Isi dari file log tersebut adalah jam saat script enkripsi dijalankan. Oleh karena itu, di dalam script decryption, script akan mengambil angka yang ada di dalam file log tersebut dan akan menggunakannya sebagai shift. Algoritma shifting yang digunakan tidak berbeda, kecuali pada arah shift. Dalam script enkripsi file, shifting dilakukan maju. Sementara dalam script dekripsi file, shifting dilakukan berlawanan arah, yaitu mundur. 

## 3. Soal Nomor 3
1 tahun telah berlalu sejak pencampakan hati Kusuma. Akankah sang pujaan hati
kembali ke naungan Kusuma? Memang tiada maaf bagi Elen. Tapi apa daya hati yang
sudah hancur, Kusuma masih terguncang akan sikap Elen. Melihat kesedihan Kusuma,
kalian mencoba menghibur Kusuma dengan mengirimkan gambar kucing. [a] Maka dari
itu, kalian mencoba membuat script untuk mendownload 28 gambar dari
"https://loremflickr.com/320/240/cat" menggunakan command wget dan menyimpan file
dengan nama "pdkt_kusuma_NO" (contoh: pdkt_kusuma_1, pdkt_kusuma_2,
pdkt_kusuma_3) serta jangan lupa untuk menyimpan log messages wget kedalam
sebuah file "wget.log". Karena kalian gak suka ribet, kalian membuat penjadwalan untuk
menjalankan script download gambar tersebut. Namun, script download tersebut hanya
berjalan[b] setiap 8 jam dimulai dari jam 6.05 setiap hari kecuali hari Sabtu Karena
gambar yang didownload dari link tersebut bersifat random, maka ada kemungkinan
gambar yang terdownload itu identik. Supaya gambar yang identik tidak dikira Kusuma
sebagai spam, maka diperlukan sebuah script untuk memindahkan salah satu gambar
identik. Setelah memilah gambar yang identik, maka dihasilkan gambar yang berbeda
antara satu dengan yang lain. Gambar yang berbeda tersebut, akan kalian kirim ke
Kusuma supaya hatinya kembali ceria. Setelah semua gambar telah dikirim, kalian akan
selalu menghibur Kusuma, jadi gambar yang telah terkirim tadi akan kalian simpan
kedalam folder /kenangan dan kalian bisa mendownload gambar baru lagi. [c] Maka dari
itu buatlah sebuah script untuk mengidentifikasi gambar yang identik dari keseluruhan
gambar yang terdownload tadi. Bila terindikasi sebagai gambar yang identik, maka
sisakan 1 gambar dan pindahkan sisa file identik tersebut ke dalam folder ./duplicate
dengan format filename "duplicate_nomor" (contoh : duplicate_200, duplicate_201).
Setelah itu lakukan pemindahan semua gambar yang tersisa kedalam folder ./kenangan
dengan format filename "kenangan_nomor" (contoh: kenangan_252, kenangan_253).
Setelah tidak ada gambar di current directory, maka lakukan backup seluruh log menjadi
ekstensi ".log.bak". Hint : Gunakan wget.log untuk membuat location.log yang isinya
merupakan hasil dari grep "Location".
*Gunakan Bash, Awk dan Crontab


## JAWABAN

Link ke file yang dibuat:
* [revisi3.sh](https://github.com/djtyranix/SoalShiftSISOP20_modul1_D04/blob/master/soal3/revisi3.sh) - Script pertama
```
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
```

## PENJELASAN
3.a)
```
dir=`pwd`

for i in $(seq 1 28)
do
        wget -O $dir/downloads/pdkt_kusuma_$i -a $dir/wget.log https://loremflickr.com/320/240/cat
        echo -e $i
done
```
Untuk mendownload 28 gambar dari https://loremflickr.com/320/240/cat, serta display angka 1-28 yang menunjukkan telah download berapa gambar.

b)
```
5 6-23/8 * * 0-5 /bin/bash /home/yaniarpe/revisi3.sh
```
Penjadwalan pada crontab. 5 untuk menit ke 05, 6-23/8 menunjukkan jam tiap hari per 8 jam, dan terakhir 0-5 menunjukkan hari Minggu – Jumat.

c)
```
grep "Location" $dir/wget.log > location.log
cat wget.log >> wget.log.bak
```
Menggunakan wget.log untuk membuat location.log yang isinya merupakan hasil dari grep "Location". Kemudian append wget.log ke file back upnya

```
arrdup=($(awk 'BEGIN { FS="[/ ]" } a[$5]++  { print NR }' location.log))
len=${#arrdup[@]}
for ((i=0; i<$len; i=i+1))
do
  mv -f $dir/downloads/pdkt_kusuma_${arrdup[i]} $dir/duplicate/duplicate_$i
done
```

Menggunakan AWK untuk mencari gambar yang sama yang telah didownload dengan membandingkan kolom $5 yang merupakan nama file, lalu print nomor barisnya saja (NR) lalu disimpan ke variabel array “arrdup”. Variabel len merupakan nilai untuk Panjang array. Sehingga bias dilakukan looping sepanjang array arrdup untuk memindahkan file-file gambar yang berduplikat ke folder duplicate dan memberi nama dengan format duplicate_nomor.

```
for j in $(ls $dir/downloads)
do
  mv $dir/downloads/$j $dir/kenangan/kenangan_$((k++))
done
```

Melakukan looping sebanyak jumlah file pada folder downloads yaitu yang berisi sisa gambar yang sudah tidak berduplikat, dipindahkan seluruhnya ke folder kenangan dan diberi nama dengan format kenangan_nomor.
