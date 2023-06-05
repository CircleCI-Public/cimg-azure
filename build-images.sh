#!/usr/bin/env bash
# Do not edit by hand; please use build scripts/templates to make changes

docker build --file 2023.06/Dockerfile -t cimg/azure:2023.06.1 -t cimg/azure:2023.06 .
