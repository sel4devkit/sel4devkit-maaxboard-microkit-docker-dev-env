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
FROM ${DOCKERHUB}/${NAMESPACE}/dep:latest

#===========================================================
# Paramaters
#===========================================================
ARG STAMP_NAME
ARG STAMP_DATE

#===========================================================
# Debian
#===========================================================
RUN groupadd "developer"
RUN useradd --gid "developer" "developer"
RUN passwd --delete "developer"
RUN usermod --append --groups "sudo" "developer"

#===========================================================
# Scripts
#===========================================================
ARG USER_NAME="developer"
ARG GROUP_NAME="developer"

ARG SCRIPT=user-python.sh
COPY scripts/${SCRIPT} /tmp/${SCRIPT}
RUN --mount=type=ssh /bin/bash --login /tmp/${SCRIPT}

ARG SCRIPT=user-rust.sh
COPY scripts/${SCRIPT} /tmp/${SCRIPT}
RUN --mount=type=ssh /bin/bash --login /tmp/${SCRIPT}

ARG SCRIPT=user-home.sh
COPY scripts/${SCRIPT} /tmp/${SCRIPT}
RUN --mount=type=ssh /bin/bash --login /tmp/${SCRIPT}

ARG SCRIPT=user-host.sh
COPY scripts/${SCRIPT} /tmp/${SCRIPT}
RUN --mount=type=ssh /bin/bash --login /tmp/${SCRIPT}

ARG SCRIPT=user-start.sh
COPY scripts/${SCRIPT} /tmp/${SCRIPT}
RUN --mount=type=ssh /bin/bash --login /tmp/${SCRIPT}

ARG SCRIPT=user-info.sh
COPY scripts/${SCRIPT} /tmp/${SCRIPT}
RUN --mount=type=ssh /bin/bash --login /tmp/${SCRIPT}

#===========================================================
# Environment
#===========================================================
ENV RUSTUP_HOME="/util/rust/rustup"
ENV CARGO_HOME="/util/rust/cargo"
ENV STAMP_USER_DEV="${STAMP_NAME} (${STAMP_DATE})"

#===========================================================
# Launch
#===========================================================
USER "developer"

################################################################################
# End of file
################################################################################
