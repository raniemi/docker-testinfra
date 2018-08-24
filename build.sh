#!/usr/bin/env sh

set -e

DOCKER_IMAGE_NAME=raniemi/testinfra

: "${VERSION:?Need to set VERSION}"

function build_docker_image() {
  docker build \
         --build-arg VERSION=$VERSION \
         -t $DOCKER_IMAGE_NAME .
  docker tag "${DOCKER_IMAGE_NAME}" "${DOCKER_IMAGE_NAME}:${VERSION}"
  docker tag "${DOCKER_IMAGE_NAME}" "${DOCKER_IMAGE_NAME}:latest"
}

function deploy_docker_image() {
  docker push "${DOCKER_IMAGE_NAME}:${VERSION}"
  docker push "${DOCKER_IMAGE_NAME}:latest"
}

if [[ $# -eq 0 || "$1" == "--build" ]]; then
  build_docker_image
elif [[ "$1" == "--deploy" ]]; then
  deploy_docker_image
fi
