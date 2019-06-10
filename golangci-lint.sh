#!/bin/sh

set -e

LINTER_DIR=${LINTER_DIR:-"./bin"}
LINTER_BIN="$LINTER_DIR/golangci-lint"
LINTER_VERSION=${LINTER_VERSION:-"1.17.0"}

download_linter() {
  curl -sfL https://install.goreleaser.com/github.com/golangci/golangci-lint.sh | sh -s -- -b "$LINTER_DIR" "v$LINTER_VERSION"
}

if [ ! -f "$LINTER_BIN" ]; then
  download_linter
fi

if ! "$LINTER_BIN" --version | grep -q "$LINTER_VERSION"; then
  download_linter
fi
