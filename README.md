# brownbag-oauth-oidc
This repo contains scripts that I used in the OAuth and OIDC brownbag

## [01_authorization-code.sh](/01_authorization-code.sh)
Demos [Authorization Code flow using AAD v1 endpoint](https://docs.microsoft.com/en-us/azure/active-directory/develop/v1-protocols-oauth-code)
1. create AAD application
2. create client secret
3. check delegated permission
4. go through script and explain authorize and token endpoint
5. use the token to query Graph

## [02_open-id-connect.sh](02_open-id-connect.sh)
Demos [obtaining id_token from authorize server](https://docs.microsoft.com/en-us/azure/active-directory/develop/v1-protocols-openid-connect-code)
1. Configure the application to emit id_token from authorize endpoint
2. Start a webserver to capture form_post response from authorize endpoint
3. Obtain id_token from authorize endpoint
4. Go to https://jwt.ms to decode

## [03_appRole.json](03_appRole.json)
Use [Application Roles](https://docs.microsoft.com/en-us/azure/architecture/multitenant-identity/app-roles) for access control
1. Add AppRole with newly generated GUID to Application manifest 
2. Add User to Admin Role
3. Obtain the id_token again and decode

## [04_device-flow-v2.sh](04_device-flow-v2.sh)
Use [device code flow with AAD v2 endpoint](https://docs.microsoft.com/en-us/azure/active-directory/develop/v2-oauth2-device-code#protocol-diagram
)
1. Configure the client application to be “Public Client”
2. Note the scope=openid profile email
3. Note the response only contains Access Token and ID Token. It does not have Refresh Token as it’s not requested in scope

## [05_grafana-docker.sh](05_grafana-docker.sh)
Use [Grafana with AAD](https://grafana.com/docs/auth/generic-oauth/#set-up-oauth2-with-azure-active-directory)
1. Add http://localhost:3000/login/generic_oauth to redirect URI

## [06_k8s-demo.sh](06_k8s-demo.sh)
Use AAD OIDC to authenticate with k8s apiserver (built with aks-engine)
1. Create cluster role binding mapping appRoles `Admin` to cluster admin role
2. Configure kube-apiserver with oidc flags
3. Use id_token from demo 04 to deploy nginx on k8s
4. verify the identity in kube-audit log
