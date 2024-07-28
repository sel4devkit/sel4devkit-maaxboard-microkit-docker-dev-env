# Introduction

This Package forms part of the seL4 Developer Kit. It facilitates the overall
management of the MaaXBoard Microkit Docker Development Environment.

Our Docker Images are shared on a Docker Hub (Git Hub Packages), and may be
retrieved and started via this Package.

The following distinct activities are supported:
* __Building__: Building Docker Image
* __Pushing__: Pushing Docker Image into a Docker Hub
* __Pulling__: Pushing Docker Image from a Docker Hub
* __Running__: Running a Docker Image

# Usage

Preferred usage may vary, depending on your individual setup.

Normal usage would involve pulling a pre-built Docker Image, and then running
this Docker Image, optionally mapping in a local development area (HOST_PATH),
and a local home area (HOME_PATH).

Note that, apart from any mapped areas, the entirety of the Docker Image will
be lost when the Docker Image is exited. This is deliberate and desirable,
ensuring a consistent starting environment for each session.

Two different entry points are provided, as "user-dev" and "user-me":
* The "user-dev" operates with a fixed user name "developer", granted password
  free access to root, via sudo. This
  configuration is fully defined, and thus may be prepared in
advance. This property permits a very simple deployment, and is particularly
suited to Windows.
* The "user-me" is intended to be built, and then deployed, for a specific
  invoking user. It operates with the username of the invoking user, granted
password free access to root, via sudo. This configuration can not be prepared
in advance, but does provide a smoother integration for the invoking user. It
is particularly suited to Linux.

Once the Docker Image is started, its version may be inspected as follows:
```
cat /version.txt
```

## Windows

Only Deployment is supported on Windows.

Pulling Docker Image (user-dev):
```
docker pull ghcr.io/sel4devkit/sel4devkit-maaxboard-camkes-docker-dev-env/user-dev:latest
```

Running Docker Image (user-dev):
```
docker run --rm --interactive --tty --hostname "sel4devkit-maaxboard-camkes" \
    ghcr.io/sel4devkit/sel4devkit-maaxboard-camkes-docker-dev-env/user-dev:latest \
    --mount type=bind,source="<HOST_PATH>",target="/host"
    /bin/bash --login
```

## Linux

Deployment, and Maintenance, is supported on Linux.

Show usage instructions:
```
make
```

### User Developer

Pulling Docker Image (user-dev):
```
make pull IMAGE=user-dev
```

Running Docker Image (user-dev):
```
make run IMAGE=user-dev HOST_PATH=<HOST_PATH> HOME_PATH=<HOME_PATH>
```

### User Me

Pulling pre-built Docker Image (dep):
```
make pull IMAGE=dep
```

Building Docker Image (user-me):
```
make build IMAGE=user-me
```

Running Docker Image (user-dev):
```
make run IMAGE=user-me HOST_PATH=<HOST_PATH> HOME_PATH=<HOME_PATH>
```

# Maintenance

Presents detailed technical aspects relevant to understanding and maintaining
this Package.

## Git Hub Packages

Our Docker Images are retained in Git Hub Packages.

To work with Git Hub Packages, you need to establish suitable credentials,
described as creating a Personal Access Token (Classic). The process for doing
so is described in detail through the material below:
* https://docs.github.com/en/packages/learn-github-packages/introduction-to-github-packages
* https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/managing-your-personal-access-tokens#creating-a-personal-access-token-classic
* https://docs.github.com/en/packages/learn-github-packages/about-permissions-for-github-packages#about-scopes-and-permissions-for-package-registries
* https://docs.github.com/en/packages/working-with-a-github-packages-registry/working-with-the-container-registry#authenticating-with-a-personal-access-token-classic

## Organisation 

The primary Docker Images are arranged in layers of increasing capability:
* __Base__: The base image is provided externally as: debian:bookworm-slim
* __Core__: Extends Base, with a suite of standard productivity
  utilities.
* __Dep__: Extends Core, with a collection of dependencies as needed to
  achieve specific tasks.

Two alternative Docker Images provide a user environment:
* __User Dev__: Extends Dep, to provide an environment for user "developer".
* __User Me__: Extends Dep, to provide an environment tailored for the
  invoking user.

## Git Hub and SSH

Most seL4 material is maintained in Git, and specifically hosted on Git Hub.
It is conventional to access this material via either HTTPS or SSH. The Docker
Image is configured to permit use of either. In general, HTTPS requires less
configuration, but may not be available in all contexts.

For SSH, at Docker Image build, your host SSH Credentials are made available
to the process via ssh-agent and ssh-add. This style, intentionally, ensures
the Credentials are not embedded in the built Image. Thus, for SSH, at run
time, no SSH Credentials are available by default. You may choose to map in
your HOME_PATH, effectively importing all your personal settings (including
any SSH Credentials) for use within the Docker Image.

## Distribution and Compiler Toolchain

The Microkit Toolchain is compatible with recent Distributions and compilers.
We choose to provision a current Distribution (Debian Bookworm) and its
default provision of needed 64-bit Compilers and 64-bit Cross-Compilers:
* GCC 12 (64-bit AMD64)
* GCC 12 (64-bit AArch64 (Also known as: ARM64))

## Tools With User Level Install

The Microkit Toolchain includes dependencies on the following Tools which are
normally installed and configured to some extent on a per-user basis:
+ Python
+ Rust

Such Tools are problematic when seeking to frame a singular standard Image.
The decision is taken to install these, with the user-specific properties, at
the layer where user details become available (User Dev or User Me). This
provides a conventional operating environment, while accepting a slightly
greater per-user Image build time.
