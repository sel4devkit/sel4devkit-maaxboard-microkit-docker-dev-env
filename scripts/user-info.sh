#!/bin/bash
################################################################################
# Script
################################################################################

set -exuo pipefail

# Information. Format: LABEL MAJOR MINOR
cat << 'EOF' >> "/info.txt"
sel4devkit-maaxboard-microkit-docker-dev-env 1 0
EOF

# Information Makefile Check.
cat << 'EOF' >> "/check.mk"
################################################################################
# Makefile
################################################################################

#===========================================================
# Check
#===========================================================

# Expected.
EXP_LABEL := $(word 1,${EXP_INFO})
EXP_MAJOR := $(word 2,${EXP_INFO})
EXP_MINOR := $(word 3,${EXP_INFO})

INF_PATH_FILE := /info.txt
ifeq ($(wildcard ${INF_PATH_FILE}),)
    HALT := TRUE
else
    # Actual.
    ACT_INFO := $(file < ${INF_PATH_FILE})
    ACT_LABEL := $(word 1,${ACT_INFO})
    ACT_MAJOR := $(word 2,${ACT_INFO})
    ACT_MINOR := $(word 3,${ACT_INFO})

    # Compare: LABEL.
    ifneq ("${EXP_LABEL}", "*")
        ifneq ("${EXP_LABEL}", "${ACT_LABEL}")
            HALT := TRUE
        endif
    endif

    # Compare: MAJOR.
    ifneq ("${EXP_MAJOR}", "*")
        ifneq ("${EXP_MAJOR}", "${ACT_MAJOR}")
            HALT := TRUE
        endif
    endif

    # Compare: MINOR.
    ifneq ("${EXP_MINOR}", "*")
        ifneq ("${EXP_MINOR}", "${ACT_MINOR}")
            HALT := TRUE
        endif
    endif
endif

################################################################################
# End of file
################################################################################
EOF

################################################################################
# End of file
################################################################################
