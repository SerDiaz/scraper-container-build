#!/bin/bash
#
# Build an image with most libraries to scrap an web
#

set -e

IMAGE_TAG=scraper-image
BUILD_DIR="${1:-$PWD/build}"
BUILD_ARGS=

mkdir -p "$BUILD_DIR"
podman build \
    --tag $IMAGE_TAG \
    --volume "$BUILD_DIR":/build \
    $BUILD_ARGS .
