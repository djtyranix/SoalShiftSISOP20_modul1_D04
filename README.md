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
```
echo -e "\n1.a)"
echo -e "Region dengan profit paling sedikit:"
awk -F '[\t:]' 'FNR==1 {next}{a[$13]+=$21;min=a[$13]}END{for(i in a){if(min>a[i]){min=a[i];r=i}}print r}' Sample-Superstore.tsv
```
```
echo -e "\n1.b)"
echo -e "2 State dengan profit paling sedikit:"
awk -F '[\t:]' '{if($13 == "Central")a[$11]+=$21} END {for(i in a) print a[i],i}' Sample-Superstore.tsv | sort -gk1 | awk '(NR<=2) {print $2}'
```
```
echo -e "\n1.c)"
echo -e "10 produk yang memiliki profit paling sedikit pada State hasil poin b:"
echo -e "\nTexas:"
awk -F '[\t:]' '{if($11 == "Texas" ) a[$17]+=$21} END {for(i in a) print a[i],i}' Sample-Superstore.tsv | sort -gk1 | awk 'NR<=10 {for(i=2;i<NF;i++) printf "%s", $i OFS; printf "%s", $NF ORS}'
echo -e "\nIllinois:"
awk -F '[\t:]' '{if($11 == "Illinois" ) a[$17]+=$21} END {for(i in a) print a[i],i}' Sample-Superstore.tsv | sort -gk1 | awk 'NR<=10 {for(i=2;i<NF;i++) printf "%s", $i OFS; printf "%s", $NF ORS}'
```

## PENJELASAN

```
awk -F '[\t:]' 'FNR==1 {next}{a[$13]+=$21;min=a[$13]}END{for(i in a){if(min>a[i]){min=a[i];r=i}}print r}' Sample-Superstore.tsv
```

-F '[\t:]' untuk separator memisahkan tab  antar kolom. FNR==1 {next} untuk tidak menghiraukan baris pertama yaitu judul kolom. Array dengan key arg ke-13 diisi sum arg ke-21. Pada eof, lakukan for loop untuk mencari nilai terkecil pada array kemudian print hasil sum profit yang paling rendah dari region.

```awk -F '[\t:]' '{if($13 == "Central")a[$11]+=$21} END {for(i in a) print a[i],i}' Sample-Superstore.tsv | sort -gk1 | awk '(NR<=2) {print $2}'```


-F '[\t:]' untuk separator memisahkan tab  antar kolom. Jika kolom ke-13 bernilai "Central", lalu array dengan key arg ke-11 diisi sum arg ke-21. Pada eof, lakukan for loop dalam array dan print isi array ke-"i" dan i. Lalu sorting secara numerik terhadap kolom nilai array[i] “-gk1”. Kemudian print state mana yang profitnya terendah, batasi hanya 2 state saja.

```
echo -e "\nTexas:"
awk -F '[\t:]' '{if($11 == "Texas" ) a[$17]+=$21} END {for(i in a) print a[i],i}' Sample-Superstore.tsv | sort -gk1 | awk 'NR<=10 {for(i=2;i<NF;i++) printf "%s", $i OFS; printf "%s", $NF ORS}'
echo -e "\nIllinois:"
awk -F '[\t:]' '{if($11 == "Illinois" ) a[$17]+=$21} END {for(i in a) print a[i],i}' Sample-Superstore.tsv | sort -gk1 | awk 'NR<=10 {for(i=2;i<NF;i++) printf "%s", $i OFS; printf "%s", $NF ORS}'
```

State Texas:
-F '[\t:]' untuk separator  memisahkan tab  antar kolom. Jika kolom ke-11 bernilai "Texas", lalu array dengan key arg ke-17 diisi sum arg ke-21. Pada eof, lakukan for loop dalam array dan print isi array ke-"i" dan i. Lalu sorting secara numerik terhadap kolom nilai array[i] “-gk1”. Kemudian print string nama produk yang memiliki profit paling rendah, batasi hanya 10 produk yang ditampilkan.

State Illinois:
-F '[\t:]' untuk separator  memisahkan tab  antar kolom. Jika kolom ke-11 bernilai "Illinois", lalu array dengan key arg ke-17 diisi sum arg ke-21. Pada eof, lakukan for loop dalam array dan print isi array ke-"i" dan i. Lalu sorting secara numerik terhadap kolom nilai array[i] “-gk1”. Kemudian print string nama produk yang memiliki profit paling rendah, batasi hanya 10 produk yang ditampilkan.

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
