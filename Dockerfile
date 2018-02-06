FROM ubuntu:16.04

# replace shell with bash so we can source files
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# update the repository sources list
# and install dependencies
RUN apt-get update \
    && apt-get install -y curl \
    && apt-get install -y git \
    && apt-get -y autoclean \
    && apt-get --assume-yes install bzip2 \
    && apt-get --assume-yes install libfontconfig

# nvm environment variables
ENV NVM_VERSION v0.33.8
ENV NVM_DIR /root/nvm
ENV NODE_VERSION 8.9.4
ENV IONIC_VERSION 3.19.01
ENV CORDOVA_VERSION 8.0.0


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

