#!/bin/bash
set -e

VERSION="0.4.0"
REPO="Hishantik/openAI-shell-cli"
INSTALL_DIR="${HOME}/.local/bin"
BINARY_NAME="dekuai"

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

info() { echo -e "${GREEN}==>${NC} $1"; }
warn() { echo -e "${YELLOW}==>${NC} $1"; }
error() { echo -e "${RED}==>${NC} $1"; }

# Detect OS
OS=$(uname -s)
case "$OS" in
    Linux*) INSTALL_DIR="/usr/local/bin";;
    Darwin*) INSTALL_DIR="/usr/local/bin";;
    *) error "Unsupported OS: $OS"; exit 1;;
esac

# Print help
show_help() {
    echo "DekuAI Installer v${VERSION}"
    echo ""
    echo "Usage: ./install.sh [command]"
    echo ""
    echo "Commands:"
    echo "  install     Install dekuai (default)"
    echo "  uninstall   Remove dekuai from system"
    echo "  help        Show this help message"
    echo ""
}

# Uninstall
do_uninstall() {
    info "Uninstalling DekuAI..."

    removed=0

    # Check common installation paths
    for path in "/usr/local/bin/dekuai" "${HOME}/.local/bin/dekuai" "${HOME}/bin/dekuai"; do
        if [ -f "$path" ]; then
            if rm "$path" 2>/dev/null; then
                info "Removed: $path"
                removed=1
            fi
        fi
    done

    # Clean config
    config_dir="${HOME}/.config/dekuai"
    if [ -d "$config_dir" ]; then
        rm -rf "$config_dir"
        info "Removed config: $config_dir"
    fi

    if [ $removed -eq 0 ]; then
        warn "Could not find dekuai installation."
        echo "Try removing manually:"
        echo "  - /usr/local/bin/dekuai"
        echo "  - ~/.local/bin/dekuai"
        echo "  - ~/.config/dekuai"
    else
        info "DekuAI has been uninstalled!"
    fi
}

# Install
do_install() {
    info "Installing DekuAI v${VERSION}..."

    # Check for Go
    if ! command -v go &> /dev/null; then
        error "Go is not installed. Please install from: https://go.dev/doc/install"
        exit 1
    fi

    # Get script directory
    SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

    # Check if we're in the repo directory
    if [ -f "$SCRIPT_DIR/main.go" ] && [ -f "$SCRIPT_DIR/go.mod" ]; then
        info "Building from local source..."
        cd "$SCRIPT_DIR"
        go build -o "$BINARY_NAME" .

        if [ "$SCRIPT_DIR" = "/usr/local/bin" ]; then
            sudo cp "$BINARY_NAME" "$INSTALL_DIR/"
        else
            mkdir -p "$INSTALL_DIR"
            cp "$BINARY_NAME" "$INSTALL_DIR/"
        fi
    else
        # Build from source via git clone
        info "Building from source..."

        TMP_DIR=$(mktemp -d)
        cd "$TMP_DIR"

        info "Cloning repository..."
        git clone --depth 1 https://github.com/${REPO} dekuai-src
        cd dekuai-src

        info "Building binary..."
        go build -o "$BINARY_NAME" .

        mkdir -p "$INSTALL_DIR"
        if [ "$INSTALL_DIR" = "/usr/local/bin" ]; then
            sudo cp "$BINARY_NAME" "$INSTALL_DIR/"
        else
            cp "$BINARY_NAME" "$INSTALL_DIR/"
        fi

        chmod +x "${INSTALL_DIR}/${BINARY_NAME}"

        rm -rf "$TMP_DIR"
    fi

    # Add to PATH if needed
    if [[ ":$PATH:" != *":$INSTALL_DIR:"* ]]; then
        warn "Add $INSTALL_DIR to your PATH if not already there."
    fi

    info "Installed successfully to ${INSTALL_DIR}/${BINARY_NAME}"
    info "Run 'dekuai' to start."
    info "Run 'dekuai --uninstall' to remove."
}

# Main
case "${1:-install}" in
    install)
        do_install
        ;;
    uninstall)
        do_uninstall
        ;;
    help|--help|-h)
        show_help
        ;;
    *)
        error "Unknown command: $1"
        show_help
        exit 1
        ;;
esac