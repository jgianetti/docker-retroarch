#
# https://github.com/jgianetti/docker-retroarch/
#

FROM debian:buster-slim

ARG UID
ENV UID=${UID:-1000}

RUN set -x \
    && apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y \
        retroarch \
    && rm -rf /var/lib/apt/lists/* \
    && useradd --create-home --shell /bin/bash --uid $UID developer

VOLUME ./retroarch/ /home/developer/retroarch/

USER developer
CMD ["/usr/bin/retroarch","--appendconfig=/home/developer/retroarch/retroarch.cfg"]
