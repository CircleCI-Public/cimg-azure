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

function azureFeed() {
  replaceDatedTags "$templateFile" "$interval"
  if docker buildx imagetools inspect "$namespace/$parent:$RELEASE-node" &> /dev/null; then
    [[ -n $STRING_TO_REPLACE || -n $RELEASEMONTHLY ]] && ./shared/release "$RELEASEMONTHLY"
  else
    echo "cimg/deploy:$RELEASE-node does not exist"
    exit 0
  fi
}

azureFeed "$templateFile"
