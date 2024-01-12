#!/usr/bin/env bash
if [ -f shared/automated-updates.sh ]; then
  source shared/automated-updates.sh
else
  echo "Check if submodule was loaded; automated-updates.sh is missing"
  exit 1
fi
source ./manifest

templateFile="Dockerfile.template"
interval="monthly"
VERSION=$( date +%Y.%m )

replaceDatedTags "$templateFile" "$interval"
releaseDeployImage "$VERSION"
