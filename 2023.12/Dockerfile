# vim:set ft=dockerfile:

# Do not edit individual Dockerfiles manually. Instead, please make changes to the Dockerfile.template, which will be used by the build script to generate Dockerfiles.

FROM cimg/deploy:2023.12-node

LABEL maintainer="CircleCI Execution Team <eng-execution@circleci.com>"

# Install Azure related tools
RUN curl -sL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/microsoft.gpg > /dev/null && \
	[[ $(uname -m) == "x86_64" ]] && ARCH="amd64" || ARCH="arm64" && \
	echo "deb [arch=${ARCH}] https://packages.microsoft.com/repos/azure-cli/ $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/azure-cli.list && \
	sudo apt-get update && sudo apt-get install --yes --no-install-recommends \
		apt-transport-https \
		azure-cli \
		ca-certificates \
		gnupg \
		lsb-release \
	&& \
	sudo rm -rf /var/lib/apt/lists/* && \
	az --version
