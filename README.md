# MiniPKI Lab

## Context

A hands-on Public Key Infrastructure lab demonstrating X.509 certificate issuance, certificate chain validation, and automated certificate security auditing using OpenSSL and Python.

## Setup

`./scripts/setup.sh` creates private keys, Certificate Signing Requests and certificates, all in a temporary file.
The goal is to create a little PKI as described here:

```txt
ROOT CA --> INTERMEDIATE CA --> SERVER
```

## Check the chain of trust

After `./scripts/setup.sh`, you can execute `./scripts/verify_chain_of_trust.sh`: this will check if the Server is correctly certified by the Intermediate CA, that the Intermediate CA is correctly certified by the Root CA, and that the Root CA is well self-signed.

## Print the content of a certificate

To print a certificate in a readable format, use `./script/print_certificate.sh <certificate_path>`.
