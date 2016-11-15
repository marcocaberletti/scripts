#!/bin/bash

set -xe

registry_host="${DOCKER_REGISTRY_HOST:-cloud-vm181.cloud.cnaf.infn.it}"
datadir="${REGISTRY_DATA_DIR:-/srv/registry/data}"
basedir="$datadir/docker/registry/v2/repositories"
username="${REGISTRY_USERNAME:-}"
password="${REGISTRY_PASSWORD:-}"
registry_container_id="${REGISTRY_CONTAINER_ID:-docker-registry}"
registry_conf_file="${REGISTRY_CONF_FILE:-/etc/docker/registry/config.yml}"

cd $basedir

repolist=`find -maxdepth 2 -mindepth 2 -type d | sed 's/\.\///g'`

for repo in $repolist; do
	hashlist=`ls $repo/_manifests/revisions/sha256 -t | tail -n +3`
	
	for elem in $hashlist; do
		echo DELETE "https://$registry_host/v2/$repo/manifests/sha256:$elem"
		curl -k -u $username:$password -X DELETE "https://$registry_host/v2/$repo/manifests/sha256:$elem"
	done
done


docker exec -ti $registry_container_id  bin/registry garbage-collect $registry_conf_file