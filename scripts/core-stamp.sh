#!/bin/bash
################################################################################
# Script
################################################################################

set -exuo pipefail

# Put in stamps for provenance.
cat << 'EOF' >> "/etc/profile.d/500-stamps.sh"
echo "============================================================"
echo "Stamps:"
if [[ -n "${STAMP_CORE}"     ]]; then echo "STAMP_CORE:     ${STAMP_CORE}";     fi
if [[ -n "${STAMP_DEP}"      ]]; then echo "STAMP_DEP:      ${STAMP_DEP}";      fi
if [[ -n "${STAMP_USER_DEV}" ]]; then echo "STAMP_USER_DEV: ${STAMP_USER_DEV}"; fi
if [[ -n "${STAMP_USER_ME}"  ]]; then echo "STAMP_USER_ME:  ${STAMP_USER_ME}";  fi
echo "============================================================"
EOF

################################################################################
# End of file
################################################################################
