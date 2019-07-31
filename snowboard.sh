#!/bin/sh

set -e

latest_version() {
  curl -sL https://api.github.com/repos/bukalapak/snowboard/releases/latest | \
    grep '"tag_name":' | \
    awk '{gsub("\"",""); gsub(",",""); gsub("v",""); print $2}'
}

BIN_DIR=${BIN_DIR:-"./bin"}
BIN_CMD="$BIN_DIR/snowboard"
VERSION=${VERSION:-$(latest_version)}

download() {
  OS_NAME=$(uname -s | tr '[:upper:]' '[:lower:]')
  DOWNLOAD_URL="https://github.com/bukalapak/snowboard/releases/download/v${VERSION}/snowboard-v${VERSION}.${OS_NAME}-amd64.tar.gz"

  mkdir -p "$BIN_DIR"
  echo "bukalapak/snowboard info found version: ${VERSION} for v${VERSION}/${OS_NAME}/amd64"
  echo "bukalapak/snowboard info ${DOWNLOAD_URL}"
  curl -sfL "${DOWNLOAD_URL}" | tar -C "$BIN_DIR" -xz
  echo "bukalapak/snowboard info installed ${BIN_CMD}"
}

if [ ! -f "$BIN_CMD" ]; then
  download
fi

if ! "$BIN_CMD" --version | grep -q "$VERSION"; then
  download
fi

