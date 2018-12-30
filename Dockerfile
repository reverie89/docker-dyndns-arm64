FROM arm64v8/alpine:3.7

COPY providers.txt entrypoint.sh /

RUN chmod +x /entrypoint.sh \
&&	apk add --update wget \
&&	rm -rf /var/cache/apk/*

ENTRYPOINT [ "/entrypoint.sh" ]
