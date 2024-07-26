################################################################################
# Dockerfile
################################################################################

#===========================================================
# Paramaters
#===========================================================
ARG DOCKERHUB
ARG NAMESPACE

#===========================================================
# Base
#===========================================================
FROM ${DOCKERHUB}/${NAMESPACE}/core:latest

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
RUN apt-get install -y --no-install-recommends bison
RUN apt-get install -y --no-install-recommends build-essential
RUN apt-get install -y --no-install-recommends ccache
RUN apt-get install -y --no-install-recommends cmake
RUN apt-get install -y --no-install-recommends cpio
RUN apt-get install -y --no-install-recommends cpp-aarch64-linux-gnu
RUN apt-get install -y --no-install-recommends device-tree-compiler
RUN apt-get install -y --no-install-recommends flex
RUN apt-get install -y --no-install-recommends g++
RUN apt-get install -y --no-install-recommends g++-aarch64-linux-gnu
RUN apt-get install -y --no-install-recommends gcc
RUN apt-get install -y --no-install-recommends gcc-aarch64-linux-gnu
RUN apt-get install -y --no-install-recommends gnupg
RUN apt-get install -y --no-install-recommends libelf-dev
RUN apt-get install -y --no-install-recommends libncurses-dev
RUN apt-get install -y --no-install-recommends libssl-dev
RUN apt-get install -y --no-install-recommends libxml2-utils
RUN apt-get install -y --no-install-recommends meson
RUN apt-get install -y --no-install-recommends musl-tools
RUN apt-get install -y --no-install-recommends ninja-build
RUN apt-get install -y --no-install-recommends u-boot-tools

RUN apt-get clean autoclean
RUN apt-get autoremove --purge --yes

#===========================================================
# Scripts
#===========================================================
ARG SCRIPT=dep-version.sh
COPY scripts/${SCRIPT} /tmp/${SCRIPT}
RUN --mount=type=ssh /bin/bash --login /tmp/${SCRIPT}

#===========================================================
# Environment
#===========================================================
ENV STAMP_DEP="${STAMP_NAME} (${STAMP_DATE})"

################################################################################
# End of file
################################################################################
