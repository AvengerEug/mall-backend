#!/usr/bin/env bash

# install thirdparty-1.0-SNAPSHOT.jar into maven local repository
cd common/lib-common/lib

mvn install:install-file -Dfile=./jwt-util-1.0-SNAPSHOT.jar -DgroupId=com.eugene.sumarry -DartifactId=jwt-util -Dversion=1.0-SNAPSHOT -Dpackaging=jar

cd ../../../

mvn clean install && mvn clean install