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
chown "${USER_NAME}:${GROUP_NAME}" "/util/rust"

# Get Installer.
sudo -u "${USER_NAME}" curl --proto '=https' -sSf --tlsv1.2 https://sh.rustup.rs --output /util/rust/install-rust.sh
sudo -u "${USER_NAME}" chmod +x /util/rust/install-rust.sh

# Prepare.
sudo -u "${USER_NAME}" mkdir -p "/util/rust/rustup"
sudo -u "${USER_NAME}" mkdir -p "/util/rust/cargo"

# Execute.
export RUSTUP_HOME="/util/rust/rustup"
export CARGO_HOME="/util/rust/cargo"
sudo -u "${USER_NAME}" --preserve-env=RUSTUP_HOME,CARGO_HOME /util/rust/install-rust.sh --no-modify-path -y

# Add specific target.
sudo -u "${USER_NAME}" --preserve-env=RUSTUP_HOME,CARGO_HOME /util/rust/cargo/bin/rustup target add x86_64-unknown-linux-musl

# Get rust on path (for users).
cat << 'EOF' >> "/etc/profile.d/050-rust_path.sh"
export PATH="${PATH}:/util/rust/cargo/bin"
EOF

################################################################################
# End of file
################################################################################
