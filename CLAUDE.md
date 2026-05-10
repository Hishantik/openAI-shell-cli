# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

DekuAI is a shell-based CLI tool that provides OpenAI GPT-3 text completion and DALL-E image generation via a TUI interface. It's written in POSIX shell and uses [gum](https://github.com/charmbracelet/gum) for the UI.

## Running the CLI

```bash
./dekuai.sh                    # Start interactive prompt
./dekuai.sh --menu             # Show menu options
./dekuai.sh --help             # Show help
./dekuai.sh --version          # Show version (v0.1.2)
./dekuai.sh --update           # Update to latest version
./dekuai.sh --uninstall        # Uninstall
```

## Architecture

- **Single main script**: `dekuai.sh` contains all logic (~490 lines)
- **Modular functions**: Authentication, menus, API calls, UI rendering are separate functions
- **Flow**: `checktoken` → main loop → `gum write` for input → curl API call → `gum style` for output
- **State**: Uses variables like `running` boolean to control loop; `QUESTION`/`RESPONSE` for user data

## Key Patterns

1. **Authentication**: Token stored in shell rc files (~/.zshrc, ~/.bashrc) as `OPENAI_TOKEN`
2. **API calls**: Uses `curl` to OpenAI endpoints with JSON payloads, `jq` for parsing responses
3. **UI styling**: All visual elements use `gum style` with hex colors (#1B998B green, #F6AA1C orange)
4. **Terminal sizing**: `WIDTH=$(tput cols)` for responsive layout

## Dependencies

Required tools (must be installed): `curl`, `jq`, `gum`, `glow`, `awk`, `grep`

## API Configuration

- Model: `text-davinci-003` for completions
- Endpoints: `/v1/completions` (text), `/v1/images/generations` (DALL-E)
- Max tokens: 4000, Temperature: 0.7

## Style Conventions

- Color scheme: teal (#1B998B), orange (#F6AA1C), yellow (#FFB703)
- Monkey emoji (🐒🐵🙈) used throughout for branding
- Functions use camelCase naming