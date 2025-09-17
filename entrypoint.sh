#!/bin/sh
set -e

# defaults
EULA=${EULA:-false}
MIN_RAM=${MIN_RAM:-1024M}
MAX_RAM=${MAX_RAM:-1024M}
JAR=${SERVER_JAR:-server.jar}
DIR=/data

cd $DIR

# if server jar missing -> fail early with message
if [ ! -f "$JAR" ]; then
  echo "ERROR: server jar '$JAR' not found in $DIR. Put it into repo/server/ or set SERVER_JAR_URL in Dockerfile."
  exit 1
fi

# write eula if EULA=true
if [ "$EULA" = "true" ]; then
  echo "eula=true" > eula.txt
else
  echo "EULA not accepted. Set EULA=true in .env to accept Mojang's EULA and start the server."
  exit 2
fi

# start server
exec java -Xms${MIN_RAM} -Xmx${MAX_RAM} -jar "$JAR" nogui