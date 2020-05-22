# Isso – a commenting server similar to Disqus

Docker image for Isso

![logo](https://posativ.org/isso/_static/isso.svg)

## Usage

You should have `/db` and `/config` directories :

#### docker-compose.yml

```yaml
version: "3"

services:
  isso:
    image: registry.gitlab.com/hatamiarash7/docker-isso
    restart: unless-stopped
    container_name: isso
    environment:
      - GID=1000
      - UID=1000
    volumes:
      - ./config:/config
      - ./db:/db
    networks:
      - traefik
    labels:
      - "traefik.enable=true"
      - "traefik.docker.network=traefik"
      - "traefik.http.routers.isso.rule=Host(`isso.domain.com`)"
      - "traefik.http.routers.isso.tls.certresolver=letsencrypt"
      - "traefik.http.routers.isso.entrypoints=websecure"
      - "traefik.http.routers.isso.service=isso"
      - "traefik.http.routers.isso-http.rule=Host(`isso.domain.com`)"
      - "traefik.http.routers.isso-http.entrypoints=web"
      - "traefik.http.routers.isso-http.middlewares=isso-https@docker"
      - "traefik.http.services.isso.loadbalancer.server.port=8080"
      - "traefik.http.middlewares.isso-https.redirectscheme.scheme=https"

networks:
  traefik:
    external: true
```

#### /config/isso.conf

```ini
[general]
dbpath = /db/comments.db
host = https://website.com/

[server]
listen = http://0.0.0.0:8080/
```
