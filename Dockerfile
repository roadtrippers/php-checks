FROM php@sha256:4361c0c2767145d7fce396bd0a677dc716a4173e28c27ccf27cd345bd388c839
# sha256:4361c0c2767145d7fce396bd0a677dc716a4173e28c27ccf27cd345bd388c839 was tagged php:7.2-cli-alpine3.12 amd64

## Note that the image built (from Dockerfile.base) is public
## No source code should be in there.

RUN apk add --no-cache bash

COPY --chmod=755 ./entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
