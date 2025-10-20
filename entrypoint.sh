#!/bin/sh
set -e

EULA=${EULA:-false}
MIN_RAM=${MIN_RAM:-1024M}
MAX_RAM=${MAX_RAM:-1024M}
JAR=${SERVER_JAR:-/opt/minecraft/server.jar}
DIR=/data

cd "${DIR}"



# Check if jar exists
if [ ! -f "${JAR}" ]; then
  echo "ERROR: server jar '${JAR}' not found. Put it into repo/server/ or set SERVER_JAR_URL in Dockerfile or .env."
  exit 1
fi

# Accept or reject EULA
if [ "${EULA}" = "true" ]; then
  echo "eula=true" > eula.txt
else
  echo "EULA not accepted. Set EULA=true in .env to accept Mojang's EULA and start the server."
  exit 2
fi

# Start server
exec java -Xms${MIN_RAM} -Xmx${MAX_RAM} -jar "${JAR}" nogui
