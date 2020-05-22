FROM alpine:3.9.6

ENV GID=1000 UID=1000

RUN apk -U upgrade \
 && apk add -t build-dependencies \
    python3-dev \
    libffi-dev \
    build-base \
 && apk add \
    python3 \
    sqlite \
    openssl \
    ca-certificates \
    su-exec \
    tini \
 && pip3 install --no-cache isso \
 && apk del build-dependencies \
 && rm -rf /tmp/* /var/cache/apk/*

COPY init.sh /usr/local/bin/init.sh

RUN chmod +x /usr/local/bin/init.sh

EXPOSE 8080

VOLUME /db /config

CMD ["init.sh"]
