#!/bin/bash

namafile=$1

namafile_trim=$(echo $namafile | tr -d '0-9')

cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 28 | head -n 1 > $PWD/$namafile_trim
