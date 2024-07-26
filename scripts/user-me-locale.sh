#!/bin/bash
################################################################################
# Script
################################################################################

set -exuo pipefail

# Set up locales.
echo "${LOCAL_LANG} UTF-8" | tee /etc/locale.gen > /dev/null
dpkg-reconfigure --frontend=noninteractive locales
echo "LANG=${LOCAL_LANG}" | tee -a /etc/default/locale > /dev/null

# Select locale.
cat << EOF >> "/etc/profile.d/010-locale.sh"
export LANG="${LOCAL_LANG}"
EOF

################################################################################
# End of file
################################################################################
