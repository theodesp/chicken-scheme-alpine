FROM alpine:3.6
MAINTAINER thdespou@hotmail.com

# Configurations.
ENV CHICKEN_VERSION 4.12.0
ENV PLATFORM linux

# Install Packages
RUN apk update && apk --no-cache --update add make gcc musl-dev \
    ca-certificates openssl && update-ca-certificates
RUN set -o pipefail && wget -qO- https://code.call-cc.org/releases/$CHICKEN_VERSION/chicken-$CHICKEN_VERSION.tar.gz | tar xzv

WORKDIR /chicken-$CHICKEN_VERSION

# Install Chicken
RUN make PLATFORM=$PLATFORM && make PLATFORM=$PLATFORM install && make PLATFORM=$PLATFORM check
RUN rm -rf /chicken-$CHICKEN_VERSION

WORKDIR /
CMD ["csi"]