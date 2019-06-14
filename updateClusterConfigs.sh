#!/bin/bash
echo "Removing existing cluster configs..."
ssh ssh://root@$IPADSHELL_HOST:$IPADSHELL_PORT rm -fr /root/storage/clusters
ssh ssh://root@$IPADSHELL_HOST:$IPADSHELL_PORT mkdir /root/storage/clusters

echo "Upload local cluster configs"
scp -P $IPADSHELL_PORT -r ~/.bluemix/plugins/container-service/clusters/* root@$IPADSHELL_HOST:/root/storage/clusters