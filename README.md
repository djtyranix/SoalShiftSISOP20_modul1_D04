# Laporan Penjelasan dan Penyelesaian Praktikum Sistem Operasi 2020
## Kelompok D04
1. Michael Ricky (05111840000078)
2. Yaniar (NRP)

# Penjelasan dan Penyelesaian Soal Praktikum
## 1. Soal Nomor 1
## 2. Soal Nomor 2
Link ke file yang dibuat:
* [soal2.sh](https://github.com/djtyranix/SoalShiftSISOP20_modul1_D04/blob/master/soal2.sh) - Script pertama
* [soal2_encrypt.sh](https://github.com/djtyranix/SoalShiftSISOP20_modul1_D04/blob/master/soal2_encrypt.sh) - Script Enkripsi
* [soal2_decrypt.sh](https://github.com/djtyranix/SoalShiftSISOP20_modul1_D04/blob/master/soal2_decrypt.sh) - Script Dekripsi


Pada soal ini, goal dari soal adalah untuk membuat 2 script. 1 Script digunakan untuk membuat file bernama sesuai dengan argument yang diinput saat menjalankan script, dan script yang lain digunakan untuk melakukan "enkripsi" nama file sesuai dengan algoritma Vigenère Cipher (yang pada dasarnya adalah caesar cipher yang memiliki "custom shift").

Dalam script [soal2.sh](https://github.com/djtyranix/SoalShiftSISOP20_modul1_D04/blob/master/soal2.sh), untuk membuat suatu random alphanumeric string akan digunakan dev/urandom. File ini digunakan dengan command "cat". Fungsi "Cat" atau concatenate adalah sebuah fungsi yang digunakan untuk melakukan manipulasi file.
```
cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 28 | head -n 1
```
Kode diatas berfungsi untuk melakukan randomisasi string. "tr" digunakan untuk menentukan karakter apa saja yang termasuk dalam string alphanumerik yang akan dibuat (-dc digunakan untuk memberikan constrain isi string). "fold" digunakan untuk menentukan panjang karakter (-w digunakan untuk mengubah default menjadi width). "head -n" digunakan untuk mengeluarkan baris pertama dari file yang nantinya akan dihasilkan oleh fungsi "cat".

Setelah script soal2.sh selesai dilakukan, pengguna akan melakukan "enkripsi" dari nama file yang telah dibuat sebelumnya. Hal ini akan dilakukan oleh script kedua, yaitu [soal2_encrypt.sh](https://github.com/djtyranix/SoalShiftSISOP20_modul1_D04/blob/master/soal2_encrypt.sh).

## Dalam file tersebut, ada beberapa algoritma yang digunakan untuk mencari string enkripsi dari nama file berdasarkan Vigenère Cipher.

* Algoritma mencari shift
  Algoritmanya cukup simpel dan straightforward. Dari soal, dapat langsung terlihat bahwa shift ditentukan oleh jam kapan script enkripsi tersebut dijalankan. Berarti, jika jam saat script dijalankan adalah jam 7 malam (secara 24-h clock format), maka shiftnya adalah 19, dan seperti itu seterusnya. Kasus special case terjadi pada jam 12 malam, atau dalam 24-h format adalah 00:00. Jika langsung dimasukkan ke dalam shift, maka tidak akan ada yang berubah dalam nama file karena shiftnya 0. Dalam file ini, pada jam 00:00 sampai 00:59, akan dihitung dengan shift = 24, dengan fakta bahwa 24:00 adalah 00:00.
* Algoritma melakukan cipher
  Untuk melakukan cipher, dibutuhkan adanya variabel yang akan menampung string per karakter setiap kali dilakukan loop sepanjang suatu string. Variabel yang digunakan dalam script ini adalah temp yang berada di dalam perintah for. Untuk penambahan karakter oleh shift yang sudah ditentukan, karakter akan terlebih dahulu di ubah ke bentuk ASCII Code desimal. Kemudian, kode ASCII ini akan ditambah oleh shift yang sudah ditentukan, tetapi untuk beberapa kasus akan muncul karakter yang tidak diinginkan karena range ASCII untuk karakter huruf terbatas. Oleh karena itu, dalam script tersebut memiliki fungsi if dalam for yang digunakan untuk memisahkan karakter lowercase uppercase dan pembatasan karakter huruf di dalamnya. Setelah didapat angka ASCII Code yang baru, lalu akan disimpan ke dalam suatu variabel (dalam script ini adalah newchar). Sebelum disimpan, angka ASCII ini akan dirubah terlebih dahulu ke dalam bentuk huruf kembali.

## 3. Soal Nomor 3
