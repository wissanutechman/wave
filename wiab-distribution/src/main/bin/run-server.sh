#!/bin/bash

# This script will start the Wave in a Box server.
#

# Make sure the config file exists.
if [ ! -e server.config ]; then
  echo "You need to copy server.config.example to server.config and edit it. Or run: 'ant -f server-config.xml' to generate the file automatically."
  exit 1
fi

. process-script-args.sh

exec java $DEBUG_FLAGS \
  -Dorg.eclipse.jetty.LEVEL=DEBUG \
  -Djava.security.auth.login.config=jaas.config \
  -Dwave.server.config=server.config \
  -jar lib/box-0.3-SNAPSHOT.jar
  

# Alternate run configuration which doesn't use the executable jar.
# Compute the classpath based on all of the jars in the lib dir.
# CLASSPATH=`echo lib/*.jar | tr ' ' ':'`
# exec java $DEBUG_FLAGS \
#  -Dorg.eclipse.jetty.LEVEL=DEBUG \
#  -Djava.security.auth.login.config=jaas.config \
#  -Dwave.server.config=server.config \
#  -cp $CLASSPATH \ 
#  org.waveprotocol.box.server.ServerMain 
