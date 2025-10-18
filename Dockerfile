
FROM openjdk:21-jdk-slim

ARG MINECRAFT_VERSION=1.21
ENV SERVER_JAR=/opt/minecraft/server.jar
WORKDIR /opt/minecraft

RUN apt-get update && apt-get install -y --no-install-recommends \
    curl ca-certificates \
  && rm -rf /var/lib/apt/lists/*

# Lade automatisch den offiziellen Minecraft-Server herunter
RUN curl -o $SERVER_JAR https://launcher.mojang.com/v1/objects/95495a7f485eedd84ce928cef5e223b757d2f764/server.jar

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 25565/tcp
VOLUME ["/data"]

ENTRYPOINT ["/entrypoint.sh"]
CMD ["run"]
