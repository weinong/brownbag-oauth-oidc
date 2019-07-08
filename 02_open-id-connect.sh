#
# Reference: https://docs.microsoft.com/en-us/azure/active-directory/develop/v1-protocols-openid-connect-code
#

# 1. configure the application to emit id_token in authorize endpoint
# 2. add redirect URL: http://localhost:8081/anything
# 3. run a local http server to capture the form_post response

TENANT_ID=''
CLIENT_ID=''
RETURNED_URL='http%3A%2F%2Flocalhost%3A8081%2Fanything'       # urlencoded string of "http://localhost:8081/anything"

RESPONSE_TYPE='id_token'
SCOPE='openid'
RESPONSE_CODE='form_post' # form_post
STATE='12345'         # random string that needs to be validated by the returned url
NONCE='7362CAEA-9CA5-4B43-9BA3-34D7C303EBA7' # random string that needs to be validated by the returned url

docker stop httpbin 

docker run -d -p 8081:80 --rm --name httpbin kennethreitz/httpbin

# open browser to below location
echo "click enter to open browser to this location"
echo "https://login.microsoftonline.com/${TENANT_ID}/oauth2/authorize?client_id=${CLIENT_ID}&response_type=${RESPONSE_TYPE}&redirect_uri=${RETURNED_URL}&response_mode=${RESPONSE_CODE}&state=${STATE}&scope=${SCOPE}&nonce=${NONCE}"
read

open "https://login.microsoftonline.com/${TENANT_ID}/oauth2/authorize?client_id=${CLIENT_ID}&response_type=${RESPONSE_TYPE}&redirect_uri=${RETURNED_URL}&response_mode=${RESPONSE_CODE}&state=${STATE}&scope=${SCOPE}&nonce=${NONCE}"

