FROM alpine:3.9.4

RUN apk add --no-cache --update curl

COPY migrate.sh migrate.sh

CMD ["sh","migrate.sh"]