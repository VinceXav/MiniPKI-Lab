#!/bin/bash

# Directory that contains keys
TMP_FOLDER='/tmp/minipki'
mkdir -p $TMP_FOLDER

ROOT_CA_PRIVATE_KEY="${TMP_FOLDER}/root_ca_private.key"
ROOT_CA_CERTIFICATE="${TMP_FOLDER}/root_ca_certificate.crt"

INTERMEDIATE_CA_PRIVATE_KEY="${TMP_FOLDER}/intermediate_ca_private.key"
INTERMEDIATE_CA_CERTIFICATE="${TMP_FOLDER}/intermediate_ca_certificate.crt"
INTERMEDIATE_CA_REQUEST="${TMP_FOLDER}/intermediate_ca_request.csr"

SERVER_PRIVATE_KEY="${TMP_FOLDER}/server_private.key"
SERVER_CERTIFICATE="${TMP_FOLDER}/server_certificate.crt"
SERVER_REQUEST="${TMP_FOLDER}/server_request.csr"

###################
# Root CA         #
###################

# Generate RSA 4096 bits keys for root CA and enerate self-signed certificate
openssl req -x509 \
    -newkey rsa:4096 \
    -noenc \
    -keyout $ROOT_CA_PRIVATE_KEY \
    -out $ROOT_CA_CERTIFICATE \
    -days 365 \
    -subj "/C=FR/ST=France/L=Paris/O=MiniPKI/CN=root.ca" \
    -quiet

###################
# Intermediate CA #
###################

# Generate intermediate CA key, and make a CSR to the Root CA
openssl req -sha256 -noenc \
    -newkey rsa:4096 \
    -keyout $INTERMEDIATE_CA_PRIVATE_KEY \
    -out $INTERMEDIATE_CA_REQUEST \
    -subj "/C=FR/ST=France/L=Paris/O=MiniPKI/CN=intermediate.ca" \
    -quiet

# Display request info and verify the self-signature :
# openssl req -text -in /tmp/minipki/intermediate_ca_request.csr -noout -verify

# Root CA process the request (generate intermediate certificate)
openssl x509 -req \
    -in $INTERMEDIATE_CA_REQUEST \
    -CA $ROOT_CA_CERTIFICATE \
    -CAkey $ROOT_CA_PRIVATE_KEY \
    -out $INTERMEDIATE_CA_CERTIFICATE \
    -days 365 \
    -sha256

# Display intermediate certificate
# openssl x509 -in /tmp/minipki/intermediate_ca_certificate.crt -noout -text

###################
# Server          #
###################

# Generate server key, and make a CSR to the intermediate CA
openssl req -sha256 -noenc \
    -newkey rsa:4096 \
    -keyout $SERVER_PRIVATE_KEY \
    -out $SERVER_REQUEST \
    -subj "/C=FR/ST=France/L=Paris/O=MiniPKI/CN=server.local" \
    -quiet

# Intermediate CA process the request (generate server certificate)
openssl x509 -req \
    -in $SERVER_REQUEST \
    -CA $INTERMEDIATE_CA_CERTIFICATE \
    -CAkey $INTERMEDIATE_CA_PRIVATE_KEY \
    -out $SERVER_CERTIFICATE \
    -days 365 \
    -sha256