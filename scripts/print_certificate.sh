#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "You should provide one argument: the path of a X.509 certificate."
    exit 1
fi

CERTIFICATE_PATH=$1

if [ -f "$CERTIFICATE_PATH" ]; then
    openssl x509 -text -noout -in $CERTIFICATE_PATH
else
    echo "'$CERTIFICATE_PATH' does not exist."
    exit 1
fi
