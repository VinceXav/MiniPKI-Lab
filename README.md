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

Coming soon.
