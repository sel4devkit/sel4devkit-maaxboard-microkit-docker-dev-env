#!/bin/bash
################################################################################
# Script
################################################################################

set -exuo pipefail

# Skeleton.
mkdir -p "/util"
mkdir -p "/util/repo"

# Install repo.
wget -O - "https://storage.googleapis.com/git-repo-downloads/repo" > "/util/repo/repo"
chmod a+x "/util/repo/repo"

# Get repo on path (for users).
cat << 'EOF' >> "/etc/profile.d/050-repo_path.sh"
export PATH="${PATH}:/util/repo"
EOF

################################################################################
# End of file
################################################################################
