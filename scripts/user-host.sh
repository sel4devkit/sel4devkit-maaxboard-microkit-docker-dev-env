#!/bin/bash
################################################################################
# Script
################################################################################

set -exuo pipefail

# Default host.
mkdir "/host/"
cat << 'EOF' >> "/host/README.txt"
User launched without HOST_DIR.
This host will not persistient beyond the execution of this container.
EOF
chown -R "${USER_NAME}:${GROUP_NAME}" "/host"
chmod -R ug+rw "/host"

################################################################################
# End of file
################################################################################
