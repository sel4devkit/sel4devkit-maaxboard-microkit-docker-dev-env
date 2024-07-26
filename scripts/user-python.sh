#!/bin/bash
################################################################################
# Script
################################################################################

set -exuo pipefail

# Skeleton.
mkdir -p "/util"
mkdir -p "/util/python"

# For chosen user, download to cache anticipated python dependencies for
# onward tool chains.
mkdir -p "/util/python/cache"
chown "${USER_NAME}:${GROUP_NAME}" "/util/python/cache"
chmod ug+rw "/util/python/cache"
pip config --global set global.cache-dir "/util/python/cache"

mkdir -p "/util/python/download"
chown "${USER_NAME}:${GROUP_NAME}" "/util/python/download"
chmod ug+rw "/util/python/download"
sudo -u "${USER_NAME}" pip download --dest /util/python/download "mypy==0.910" 
sudo -u "${USER_NAME}" pip download --dest /util/python/download "black==21.7b0"
sudo -u "${USER_NAME}" pip download --dest /util/python/download "flake8==3.9.2"
sudo -u "${USER_NAME}" pip download --dest /util/python/download "ply==3.11"
sudo -u "${USER_NAME}" pip download --dest /util/python/download "Jinja2==3.0.3"
sudo -u "${USER_NAME}" pip download --dest /util/python/download "PyYAML==6.0"
sudo -u "${USER_NAME}" pip download --dest /util/python/download "pyfdt==0.3"
sudo -u "${USER_NAME}" pip download --dest /util/python/download "lxml==5.2.1"
rm -rf "/util/python/download"

################################################################################
# End of file
################################################################################
