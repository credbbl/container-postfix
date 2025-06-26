FROM debian:trixie-slim

ENV DEBIAN_FRONTEND=noninteractive

RUN groupadd -g 999 postfix
RUN groupadd -g 998 postdrop
RUN useradd -d /var/spool/postfix -r -s /bin/false -u 999 -g 999 postfix

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends postfix postfix-pcre && \
    mv /etc/postfix /etc/postfix-meta && \
    rm -rf /var/spool/postfix

VOLUME ["/var/lib/postfix"]
VOLUME ["/var/spool/postfix"]

COPY entrypoint /
ENTRYPOINT ["/entrypoint"]
CMD []
