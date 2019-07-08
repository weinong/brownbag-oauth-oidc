# this script demonstrates the OIDC authentication feature in kubernetes api-server using ID_TOKEN from 04_device-flow-v2.sh
# the demo is based on an aks-engine generated cluster

# add cluster role binding to a (appRoles) group 
kubectl create clusterrolebinding aks-cluster-admin-binding --clusterrole=cluster-admin --group=Admin

# add flags to api-server: ["--oidc-client-id={client-id}", "--oidc-groups-claim=roles", "--oidc-issuer-url=https://login.microsoftonline.com/{tenant-id}/v2.0", "--oidc-username-claim=email", "--oidc-username-prefix=oidc:"]

# create deployment from the client using ID_TOKEN
kubectl --token=${ID_TOKEN} run nginx --image nginx

# verify the identify from the master node
cat /var/log/kubeaudit/audit.log  | grep nginx | head -n 1 | jq

