#!/bin/bash
# DekuAI Python Installer

set -e

echo "Installing DekuAI v0.2.0..."

# Check Python version
if ! command -v python3 &> /dev/null; then
    echo "Error: Python 3 is not installed."
    echo "Install it with: sudo apt install python3 python3-pip"
    exit 1
fi

PYTHON_VERSION=$(python3 -c 'import sys; print(f"{sys.version_info.major}.{sys.version_info.minor}")')
REQUIRED_VERSION="3.8"
if [ "$(printf '%s\n' "$REQUIRED_VERSION" "$PYTHON_VERSION" | sort -V | head -n1)" != "$REQUIRED_VERSION" ]; then
    echo "Error: Python 3.8+ is required. Found: $PYTHON_VERSION"
    exit 1
fi

# Create venv or install
if [ -d ".venv" ]; then
    echo "Using existing virtual environment..."
    source .venv/bin/activate
else
    echo "Creating virtual environment..."
    python3 -m venv .venv
    source .venv/bin/activate
fi

# Install package
echo "Installing dekuai..."
pip install -e .

echo "Installation complete!"
echo ""
echo "Run 'dekuai auth' to set your OpenAI API key"
echo "Run 'dekuai --help' for usage information"