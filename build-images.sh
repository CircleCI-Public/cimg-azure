#!/usr/bin/env bash
# Do not edit by hand; please use build scripts/templates to make changes
set -eo pipefail

docker context create cimg
docker buildx create --use cimg
docker buildx build --platform=linux/amd64,linux/arm64 --file 2025.01/Dockerfile -t cimg/azure:2025.01.1 -t cimg/azure:2025.01 --push .
