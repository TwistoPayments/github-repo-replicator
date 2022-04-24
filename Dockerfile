FROM alpine:3.15

COPY ./src /home/ghreplicator/src

RUN apk add --no-cache bash git openssh; \
    addgroup -g 1000 ghreplicator; \
    adduser -u 1000 -G ghreplicator -h /home/ghreplicator -D ghreplicator; \
    mkdir -m 0700 /home/ghreplicator/.ssh; \
    echo $'\
Host upstream-github-repo \n\
    Hostname github.com \n\
    IdentityFile=/home/ghreplicator/.ssh/upstream_deploy_key \n\
Host downstream-github-repo \n\
    Hostname github.com \n\
    IdentityFile=/home/ghreplicator/.ssh/downstream_deploy_key \n\
' >> /home/ghreplicator/.ssh/config; \
    chown -R 1000:1000 /home/ghreplicator/.ssh; \
    chown -R ghreplicator:ghreplicator /home/ghreplicator/; \
    chmod 755 /home/ghreplicator/src/entry.sh;

USER ghreplicator
WORKDIR /home/ghreplicator

ENTRYPOINT ["./src/entry.sh"]
