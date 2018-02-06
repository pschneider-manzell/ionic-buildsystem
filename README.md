![build status](https://travis-ci.org/pschneider-manzell/ionic-buildsystem.svg?branch=master)
* Make sure you have docker installed
* Change the node / ionic / cordova version in `Dockerfile`
* Build the image with `docker build . -t <dockerhub username>/ionic-buildsystem:<ionic version>`
* Push changes with `docker push <dockerhub username>/ionic-buildsystem:<ionic version>`
