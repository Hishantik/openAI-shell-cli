# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

DekuAI is a TUI-based CLI tool for AI models from multiple providers. Built with Go using the Charm ecosystem (Bubble Tea, Lipgloss).

## Running the CLI

```bash
go build -o dekuai .    # Build
./dekuai                 # Run (requires terminal)
```

## Architecture

- **Single main file**: `main.go` contains all TUI logic
- **Framework**: Bubble Tea for TUI, Lipgloss for styling
- **Models**: Array of `AIModel` structs with ID, Name, Endpoint
- **State**: `model` struct holds messages, input, loading, menu state

## Key Patterns

1. **Model Selection**: Press `m` to open menu, navigate with `↑↓`, select with `enter`
2. **API Calls**: HTTP POST to different endpoints based on model type
3. **Concurrent Requests**: API calls run in goroutines to not block TUI

## Style System

Using Lipgloss with brand colors:
- `#F6AA1C` - Orange (brand)
- `#1B998B` - Teal (primary)
- `#83C5BE` - Light teal (answers)
- `#6B7280` - Gray (dim text)

## Supported Models

40+ models from opencode.ai/zen endpoints:
- GPT models (5.x, 4, 3.5-turbo)
- Claude models (Opus, Sonnet, Haiku)
- Gemini models
- Open source: Qwen, MiniMax, Nemotron, etc.

## Environment

```bash
export OPENAI_API_KEY=your_key_here  # Optional for opencode.ai endpoints
```