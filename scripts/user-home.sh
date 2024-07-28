#!/bin/bash
################################################################################
# Script
################################################################################

set -exuo pipefail

# Default home.
mkdir "/home/${USER_NAME}"
cat << 'EOF' >> "/home/${USER_NAME}/README.txt"
User launched without HOME_DIR.
This home will not persistient beyond the execution of this container.
EOF
chown -R "${USER_NAME}:${GROUP_NAME}" "/home/${USER_NAME}"
chmod -R ug+rw "/home/${USER_NAME}"

################################################################################
# End of file
################################################################################
