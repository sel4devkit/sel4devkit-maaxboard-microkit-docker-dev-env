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
ARG HOST_UID
ARG HOST_USER_NAME
ARG HOST_GID
ARG HOST_GROUP_NAME
ARG HOST_LOCAL_LANG

#===========================================================
# Debian
#===========================================================

RUN groupadd --gid "${HOST_GID}" "${HOST_GROUP_NAME}"
RUN useradd --uid "${HOST_UID}" --gid "${HOST_GID}" "${HOST_USER_NAME}"
RUN passwd --delete "${HOST_USER_NAME}"
RUN usermod --append --groups "sudo" "${HOST_USER_NAME}"

#===========================================================
# Scripts
#===========================================================
ARG USER_NAME=${HOST_USER_NAME}
ARG GROUP_NAME=${HOST_GROUP_NAME}
ARG LOCAL_LANG=${HOST_LOCAL_LANG}

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

ARG SCRIPT=user-me-locale.sh
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
ENV STAMP_USER_ME="${STAMP_NAME} (${STAMP_DATE})"

#===========================================================
# Launch
#===========================================================
USER "${HOST_USER_NAME}"

################################################################################
# End of file
################################################################################
