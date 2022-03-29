#!/bin/sh

set -e

INSTALL_DIR=${INSTALL_DIR:-"./bin"}
INSTALL_BIN="$INSTALL_DIR/buf"
INSTALL_VERSION=${INSTALL_VERSION:-0.24.0}

download() {
  OS_NAME=$(uname -s)
  DOWNLOAD_URL="https://github.com/bufbuild/buf/releases/download/v${INSTALL_VERSION}/buf-${OS_NAME}-x86_64.tar.gz"
  curl -sSL "${DOWNLOAD_URL}" | tar -xvzf - -C "$INSTALL_DIR" --strip-components 1
}

if [ ! -f "$INSTALL_BIN" ]; then
  download
fi
