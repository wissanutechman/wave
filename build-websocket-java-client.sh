#!/bin/bash

command -v git >/dev/null 2>&1 || { echo "I require Git client but it's not installed. Aborting." >&2; exit 1; }
command -v mvn >/dev/null 2>&1 || { echo "I require Maven client but it's not installed. Aborting." >&2; exit 1; }

GIT=`which git`
MVN=`which mvn`
WAVE_SRC=$PWD
REPO=$WAVE_SRC/repo/
TITLE="WebSocket Java Client"
SRC=websocket-java-client

# checkout WebSocket Java Client source
echo -n "Checking out $TITLE source to $WAVE_SRC/$SRC.. "
$GIT clone -q git://github.com/pires/Java-WebSocket-client.git $SRC
echo "Done"

# build and install into Wave repo
echo "Building $TITLE.. "
cd $SRC
$MVN -q -DskipTests=true clean package

echo "Installing JARs into $REPO.. "
$MVN -q -DskipTests=true install:install-file \
 -Dfile=target/java-websocket-client-hyxie-75.jar \
 -DgroupId=com.sixfire \
 -DartifactId=java-websocket-client \
 -Dversion=hyxie-75 \
 -Dpackaging=jar \
 -DlocalRepositoryPath=$REPO

echo "Done"

# clean
echo -n "Cleaning up $TITLE sources.. "
cd $WAVE_SRC
rm -rf $SRC

# finish
echo "Done"
