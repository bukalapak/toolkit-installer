#!/bin/sh

set -e

BIN_DIR=${BIN_DIR:-"./bin"}
BIN_CMD="$BIN_DIR/vanadia"
VERSION=${VERSION:-"1.1.1"}

platform_os() {
  uname -s | tr '[:upper:]' '[:lower:]'
}

download() {
  PLATFORM_OS=$(platform_os)

  mkdir -p "$BIN_DIR"
  echo "bukalapak/vanadia info found version: ${VERSION} for v${VERSION}/${PLATFORM_OS}/amd64"
  curl -sfL "https://github.com/bukalapak/vanadia/releases/download/v${VERSION}/vanadia-v${VERSION}.${PLATFORM_OS}-amd64.tar.gz" | tar -C "$BIN_DIR" -x vanadia
  echo "bukalapak/vanadia info installed ${BIN_CMD}"
}

if [ ! -f "$BIN_CMD" ]; then
  download
fi

if ! "$BIN_CMD" --version | grep -q "$VERSION"; then
  download
fi
