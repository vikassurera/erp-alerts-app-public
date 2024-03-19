#!/bin/bash

keystore_password=$1
key_password=$2
alias=$3
keystore_file="test-upload-keystore.jks"

# Check if the keystore_password, key_password and alias are passed
if [ -z "$keystore_password" ] || [ -z "$key_password" ] || [ -z "$alias" ]; then
  echo "Usage: ./create_keystore.sh <keystore_password> <key_password> <alias>"
  exit 1
fi

echo "Creating keystore..."

# Create a new keystore
keytool -genkey -alias $alias -keystore $keystore_file -storepass $keystore_password -keypass $key_password -keyalg RSA -keysize 2048 -validity 9855 || exit 1

echo "Keystore created successfully!"
# List the contents of the keystore
keytool -list -keystore $keystore_file -storepass $keystore_password || exit 1

echo "Keystore location: $keystore_file"
