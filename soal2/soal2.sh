#!/bin/bash

namafile=$1

namafile_trim=$(echo $namafile | tr -dc 'a-zA-Z.')

if [ $namafile == $namafile_trim ]
then
	cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 28 | head -n 1 | (/^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9]).*$) > $PWD/$namafile_trim
else
	echo -e "Nama file hanya boleh menggunakan huruf saja. Silahkan jalankan script kembali.\n"
fi
