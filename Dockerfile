FROM 416670754337.dkr.ecr.eu-west-2.amazonaws.com/ci-base-build:1.2.0

ARG ARTIFACTORY_URL=""
ENV ARTIFACTORY_URL=${ARTIFACTORY_URL}

# Amazon Linux 2023 has no Maven package bound to Corretto 25, so Maven comes
# from archive.apache.org and is checked against the SHA-512 sum below.
ARG MAVEN_VERSION="3.9.16"
ARG MAVEN_SHA512="831a8591fe20c8243b1dbe7d71e3244f31d1665b0804b2e825e38cbbe5ce0cafb8338851f90780735568773e0a6cd07bbec107cda0b896b008b861075358b6f6"

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN dnf upgrade -y && \
    dnf install -y java-25-amazon-corretto-devel-25.0.5* && \
    dnf clean all

ENV JAVA_HOME=/usr/lib/jvm/java-25-amazon-corretto
ENV MAVEN_HOME=/usr/share/maven

# Download and install Apache Maven
RUN wget -q -O /tmp/apache-maven.tar.gz https://archive.apache.org/dist/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz && \
    echo "${MAVEN_SHA512}  /tmp/apache-maven.tar.gz" | sha512sum -c - && \
    mkdir -p $MAVEN_HOME && \
    tar -xzf /tmp/apache-maven.tar.gz -C $MAVEN_HOME --strip-components=1 && \
    ln -s $MAVEN_HOME/bin/mvn /usr/bin/mvn && \
    rm /tmp/apache-maven.tar.gz

COPY resources/configure-maven /usr/local/bin/configure-maven
