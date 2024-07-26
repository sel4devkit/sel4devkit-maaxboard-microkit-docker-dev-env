################################################################################
# Dockerfile
################################################################################

#===========================================================
# Base
#===========================================================
FROM debian:bookworm-slim

#===========================================================
# Paramaters
#===========================================================
ARG STAMP_NAME
ARG STAMP_DATE

#===========================================================
# Debian
#===========================================================
RUN apt-get update -q

ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get install -y --no-install-recommends apt-utils
RUN apt-get install -y --no-install-recommends bc
RUN apt-get install -y --no-install-recommends ca-certificates
RUN apt-get install -y --no-install-recommends coreutils
RUN apt-get install -y --no-install-recommends curl
RUN apt-get install -y --no-install-recommends file
RUN apt-get install -y --no-install-recommends git
RUN apt-get install -y --no-install-recommends iproute2
RUN apt-get install -y --no-install-recommends iputils-ping
RUN apt-get install -y --no-install-recommends less
RUN apt-get install -y --no-install-recommends locales
RUN apt-get install -y --no-install-recommends make
RUN apt-get install -y --no-install-recommends python3
RUN apt-get install -y --no-install-recommends python3-dev
RUN apt-get install -y --no-install-recommends python3-pip
RUN apt-get install -y --no-install-recommends python3-venv
RUN apt-get install -y --no-install-recommends python-is-python3
RUN apt-get install -y --no-install-recommends rsync
RUN apt-get install -y --no-install-recommends ssh
RUN apt-get install -y --no-install-recommends sudo
RUN apt-get install -y --no-install-recommends traceroute
RUN apt-get install -y --no-install-recommends unzip
RUN apt-get install -y --no-install-recommends vim
RUN apt-get install -y --no-install-recommends wget
RUN apt-get install -y --no-install-recommends xxd

RUN apt-get clean autoclean
RUN apt-get autoremove --purge --yes

#===========================================================
# Scripts
#===========================================================
ARG SCRIPT=core-ssh.sh
COPY scripts/${SCRIPT} /tmp/${SCRIPT}
RUN --mount=type=ssh /bin/bash --login /tmp/${SCRIPT}

ARG SCRIPT=core-curl.sh
COPY scripts/${SCRIPT} /tmp/${SCRIPT}
RUN --mount=type=ssh /bin/bash --login /tmp/${SCRIPT}

ARG SCRIPT=core-sudo.sh
COPY scripts/${SCRIPT} /tmp/${SCRIPT}
RUN --mount=type=ssh /bin/bash --login /tmp/${SCRIPT}

ARG SCRIPT=core-repo.sh
COPY scripts/${SCRIPT} /tmp/${SCRIPT}
RUN --mount=type=ssh /bin/bash --login /tmp/${SCRIPT}

ARG SCRIPT=core-stamp.sh
COPY scripts/${SCRIPT} /tmp/${SCRIPT}
RUN --mount=type=ssh /bin/bash --login /tmp/${SCRIPT}

#===========================================================
# Environment
#===========================================================
ENV CURL_HOME "/util/curl_home"
ENV STAMP_CORE="${STAMP_NAME} (${STAMP_DATE})"

################################################################################
# End of file
################################################################################
