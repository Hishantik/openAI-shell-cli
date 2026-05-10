#!/bin/bash
# DekuAI Installer v0.4.0
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
detect_os() {
    OS=$(uname -s)
    ARCH=$(uname -m)
    case "$OS" in
        Linux*)
            if [ "$ARCH" = "x86_64" ]; then
                FILENAME="dekuai-linux-amd64"
            elif [ "$ARCH" = "aarch64" ] || [ "$ARCH" = "arm64" ]; then
                FILENAME="dekuai-linux-arm64"
            else
                error "Unsupported architecture: $ARCH"
                exit 1
            fi
            INSTALL_DIR="/usr/local/bin"
            ;;
        Darwin*)
            if [ "$ARCH" = "x86_64" ]; then
                FILENAME="dekuai-darwin-amd64"
            elif [ "$ARCH" = "arm64" ]; then
                FILENAME="dekuai-darwin-arm64"
            fi
            INSTALL_DIR="/usr/local/bin"
            ;;
        *)
            error "Unsupported OS: $OS"
            exit 1
            ;;
    esac
}

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

    detect_os

    URL="https://github.com/${REPO}/releases/download/v${VERSION}/${FILENAME}"

    # Get script directory to check for local source
    SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

    # Check if we're in the repo directory with source
    if [ -f "$SCRIPT_DIR/main.go" ] && [ -f "$SCRIPT_DIR/go.mod" ]; then
        info "Building from local source..."
        cd "$SCRIPT_DIR"
        go build -ldflags="-s -w" -o "$BINARY_NAME" .

        if [ "$SCRIPT_DIR" = "/usr/local/bin" ]; then
            sudo cp "$BINARY_NAME" "$INSTALL_DIR/"
            sudo chmod +x "${INSTALL_DIR}/${BINARY_NAME}"
        else
            mkdir -p "$INSTALL_DIR"
            cp "$BINARY_NAME" "$INSTALL_DIR/"
            chmod +x "${INSTALL_DIR}/${BINARY_NAME}"
        fi
    else
        # Download pre-built binary
        info "Downloading ${FILENAME}..."

        TMP_DIR=$(mktemp -d)
        cd "$TMP_DIR"

        if command -v curl &> /dev/null; then
            curl -fSL "$URL" -o "$BINARY_NAME" || {
                error "Failed to download. Please check if v${VERSION} release exists."
                rm -rf "$TMP_DIR"
                exit 1
            }
        elif command -v wget &> /dev/null; then
            wget -q "$URL" -O "$BINARY_NAME" || {
                error "Failed to download. Please check if v${VERSION} release exists."
                rm -rf "$TMP_DIR"
                exit 1
            }
        fi

        mkdir -p "$INSTALL_DIR"
        if [ "$INSTALL_DIR" = "/usr/local/bin" ]; then
            sudo cp "$BINARY_NAME" "$INSTALL_DIR/"
            sudo chmod +x "${INSTALL_DIR}/${BINARY_NAME}"
        else
            cp "$BINARY_NAME" "$INSTALL_DIR/"
            chmod +x "${INSTALL_DIR}/${BINARY_NAME}"
        fi

        rm -rf "$TMP_DIR"
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