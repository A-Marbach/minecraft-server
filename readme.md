# Minecraft Server with Docker

A lightweight, containerized setup for running a **Minecraft Java Edition Server** using Docker and Docker Compose.

---

## 📑 Table of Contents
- [About](#about)
- [Quickstart](#quickstart)
- [Usage](#usage)
  - [Configuration](#configuration)
  - [Volumes & Persistence](#volumes--persistence)
  - [Port Mapping](#port-mapping)
- [Project Structure](#project-structure)
- [Testing](#testing)
- [Notes](#notes)
- [Demo Video](#demo-video)

---

##  About

This repository contains a simple setup for running a **Minecraft Java Edition Server** inside a Docker container.  
It aims to provide a **reproducible**, **portable**, and **easy-to-deploy** environment for hosting your own Minecraft world.

### Contents
- **Dockerfile** – builds a custom image based on openjdk:21-jdk-slim  
- **docker-compose.yaml** – defines the mc-server service (ports, environment, volumes)  
- **entrypoint.sh** – startup script that checks the server JAR exists, applies EULA and RAM settings, and starts the server.
- **.gitignore** – excludes irrelevant files from version control  
- **.env.example** – sample environment configuration  

---

##  Quickstart

### Prerequisites
- [Docker](https://docs.docker.com/get-docker/) installed  
- [Docker Compose](https://docs.docker.com/compose/install/) installed  
- Server JAR is automatically downloaded during the **Docker image build** using the `SERVER_JAR_URL` build argument. 
  The entrypoint script only checks if the file exists.

### Start the Server



### Clone and Run
Clone this repository and start the Minecraft server using Docker Compose:

```bash
git clone <https://github.com/A-Marbach/minecraft-server>
cd <minecraft-server>
docker-compose up -d --build
```


### Check logs:

```bash
docker logs -f mc-server
```



### Stop the server:


```bash
docker stop mc-server
```

## Usage

### Configuration

Environment variables are defined in the docker-compose.yaml.
You can change them as needed:


```yaml
environment:
  EULA: "true"           # You must accept the Minecraft EULA
  MAX_RAM: "2G"          # JVM maximum memory allocation
  MIN_RAM: "1G"          # JVM minimum memory allocation
  SERVER_JAR_URL: "https://piston-data.mojang.com/v1/objects/95495a7f485eedd84ce928cef5e223b757d2f764/server.jar" # optional: specific version
# Used as a build argument in Dockerfile. The JAR is downloaded during image build, not by the container.
```

⚠️ Do not store credentials, tokens, or sensitive data inside the repository. Use a .env file if needed.

### Volumes & Persistence

Game data and configuration are stored in a volume so they survive container restarts:


```yaml
volumes:
  - ./data:/opt/minecraft
```

This ensures:

* World saves are not lost

* Configuration persists across rebuilds

### Port Mapping

The server runs inside the container on port 25565.
It is mapped to host port 8888 for external access:


```yaml
ports:
  - "8888:25565"
```

You can connect via Minecraft client using:

`<your-server-ip>:8888`

### Project Structure
```
.
├── .gitignore
├── docker-compose.yaml
├── Dockerfile
├── entrypoint.sh
└── README.md
```

### Testing

1. Verify Server Port

You can use `nc` (netcat) if installed on your system:

```bash
nc -zv <your-server-ip> 8888
```

⚠️ If nc is not available (e.g., on Windows), you can use Python mcstatus instead:

```bash
pip install mcstatus
mcstatus <your-server-ip>:8888 status
```

2. Confirm Persistence

Restart the container to ensure that world data and configuration persist:

```bash
docker restart mc-server
```


### Notes

This project is for educational purposes.

No sensitive information (SSH keys, tokens, IP addresses, etc.) should be committed to the repository.

All configuration is done via environment variables in accordance with best practices.

