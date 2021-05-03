#!/usr/bin/env bash

function decrypt {
    gpg --decrypt --batch --yes --output "$1" "$1.gpg"
    if [ ! "$?" -eq "0" ]; then
        exit
    fi
}

decrypt inventory/group_vars/all.yml
decrypt inventory/google.gcp_compute.yml

FILES=$(ls ssh/google*.gpg)
for f in $FILES; do
    decrypt $( echo $f | sed 's/\.gpg//' )
done
