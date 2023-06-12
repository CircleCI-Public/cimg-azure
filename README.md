<div align="center">
	<p>
		<img alt="CircleCI Logo" src="https://raw.github.com/CircleCI-Public/cimg-azure/main/img/circle-circleci.svg?sanitize=true" width="75" />
		<img alt="Docker Logo" src="https://raw.github.com/CircleCI-Public/cimg-azure/main/img/circle-docker.svg?sanitize=true" width="75" />
		<img alt="Azure Logo" src="https://raw.github.com/CircleCI-Public/cimg-azure/main/img/circle-azure.svg?sanitize=true" width="75" />
	</p>
	<h1>CircleCI Convenience Images => Azure</h1>
	<h3>A Continuous Delivery & Deployment focused Docker image built to run on CircleCI</h3>
</div>

[![CircleCI Build Status](https://circleci.com/gh/CircleCI-Public/cimg-azure.svg?style=shield)](https://circleci.com/gh/CircleCI-Public/cimg-azure) [![Software License](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/CircleCI-Public/cimg-azure/main/LICENSE) [![Docker Pulls](https://img.shields.io/docker/pulls/cimg/azure)](https://hub.docker.com/r/cimg/azure) [![CircleCI Community](https://img.shields.io/badge/community-CircleCI%20Discuss-343434.svg)](https://discuss.circleci.com/c/ecosystem/circleci-images) [![Repository](https://img.shields.io/badge/github-README-brightgreen)](https://github.com/CircleCI-Public/cimg-azure)

`cimg/azure` is a Docker image created by CircleCI with continuous delivery and deployment pipelines in mind.
It contains the Azure CLI, related tools, and is based on the [cimg/deploy](https://github.com/CircleCI-Public/cimg-deploy) image.
Each tag is a date-based snapshot.

## Support Policy

The CircleCI Docker Convenience Image support policy can be found on the [CircleCI docs](https://circleci.com/docs/convenience-images-support-policy) site. This policy outlines the release, update, and deprecation policy for CircleCI Docker Convenience Images.

## Table of Contents

- [Getting Started](#getting-started)
- [How This Image Works](#how-this-image-works)
- [Development](#development)
- [Contributing](#contributing)
- [Additional Resources](#additional-resources)
- [License](#license)


## Getting Started

This image can be used with the CircleCI `docker` executor.
For example:

```yaml
jobs:
  build:
    docker:
      - image: cimg/azure:2022.08.1
    steps:
      - checkout
      - run: echo "Do things"
```

In the above example, the CircleCI Azure Docker image is used for the primary container.
More specifically, the tag `2022.08.1` is used meaning this is the 1st August 2022 snapshot.
You can now use all of the tools pre-installed in this image in this job.


## How This Image Works

This image is published on a monthly basis.
Each month, we'll update the main tools to newer versions as they are available.

### Variants

Variant images typically contain the same base software, but with a few additional modifications.

#### Node.js

This image does not have a `node` variant.
It's based on the node variant of the deploy image which means Node.js is already pre-installed.

### Tagging Scheme

This image has the following tagging scheme:

```
cimg/azure:YYYY.MM.I
```

The tag will be `YYYY.MM.I` where YYYY is the 4 digit year, MM is the 2 digit month, and I is the nth release of that month.
The last piece there typically will only change when we need to patch an image for that month.

## Development

Images can be built and run locally with this repository.
This has the following requirements:

- local machine of Linux (Ubuntu tested) or macOS
- modern version of Bash (v4+)
- modern version of Docker Engine (v20.10+)

### Cloning For Community Users (no write access to this repository)

Fork this repository on GitHub.
When you get your clone URL, you'll want to add `--recurse-submodules` to the clone command in order to populate the Git submodule contained in this repo.
It would look something like this:

```bash
git clone --recurse-submodules <my-clone-url>
```

If you missed this step and already cloned, you can just run `git submodule update --init` to populate the submodule.
Then you can optionally add this repo as an upstream to your own:

```bash
git remote add upstream https://github.com/CircleCI-Public/cimg-azure.git
```

### Cloning For Maintainers ( you have write access to this repository)

Clone the project with the following command so that you populate the submodule:

```bash
git clone --recurse-submodules git@github.com:CircleCI-Public/cimg-azure.git
```

### Generating Dockerfiles

Dockerfiles can be generated by using the `gen-dockerfiles.sh` script.
For example, you would run the following from the root of the repo:

```bash
./shared/gen-dockerfiles.sh 2022.08.1
```

The generated Dockerfile will be located at `./2022.08/Dockefile`.
To build this image locally and try it out, you can run the following:

```bash
cd 2022.08
docker build -t test/azure:2022.08.1 .
docker run -it test/azure:2022.08.1 bash
```

### Building the Dockerfiles

To build the Docker images locally as this repository does, you'll want to run the `build-images.sh` script:

```bash
./build-images.sh
```

This would need to be run after generating the Dockerfiles first.
When releasing proper images for CircleCI, this script is run from a CircleCI pipeline and not locally.

### Publishing Official Images (for Maintainers only)

The individual scripts (above) can be used to create the correct files for an image, and then added to a new git branch, committed, etc.
A release script is included to make this process easier.
To make a proper release for this image, let's use the fake date April 1991, you would run the following from the repo root:

```bash
./shared/release.sh 1991.04.2
```

This will automatically create a new Git branch, generate the Dockerfile(s), stage the changes, commit them, and push them to GitHub.
The commit message will end with the string `[release]`.
This string is used by CircleCI to know when to push images to Docker Hub.
All that would need to be done after that is:

- wait for build to pass on CircleCI
- review the PR
- merge the PR

The main branch build will then publish a release.

### Incorporating Changes

How changes are incorporated into this image depends on where they come from.

**build scripts** - Changes within the `./shared` submodule happen in its [own repository](https://github.com/CircleCI-Public/cimg-shared).
For those changes to affect this image, the submodule needs to be updated.
Typically like this:

```bash
cd shared
git pull
cd ..
git add shared
git commit -m "Updating submodule for foo."
```

**parent image** - By design, when changes happen to a parent image, they don't appear in existing Azure images.
This is to aid in "determinism" and prevent breaking customer builds.
New Azure images will automatically pick up the changes.

If you _really_ want to publish changes from a parent image into the Azure image, you have to build a specific image version as if it was a new image.
This will create a new Dockerfile and once published, a new image.

**Azure image specific changes** - Editing the `Dockerfile.template` file in this repo will modify the Azure image specifically.
Don't forget that to see any of these changes locally, the `gen-dockerfiles.sh` script will need to be run again (see above).

## Contributing

We encourage [issues](https://github.com/CircleCI-Public/cimg-azure/issues) and [pull requests](https://github.com/CircleCI-Public/cimg-azure/pulls) against this repository.

Please check out our [contributing guide](.github/CONTRIBUTING.md) which outlines best practices for contributions and what you can expect from the images team at CircleCI.

## Additional Resources

[CircleCI Docs](https://circleci.com/docs/) - The official CircleCI Documentation website.
[CircleCI Configuration Reference](https://circleci.com/docs/2.0/configuration-reference/#section=configuration) - From CircleCI Docs, the configuration reference page is one of the most useful pages we have.
It will list all of the keys and values supported in `.circleci/config.yml`.
[Docker Docs](https://docs.docker.com/) - For simple projects this won't be needed but if you want to dive deeper into learning Docker, this is a great resource.

## License

This repository is licensed under the MIT license.
The license can be found [here](./LICENSE).
