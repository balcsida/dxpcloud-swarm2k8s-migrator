FROM alpine:3.9.4

RUN apk add --no-cache --update curl

ENTRYPOINT ["migrate.sh"]