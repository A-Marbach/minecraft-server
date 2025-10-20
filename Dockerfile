
FROM openjdk:21-jdk-slim

ARG MINECRAFT_VERSION=1.21
ARG SERVER_JAR_URL="https://piston-data.mojang.com/v1/objects/95495a7f485eedd84ce928cef5e223b757d2f764/server.jar"
ENV SERVER_JAR=/opt/minecraft/server.jar
WORKDIR /opt/minecraft

RUN apt-get update && apt-get install -y --no-install-recommends \
    curl ca-certificates \
  && rm -rf /var/lib/apt/lists/*

RUN echo "Downloading server.jar from ${SERVER_JAR_URL}" \
  && curl -fsSL "${SERVER_JAR_URL}" -o "${SERVER_JAR}" 

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 25565/tcp
VOLUME ["/data"]

ENTRYPOINT ["/entrypoint.sh"]
















