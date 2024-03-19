#!/bin/bash

import_cert=$1
keystore_file=$2
alias=$3
keystore_password=$4
key_password=$5

# Check if the keystore_password, key_password and alias are passed
if [ -z "$alias" ] || [ -z "$import_cert" ] || [ -z "$keystore_password" ] || [ -z "$keystore_file" ] || [ -z "$key_password" ]; then
  echo "Usage: ./convert_upload_cert.sh <import_cert> <keystore_file> <alias> <keystore_password> <key_password>"
  exit 1
fi

echo "Creating keystore..."

# Create a new keystore
keytool -import -alias $alias -file $import_cert -storepass $keystore_password -keystore $keystore_file -keypass $key_password || exit 1

echo "Keystore created successfully!"

# List the contents of the keystore
keytool -list -keystore $keystore_file -storepass $keystore_password || exit 1

echo "Keystore location: $keystore_file"
