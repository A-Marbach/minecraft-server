# Dockerfile
FROM openjdk:21-jdk-slim

ENV LANG=C.UTF-8 \
    SERVER_DIR=/opt/minecraft \
    SERVER_JAR=${SERVER_JAR_NAME:-server.jar}

WORKDIR ${SERVER_DIR}

# Tools
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl ca-certificates \
  && rm -rf /var/lib/apt/lists/*

# copy server jar
COPY server/${SERVER_JAR_NAME:-server.jar} ${SERVER_JAR}

# copy entrypoint
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 25565/tcp

VOLUME ["/data"]  # nur für Spielstände

ENTRYPOINT ["/entrypoint.sh"]
CMD ["run"]
