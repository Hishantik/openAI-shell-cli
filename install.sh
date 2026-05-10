#!/bin/bash
set -e

VERSION="0.4.0"
REPO="Hishantik/openAI-shell-cli"
INSTALL_DIR="${HOME}/.local/bin"
BINARY_NAME="dekuai"

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

info() { echo -e "${GREEN}==>${NC} $1"; }
warn() { echo -e "${YELLOW}==>${NC} $1"; }

# Detect OS
OS=$(uname -s)
case "$OS" in
    Linux*) INSTALL_DIR="/usr/local/bin";;
    Darwin*) INSTALL_DIR="/usr/local/bin";;
    *) warn "Unsupported OS: $OS"; exit 1;;
esac

info "Installing DekuAI v${VERSION}..."

# Check for Go
if ! command -v go &> /dev/null; then
    warn "Go is not installed. Installing from source requires Go."
    echo "Please install Go from: https://go.dev/doc/install"
    exit 1
fi

# Get script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Check if we're in the repo directory
if [ -f "$SCRIPT_DIR/main.go" ] && [ -f "$SCRIPT_DIR/go.mod" ]; then
    info "Building from local source..."
    cd "$SCRIPT_DIR"
    go build -o "$BINARY_NAME" .
    if [ "$SCRIPT_DIR/bin" = "$INSTALL_DIR" ]; then
        sudo cp "$BINARY_NAME" "$INSTALL_DIR/"
    else
        mkdir -p "$INSTALL_DIR"
        cp "$BINARY_NAME" "$INSTALL_DIR/"
    fi
else
    # Download binary from GitHub releases
    info "Downloading pre-built binary..."

    TMP_DIR=$(mktemp -d)
    cd "$TMP_DIR"

    case "$OS" in
        Linux*)
            FILENAME="dekuai-linux-amd64"
            ;;
        Darwin*)
            FILENAME="dekuai-darwin-amd64"
            ;;
    esac

    URL="https://github.com/${REPO}/releases/download/v${VERSION}/${FILENAME}"

    if command -v curl &> /dev/null; then
        curl -fsSL "$URL" -o "$BINARY_NAME" || {
            warn "Pre-built binary not available. Building from source..."
            exit 1
        }
    elif command -v wget &> /dev/null; then
        wget -q "$URL" -O "$BINARY_NAME" || {
            warn "Pre-built binary not available. Building from source..."
            exit 1
        }
    fi

    chmod +x "$BINARY_NAME"
    mkdir -p "$INSTALL_DIR"
    sudo cp "$BINARY_NAME" "$INSTALL_DIR/"

    rm -rf "$TMP_DIR"
fi

# Add to PATH if needed
if [[ ":$PATH:" != *":$INSTALL_DIR:"* ]]; then
    warn "Add $INSTALL_DIR to your PATH if not already there."
    if [ -f "$HOME/.bashrc" ]; then
        echo "export PATH=\"\$PATH:$INSTALL_DIR\"" >> "$HOME/.bashrc"
    fi
fi

info "Installed successfully!"
info "Run 'dekuai' to start."

# Cleanup
rm -f "$SCRIPT_DIR/dekuai" 2>/dev/null || true