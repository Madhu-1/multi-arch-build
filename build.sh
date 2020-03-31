#!/bin/bash

build_push_images() {
	# "docker manifest" requires experimental feature enabled
	export DOCKER_CLI_EXPERIMENTAL=enabled

	# get baseimg (ceph/ceph:tag)
	dockerfile="Dockerfile"
	baseimg=$(awk 'NR==1{print $2}' "${dockerfile}")
	echo $baseimg
	# get image digest per architecture
	# {
	#   "arch": "amd64",
	#   "digest": "sha256:XXX"
	# }
	# {
	#   "arch": "arm64",
	#   "digest": "sha256:YYY"
	# }
	manifests=$("${CONTAINER_CMD:-docker}" manifest inspect "${baseimg}" | jq '.manifests[] | {arch: .platform.architecture, digest: .digest}')
	echo $manifests
	# build and push per arch images
	AR=$1
	echo $AR
	digest=$(awk -v ARCH=${AR} '{if (archfound) {print $NF; exit 0}}; {archfound=($0 ~ "arch.*"ARCH)}' <<<"${manifests}")
	echo "printing digest"$digest
	sed -i "s|\(^FROM.*\)${baseimg}.*$|\1${baseimg}@${digest}|" "${dockerfile}"
	GOARCH=${ARCH} docker build .
}

build_push_images $1
