################################################################################
# Makefile
################################################################################

#===========================================================
# Configure
#===========================================================

# Docker Hub.
DOCKERHUB := ghcr.io/sel4devkit

# Namespace for Docker Images.
NAMESPACE := sel4devkit-maaxboard-microkit-docker-dev-env

# Image.
IMAGE ?= undefined

# Mapping.
HOME_PATH ?= undefined
HOST_PATH ?= undefined

#===========================================================
# Usage
#===========================================================

.PHONY: usage
usage: 
	@echo "usage: make <target> IMAGE=<image> <OPTIONS>"
	@echo ""
	@echo "<target> is one off:"
	@echo "build (build <image> in local docker)"
	@echo "run   (run <image> in local docker)"
	@echo "pull  (pull <image> from ${DOCKERHUB} into local docker)"
	@echo "push  (push <image> from local docker into ${DOCKERHUB})"
	@echo "clean (delete <image> from local docker)"
	@echo ""
	@echo "<image> is one off:"
	@echo "core|dep|user-dev|user-me"
	@echo ""
	@echo "<OPTIONS> is zero or more off:"
	@echo "HOME_PATH=<path> (mapped as: /home/<username>)"
	@echo "HOST_PATH=<path> (mapped as: /host)"

#===========================================================
# Define
#===========================================================

# Tag.
STAMP_NAME := undefined
ifneq (${IMAGE}, undefined)
ifeq (${IMAGE}, user-me)
STAMP_NAME := ${DOCKERHUB}/${NAMESPACE}/${IMAGE}-$(shell id -un):latest
else
STAMP_NAME := ${DOCKERHUB}/${NAMESPACE}/${IMAGE}:latest
endif
endif

# Context.
STAMP_DATE := $(shell date)

#===========================================================
# Target
#===========================================================

.PHONY: check
check:
ifeq ($(shell id -u),0)
	@echo "You are running this as root."
	@echo "This facility is to be run in your user account."
	@exit 1
endif

.PHONY: build
build: check
build:
	ssh-agent bash -c "ssh-add ; \
	                   docker build \
	                          --ssh default \
	                          --rm \
	                          --force-rm \
	                          --build-arg DOCKERHUB='${DOCKERHUB}' \
	                          --build-arg NAMESPACE='${NAMESPACE}' \
	                          --build-arg STAMP_NAME='${STAMP_NAME}' \
	                          --build-arg STAMP_DATE='${STAMP_DATE}' \
	                          --build-arg=HOST_UID="$(shell id -u)" \
	                          --build-arg=HOST_USER_NAME="$(shell id -un)" \
	                          --build-arg=HOST_GID="$(shell id -g)" \
	                          --build-arg=HOST_GROUP_NAME="$(shell id -gn)" \
	                          --build-arg=HOST_LOCAL_LANG="$(LANG)" \
	                          --file 'dockerfiles/${IMAGE}.Dockerfile' \
	                          --tag '${STAMP_NAME}' ."

MAP_HOME_ARG :=
ifneq (${HOME_PATH}, undefined)
ifeq (${IMAGE}, user-me)
MAP_HOME_ARG := --mount type=bind,source="${HOME_PATH}",target="/home/$(shell id -un)"
else
MAP_HOME_ARG := --mount type=bind,source="${HOME_PATH}",target="/home/developer"
endif
endif

MAP_HOST_ARG :=
ifneq (${HOST_PATH}, undefined)
MAP_HOST_ARG := --mount type=bind,source="${HOST_PATH}",target="/host"
endif

ETC_LOCALTIME := $(realpath /etc/localtime)

.PHONY: run
run: check
run:
	-docker run \
	        --rm \
	        --interactive \
	        --tty \
	        --hostname "sel4devkit-maaxboard-microkit" \
	        ${MAP_HOME_ARG} \
	        ${MAP_HOST_ARG} \
	        --mount type=bind,source="${ETC_LOCALTIME}",target="/etc/localtime,readonly" \
	        "${STAMP_NAME}" /bin/bash --login

.PHONY: pull
pull: check
pull:
	docker pull ${STAMP_NAME}

.PHONY: push
push: check
push:
	docker push ${STAMP_NAME}

.PHONY: clean
clean: check
	docker image remove ${STAMP_NAME}

################################################################################
# End of file
################################################################################
