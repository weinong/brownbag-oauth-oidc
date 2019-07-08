#!/bin/bash

# 1. configure the application to be a public client

CLIENT_ID=''
TENANT_ID=''
SCOPE='openid%20profile%20email'

BODY=$(curl -s -X POST \
            -d scope=${SCOPE} \
            -d client_id=${CLIENT_ID} \
            "https://login.microsoftonline.com/${TENANT_ID}/oauth2/v2.0/devicecode")

user_code=$(echo $BODY | jq -r ".user_code")
device_code=$(echo $BODY | jq -r ".device_code")
verification_url=$(echo $BODY | jq -r ".verification_uri")

echo "Please go to $verification_url with user_code ${user_code}"
read -p "Press enter to continue when you have logged in"

RESULT=$(curl -s -X POST \
     -d grant_type=device_code \
     -d client_id=${CLIENT_ID} \
     -d code="${device_code}" \
     "https://login.microsoftonline.com/${TENANT_ID}/oauth2/v2.0/token")

REFRESH_TOKEN=$(echo ${RESULT} | jq -r ".refresh_token")
ID_TOKEN=$(echo ${RESULT} | jq -r ".id_token")

echo $RESULT | jq
