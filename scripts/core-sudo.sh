#!/bin/bash
################################################################################
# Script
################################################################################

set -exuo pipefail

# Prepare sudo.
cat << EOF >> /etc/sudoers
Defaults        lecture_file = /etc/sudoers.lecture
Defaults        lecture = always
EOF

cat << EOF > /etc/sudoers.lecture
####################################################################
This is an ephemeral docker container.
Changes made outside mapped paths will be lost on exit.
####################################################################
EOF

################################################################################
# End of file
################################################################################
