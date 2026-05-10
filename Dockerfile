FROM debian:bookworm-slim

RUN apt-get update \
 && apt-get install -y --no-install-recommends \
    ca-certificates \
    fetchmail \
    gosu \
    libsasl2-modules \
    postfix \
 && rm -rf /var/lib/apt/lists/*

RUN groupadd transmail \
 && useradd -m -g transmail -d /home/transmail -s /usr/sbin/nologin transmail

COPY --chown=root:root rootfs /
RUN chmod 700 /etc/rc.entry \
 && chmod 755 /usr/local/bin/transmail-deliver \
 && chown -R transmail:transmail /home/transmail

ENTRYPOINT ["/etc/rc.entry"]
