FROM 416670754337.dkr.ecr.eu-west-2.amazonaws.com/ci-base-build:1.0.3

ARG ARTIFACTORY_URL=""
ENV ARTIFACTORY_URL=${ARTIFACTORY_URL}

RUN dnf --releasever=latest update -y && \
    dnf --releasever=latest install -y \
    java-17-amazon-corretto \
    maven \
    ant \
    apache-ivy && \
    dnf clean all

RUN curl -L https://services.gradle.org/distributions/gradle-6.9-bin.zip -o /tmp/gradle-6.9-bin.zip && \
    mkdir -p /opt/gradle && \
    unzip -d /opt/gradle /tmp/gradle-6.9-bin.zip && \
    rm /tmp/gradle-6.9-bin.zip && \
    ln -s /opt/gradle/gradle-6.9/bin/gradle /usr/local/bin/gradle

COPY resources/configure-maven /usr/local/bin/configure-maven
