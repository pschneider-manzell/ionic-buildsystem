FROM openjdk:11-jdk-oracle

# nvm environment variables
ENV NVM_VERSION v0.39.1
ENV NVM_DIR /root/nvm
ENV NODE_VERSION 10.16.0
ENV IONIC_VERSION 4.12.0
ENV CORDOVA_VERSION 8.1.2
ENV NODE_PATH $NVM_DIR/v$NODE_VERSION/lib/node_modules
ENV PATH $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH


ADD sonar-scanner/4.7.0.2747 /sonar-scanner
# update the repository sources list
# and install dependencies
RUN microdnf install git bzip2 \
    && mkdir $NVM_DIR \
    && curl --silent -o- https://raw.githubusercontent.com/creationix/nvm/$NVM_VERSION/install.sh | bash \
    && source $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default \
    && npm install -g phantomjs-prebuilt@2.1.16  --unsafe-perm \
    && npm install -g cordova@"$CORDOVA_VERSION"  \
    && npm install -g ionic@"$IONIC_VERSION" \




