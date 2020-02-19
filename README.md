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

Dalam script pertama (soal2.sh), untuk membuat suatu random alphanumeric string akan digunakan dev/urandom. File ini digunakan dengan command "cat". Fungsi "Cat" atau concatenate adalah sebuah fungsi yang digunakan untuk melakukan manipulasi file.
```
cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 28 | head -n 1
```
Kode diatas berfungsi untuk melakukan randomisasi string. "tr" digunakan untuk menentukan karakter apa saja yang termasuk dalam string alphanumerik yang akan dibuat (-dc digunakan untuk memberikan constrain isi string). "fold" digunakan untuk menentukan panjang karakter (-w digunakan untuk mengubah default menjadi width). "head -n" digunakan untuk mengeluarkan baris pertama dari file yang nantinya akan dihasilkan oleh fungsi "cat".

Setelah soal2.sh selesai dilakukan




## 3. Soal Nomor 3
