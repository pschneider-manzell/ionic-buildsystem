FROM ubuntu:16.04

# replace shell with bash so we can source files
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# update the repository sources list
# and install dependencies
RUN apt-get update \
    && apt-get install -y curl \
    && apt-get install -y git \
    && apt-get install -y openjdk-8-jdk \
    && apt-get install -y ca-certificates-java \
    && rm -rf /var/cache/oracle-jdk8-installer \
    && apt-get -y autoclean \
    && apt-get --assume-yes install bzip2 \
    && apt-get --assume-yes install libfontconfig

# nvm environment variables
ENV NVM_VERSION v0.34.0
ENV NVM_DIR /root/nvm
RUN mkdir $NVM_DIR
ENV NODE_VERSION 10.16.0
ENV IONIC_VERSION 4.12.0
ENV CORDOVA_VERSION 8.1.2
# Setup JAVA_HOME, this is useful for docker commandline
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/
RUN export JAVA_HOME


# install nvm
# https://github.com/creationix/nvm#install-script
RUN curl --silent -o- https://raw.githubusercontent.com/creationix/nvm/$NVM_VERSION/install.sh | bash

# install node and npm
RUN source $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default

# add node and npm to path so the commands are available
ENV NODE_PATH $NVM_DIR/v$NODE_VERSION/lib/node_modules
ENV PATH $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH

RUN npm install -g phantomjs-prebuilt@2.1.16  --unsafe-perm

RUN npm install -g cordova@"$CORDOVA_VERSION" 
RUN npm install -g ionic@"$IONIC_VERSION"

# confirm installation
RUN node -v
RUN npm -v
RUN cordova -v
RUN ionic -v
RUN java -version

