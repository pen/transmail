FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y \
    fetchmail \
    postfix \
    libsasl2-modules \
    ca-certificates \
    gosu \
    && rm -rf /var/lib/apt/lists/*

ARG UID=1000
ARG GID=1000
RUN groupadd -g ${GID} transmail \
 && useradd -m -u ${UID} -g ${GID} -d /home/transmail -s /bin/bash transmail

COPY --chown=root:root rootfs /
RUN chown -R transmail:transmail /home/transmail
RUN chmod 700 /etc/rc.entry && chmod 755 /usr/local/bin/transmail-deliver
RUN mkdir /ext

ENTRYPOINT ["/etc/rc.entry"]
