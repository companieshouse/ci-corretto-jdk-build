ci-corretto-jdk-build
Image used for Amazon Corretto application builds

## Build ARGs

The following Docker build arguments are supported

| Argument        | Default                                                                   | Description                                          |
| --------------- | ------------------------------------------------------------------------- | ---------------------------------------------------- |
| ARTIFACTORY_URL |                                                                           | Artifactory URL used by the `configure-maven` script |

## Building the image

The image installs Amazon Corretto 21.0.13.1.2 from the latest Amazon Linux
repository release, as the base image's default snapshot predates this version.

```sh
docker build -t ci-corretto-jdk-build-21 -f ./Dockerfile .
```

## Running the image

If you would like to run and connect to the image, you can do so by running the following:

```sh
docker run -it --rm ci-corretto-jdk-build-21 bash
```

## Building the source-code

To mount a project into the container you can run the following:

```sh
# populate the placeholders below
docker run -it --rm -v /Users/<username>/<path_to_repo>/<repo_name>:/<path_to_source-code> ci-corretto-jdk-build-21 bash
