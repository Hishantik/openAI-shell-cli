# dekuai

Modern CLI tool for OpenAI's GPT and DALL-E models.

## Installation

```bash
# From source
pip install -e .

# Or use the installer
./install-python.sh
```

## Quick Start

1. Authenticate:
```bash
dekuai auth
```

2. Chat with GPT:
```bash
dekuai chat
```

3. Generate images:
```bash
dekuai generate "A cute cat astronaut"
```

## Commands

- `dekuai auth` - Store your OpenAI API key
- `dekuai chat` - Interactive GPT chat
- `dekuai generate <prompt>` - Generate DALL-E images
- `dekuai configure` - Show current config
- `dekuai --help` - All options

## Configuration

Config is stored at `~/.config/dekuai/config.toml`

Or use environment variable:
```bash
export OPENAI_API_KEY=your_key_here
```