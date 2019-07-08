#
# Reference: https://docs.microsoft.com/en-us/azure/active-directory/develop/v1-protocols-oauth-code
#

# 1. create AAD application with redirect URL: http://localhost/code
# 2. create and capture client secret

TENANT_ID=''
CLIENT_ID=''
CLIENT_SECRET=''      # urlencoded string

RESPONSE_TYPE='code'
RETURNED_URL='http%3A%2F%2Flocalhost%2Fcode'       # urlencoded string of "http://localhost/code"
RESPONSE_CODE='query' # query, fragment, or form_post
STATE='12345'         # random string that needs to be validated by the returned url
RESOURCE='https://graph.windows.net'           # target resource

# open browser to below location
echo "open browser to this location"
echo "https://login.microsoftonline.com/${TENANT_ID}/oauth2/authorize?client_id=${CLIENT_ID}&response_type=${RESPONSE_TYPE}&redirect_uri=${RETURNED_URL}&response_mode=${RESPONSE_CODE}&state=${STATE}&resource=${RESOURCE}"

echo "Enter authorization code" 
read AUTHORIZATION_CODE

# after logged in and consented, it will be redirected to the returned url with authorization code
# the code can be used to exchange access token:
BODY=$(curl -sX POST \
     -d resource=${RESOURCE} \
     -d grant_type=authorization_code \
     -d client_id=${CLIENT_ID} \
     -d code=${AUTHORIZATION_CODE} \
     -d redirect_uri="${RETURNED_URL}" \
     -d client_secret="${CLIENT_SECRET}" \
     "https://login.microsoftonline.com/${TENANT_ID}/oauth2/token")

echo ${BODY} | jq 'with_entries(.value = .value[0:100])'

ACCESS_TOKEN=$(echo ${BODY} | jq -r ".access_token")

read -p "Click enter to query graph.windows.net using access token"

curl -s -H "Authorization: Bearer ${ACCESS_TOKEN}" "https://graph.windows.net/me?api-version=1.6" | jq
