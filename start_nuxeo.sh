#!/bin/sh

echo "Creating instance-clid..."
kubectl create secret generic instance-clid --from-literal=instance.clid="${NUXEO_CLID}"

echo "Installing Nuxeo Helm chart..."
cat <<EOF | helm install --repo https://chartmuseum.platform.dev.nuxeo.com my-nuxeo nuxeo --atomic --timeout 30m -f - 
nuxeo:
  enabled: true
  image:
    tag: 11.x
    pullPolicy: IfNotPresent
  packages: nuxeo-web-ui
  customParams: |-
    org.nuxeo.connect.url=https://nos-preprod-connect.nuxeocloud.com/nuxeo/site/
  customEnvs:
  - name: NUXEO_CLID
    valueFrom:
      secretKeyRef:
        name: instance-clid
        key: instance.clid
  ingress:
    enabled: true
    annotations: null # do not force nginx class
EOF

kubectl get ingress my-nuxeo-nuxeo -n default

kubectl logs $(kubectl get pods --selector=app=my-nuxeo-nuxeo -n default --output=jsonpath="{.items..metadata.name}") -n default
