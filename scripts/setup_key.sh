#!/bin/bash

keystore_password=$1
key_password=$2
alias="upload"
folderName=$3
keystore_file="$folderName/upload-keystore.jks"

# Check if the keystore_password, key_password and alias and other variables are passed
if [ -z "$keystore_password" ] || [ -z "$key_password" ] || [ -z "$alias" ] || [ -z "$folderName" ]; then
    echo "Usage: ./create_keystore.sh <keystore_password> <key_password> <folderName>"
  exit 1
fi

public_key_file="$folderName/upload_certificate.pem"
private_key_file="$folderName/upload_private.pem"
private_key_pkcs8_file="$folderName/upload_key_pkcs12.p12"

recreate_jks_file="$folderName/upload_recreate_keystore.jks"
recreate_p12_file="$folderName/upload_recreate.p12"

base64_upload_certificate="$folderName/upload_certificate_base64.txt"
base64_upload_private_key="$folderName/upload_private_base64.txt"

# Create keystore
echo "Creating keystore..." 
echo -e "Vikas Surera\nBloggerBoy\nBloggerBoy\n\n\n\nyes\n" | keytool -genkey -alias $alias -keystore $keystore_file -storepass $keystore_password -keypass $key_password -keyalg RSA -keysize 2048 -validity 9855 || exit 1
echo "Keystore created successfully!"

# List the contents of the keystore
keytool -list -keystore $keystore_file -storepass $keystore_password || exit 1

echo "Keystore location: $keystore_file"

# Create upload certificate
echo "Creating upload certificate..."
keytool -export -rfc -keystore $keystore_file -alias $alias -file $public_key_file -storepass $keystore_password || exit 1
echo "Upload certificate created successfully!"

# Create base64 encoded upload certificate
echo "Creating base64 encoded upload certificate..."
base64 -i $public_key_file -o $base64_upload_certificate
echo "Base64 encoded upload certificate created successfully!"

# Create private key
echo "Creating private key..."
keytool -v -importkeystore -srckeystore $keystore_file -destkeystore $private_key_pkcs8_file -deststoretype PKCS12 -srcalias $alias -deststorepass $keystore_password -destkeypass $key_password -srcstorepass $keystore_password || exit 1
openssl pkcs12 -in $private_key_pkcs8_file -nocerts -out $private_key_file -passin pass:$keystore_password -passout pass:$keystore_password
echo "Private key created successfully!"

# Create base64 encoded private key
echo "Creating base64 encoded private key..."
base64 -i $private_key_file -o $base64_upload_private_key
echo "Base64 encoded private key created successfully!"

# # Create p12 file from private and public keys
# echo "Creating p12 file from private and public keys..."
# openssl pkcs12 -export -inkey $private_key_file -in $public_key_file -out $recreate_p12_file -name $alias -passin pass:$keystore_password -passout pass:$keystore_password
# echo "P12 file created successfully!"

# # Get back the jks files from p12 file
# echo "Getting back the jks files from p12 file..."
# keytool -importkeystore -srckeystore $recreate_p12_file -srcstoretype PKCS12 -destkeystore $recreate_jks_file -deststoretype JKS -srcstorepass $keystore_password -deststorepass $keystore_password -srcalias $alias -destalias $alias -srckeypass $keystore_password -destkeypass $keystore_password


