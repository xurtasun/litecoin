FROM alpine:3.15

LABEL MAINTAINER="xavi.urta@gmail.com"

WORKDIR /home/litecoin

RUN adduser -S litecoin \
    && apk update \
    && apk add curl gnupg ca-certificates 
    
ENV LITECOIN_VERSION=0.18.1
ENV LITECOIN_DATA=/home/litecoin/.litecoin

RUN curl -SLO https://download.litecoin.org/litecoin-${LITECOIN_VERSION}/linux/litecoin-${LITECOIN_VERSION}-x86_64-linux-gnu.tar.gz \
    && curl -SLO https://download.litecoin.org/litecoin-${LITECOIN_VERSION}/linux/litecoin-${LITECOIN_VERSION}-linux-signatures.asc \
    && gpg --receive-keys 59CAF0E96F23F53747945FD4FE3348877809386C \
    && gpg --verify litecoin-${LITECOIN_VERSION}-linux-signatures.asc \
    && grep $(sha256sum litecoin-${LITECOIN_VERSION}-x86_64-linux-gnu.tar.gz | awk '{ print $1 }') litecoin-${LITECOIN_VERSION}-linux-signatures.asc \
    && ls -la * \
    && ls -la /usr/local/bin \
    && tar --strip=2 -xzf *.tar.gz -C /usr/local/bin \
    && rm *.tar.gz

ENV GLIBC_VERSION=2.34-r0

RUN curl -S https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub -o /etc/apk/keys/sgerrand.rsa.pub \
    && curl -SLO https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-${GLIBC_VERSION}.apk \
    && curl -SLO  https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-bin-${GLIBC_VERSION}.apk \
    && apk --no-cache add glibc-${GLIBC_VERSION}.apk \
    && apk --no-cache add glibc-bin-${GLIBC_VERSION}.apk 

COPY entrypoint.sh entrypoint.sh

USER litecoin

ENTRYPOINT ["/bin/sh", "entrypoint.sh"]

CMD ["litecoind"]
