#!/bin/bash
# DekuAI Build Script
set -e

VERSION="0.4.0"
REPO="Hishantik/openAI-shell-cli"
OUTPUT_DIR="releases"

info() { echo "==> $1"; }

# Create output directory
mkdir -p "$OUTPUT_DIR"

info "Building DekuAI v${VERSION}..."

# Linux AMD64
info "Building Linux AMD64..."
GOOS=linux GOARCH=amd64 go build -ldflags="-s -w" -o "${OUTPUT_DIR}/dekuai-linux-amd64" .
info "Linux AMD64: ${OUTPUT_DIR}/dekuai-linux-amd64"

# Linux ARM64
info "Building Linux ARM64..."
GOOS=linux GOARCH=arm64 go build -ldflags="-s -w" -o "${OUTPUT_DIR}/dekuai-linux-arm64" .
info "Linux ARM64: ${OUTPUT_DIR}/dekuai-linux-arm64"

# macOS AMD64
info "Building macOS AMD64..."
GOOS=darwin GOARCH=amd64 go build -ldflags="-s -w" -o "${OUTPUT_DIR}/dekuai-darwin-amd64" .
info "macOS AMD64: ${OUTPUT_DIR}/dekuai-darwin-amd64"

# macOS ARM64
info "Building macOS ARM64..."
GOOS=darwin GOARCH=arm64 go build -ldflags="-s -w" -o "${OUTPUT_DIR}/dekuai-darwin-arm64" .
info "macOS ARM64: ${OUTPUT_DIR}/dekuai-darwin-arm64"

# Windows AMD64
info "Building Windows AMD64..."
GOOS=windows GOARCH=amd64 go build -ldflags="-s -w" -o "${OUTPUT_DIR}/dekuai-windows-amd64.exe" .
info "Windows AMD64: ${OUTPUT_DIR}/dekuai-windows-amd64.exe"

info "All binaries built successfully!"

# Create release
if command -v gh &> /dev/null; then
    info "Creating GitHub release..."
    cd "$OUTPUT_DIR"

    gh release create "v${VERSION}" ./*.exe ./*-amd64 ./*-arm64 \
        --title "DekuAI v${VERSION}" \
        --notes "DekuAI v${VERSION} - TUI-based AI CLI with 40+ models

Features:
- 40+ AI models (GPT, Claude, Gemini, open source)
- Interactive TUI with Bubble Tea
- Model switching mid-conversation
- Built with Charm.sh libraries

Install: curl -fsSL https://raw.githubusercontent.com/${REPO}/main/install.sh | bash"
else
    info "gh CLI not found. Run manually:"
    echo "  cd $OUTPUT_DIR"
    echo "  gh release create v${VERSION} ./*.exe ./*-amd64 ./*-arm64"
fi

info "Done!"