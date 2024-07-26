#!/bin/bash
################################################################################
# Script
################################################################################

set -exuo pipefail

# Rust favours an unconventional install process, not managed by a
# distribution package manager. Adopt this.

# Skeleton.
mkdir -p "/util"
mkdir -p "/util/rust"

# Get Installer.
cd "/util/rust"
curl --proto '=https' -sSf --tlsv1.2 https://sh.rustup.rs > install-rust.sh
chmod +x install-rust.sh

# Prepare.
mkdir -p "/util/rust/rustup"
mkdir -p "/util/rust/cargo"
chmod 777 -R "/util/rust/rustup"
chmod 777 -R "/util/rust/cargo"

# Execute.
cd "/util/rust"
export RUSTUP_HOME="/util/rust/rustup"
export CARGO_HOME="/util/rust/cargo"
./install-rust.sh --no-modify-path -y

# Add specific target.
/util/rust/cargo/bin/rustup target add x86_64-unknown-linux-musl

# Get rust on path (for users).
cat << 'EOF' >> "/etc/profile.d/050-rust_path.sh"
export PATH="${PATH}:/util/rust/cargo/bin"
EOF

################################################################################
# End of file
################################################################################
