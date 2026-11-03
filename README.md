# ci-corretto-jdk25-maven-build
Image used for Amazon Corretto 25 Maven application builds

## Contents

- Amazon Corretto 25 JDK (`java-25-amazon-corretto-devel`), with `JAVA_HOME=/usr/lib/jvm/java-25-amazon-corretto`
- Apache Maven from archive.apache.org, checked against the SHA-512 sum in the Dockerfile
- `configure-maven`, which points Maven at Artifactory

## Build ARGs

The following Docker build arguments are supported

| Argument        | Default        | Description                                          |
| --------------- | -------------- | ---------------------------------------------------- |
| ARTIFACTORY_URL |                | Artifactory URL used by the `configure-maven` script |
| MAVEN_VERSION   | 3.9.16         | Apache Maven version (set MAVEN_SHA512 to match)     |
| MAVEN_SHA512    | See Dockerfile | SHA-512 of the Maven `-bin.tar.gz` for MAVEN_VERSION, from archive.apache.org |

## Building the image

```sh
docker build -t ci-corretto-jdk-build-25 -f ./Dockerfile .
```

## Running the image

If you would like to run and connect to the image, you can do so by running the following:

```sh
docker run -it --rm ci-corretto-jdk-build-25 bash
```

## Building the source-code

To mount a project into the container you can run the following:

```sh
# populate the placeholders below
docker run -it --rm -v /Users/<username>/<path_to_repo>/<repo_name>:/<path_to_source-code> ci-corretto-jdk-build-25 bash
```
