#!/bin/sh

set -e

BIN_DIR=${BIN_DIR:-"./bin"}
BIN_CMD="$BIN_DIR/vanadia"
VERSION=${VERSION:-"1.1.1"}

platform_os() {
  uname -s | tr '[:upper:]' '[:lower:]'
}

download() {
  mkdir -p "$BIN_DIR"
  curl -sfL "https://github.com/bukalapak/vanadia/releases/download/v${VERSION}/vanadia-v${VERSION}.$(platform_os)-amd64.tar.gz" | tar -C "$BIN_DIR" -x vanadia
}

if [ ! -f "$BIN_CMD" ]; then
  download
fi

if ! "$BIN_CMD" --version | grep -q "$VERSION"; then
  download
fi
