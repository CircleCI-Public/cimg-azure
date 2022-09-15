#!/usr/bin/env bash
# Do not edit by hand; please use build scripts/templates to make changes

docker build --file 2022.08/Dockerfile -t cimg/azure:2022.08.1 -t cimg/azure:2022.08 .
