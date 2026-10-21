#!/bin/bash

# Directory that contains keys and certificates
TMP_FOLDER='/tmp/minipki'

if [ ! -d "$TMP_FOLDER" ]; then
    echo "Run scripts/setup.sh before running this script."
    exit 1
fi

ROOT_CA_CERTIFICATE="${TMP_FOLDER}/root_ca_certificate.crt"
INTERMEDIATE_CA_CERTIFICATE="${TMP_FOLDER}/intermediate_ca_certificate.crt"
SERVER_CERTIFICATE="${TMP_FOLDER}/server_certificate.crt"

openssl verify -verbose \
    -CAfile $ROOT_CA_CERTIFICATE \
    -untrusted $INTERMEDIATE_CA_CERTIFICATE \
    $SERVER_CERTIFICATE