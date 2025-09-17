# Dockerfile
FROM openjdk:17-jdk-slim

ENV LANG=C.UTF-8 \
    SERVER_DIR=/data \
    SERVER_JAR=${SERVER_JAR_NAME:-server.jar}

WORKDIR ${SERVER_DIR}

# Install basic tools for downloading (if needed)
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl ca-certificates \
  && rm -rf /var/lib/apt/lists/*

# copy local server jar if present (preferred: put server.jar into /server)
COPY server/${SERVER_JAR_NAME:-server.jar} ${SERVER_JAR}

# copy entrypoint
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 25565/tcp

VOLUME ["/data"]

ENTRYPOINT ["/entrypoint.sh"]
CMD ["run"]