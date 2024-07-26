#!/bin/bash
################################################################################
# Script
################################################################################

set -exuo pipefail

# Acquire probable python dependencies for onward tool chains.
# Acquiring these in advance, brings a performance benefit.
pip install "mypy==0.910"
pip install "black==21.7b0"
pip install "flake8==3.9.2"
pip install "ply==3.11"
pip install "Jinja2==3.0.3"
pip install "PyYAML==6.0"
pip install "pyfdt==0.3"
pip install "lxml==5.2.1"

################################################################################
# End of file
################################################################################
