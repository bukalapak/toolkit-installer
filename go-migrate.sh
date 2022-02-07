#!/bin/sh

set -e

INSTALL_DIR=${INSTALL_DIR:-"./bin"}
INSTALL_BIN="$INSTALL_DIR/migrate"
INSTALL_VERSION=${INSTALL_VERSION:-4.15.1}

download() {
  OS_NAME=$(uname -s | tr [:upper:] [:lower:])
  DOWNLOAD_URL="https://github.com/golang-migrate/migrate/releases/download/v${INSTALL_VERSION}/migrate.${OS_NAME}-amd64.tar.gz"
  curl -sfL "${DOWNLOAD_URL}" | tar -C "$INSTALL_DIR" -xz "migrate"
}

if [ ! -f "$INSTALL_BIN" ]; then
  download
fi
