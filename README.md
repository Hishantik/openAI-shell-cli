# dekuai

<img width=40 height=40 src="https://user-images.githubusercontent.com/60609786/217486509-9049409e-ea4c-423b-ad64-af54ab91620b.png">

A modern TUI-based AI CLI tool powered by [Bubble Tea](https://github.com/charmbracelet/bubbletea) from the Charm ecosystem.

![Go](https://img.shields.io/badge/Go-1.21+-00ADD8?style=flat-square&logo=go&logoColor=FFFFFF)
![Platform](https://img.shields.io/badge/Platform-Linux%20|%20macOS%20|%20Windows-1B998B?style=flat-square)

## Features

- **40+ AI Models** - GPT, Claude, Gemini, Qwen, MiniMax, and more
- **Interactive TUI** - Beautiful terminal interface using Bubble Tea
- **Real-time Responses** - Streaming support for instant feedback
- **Model Switching** - Change models mid-conversation with keyboard shortcuts

## Installation

```bash
# Clone the repository
git clone https://github.com/Hishantik/openAI-shell-cli
cd openAI-shell-cli

# Build
go build -o dekuai .

# Run
./dekuai
```

## Usage

```
╭─ DekuAI ─────────────────────────────────────────╮
│  press m → menu  •  esc/ctrl+c → quit           │
╰─────────────────────────────────────────────────╯
│ Model: GPT 5.5

You: What is Python?

DekuAI: Python is a high-level programming language...

Ask: _
```

### Keyboard Shortcuts

| Key | Action |
|-----|--------|
| `m` | Open model menu |
| `↑/k` | Navigate up |
| `↓/j` | Navigate down |
| `enter` | Select / Send |
| `esc` | Close menu |
| `ctrl+c` | Quit |

## Supported Models

### GPT Models
| Model | Name |
|-------|------|
| `gpt-5.5` | GPT 5.5 |
| `gpt-5` | GPT 5 |
| `gpt-5.4-pro` | GPT 5.4 Pro |
| `gpt-5.4-mini` | GPT 5.4 Mini |
| `gpt-4` | GPT 4 |
| `gpt-3.5-turbo` | GPT 3.5 Turbo |

### Claude Models
| Model | Name |
|-------|------|
| `claude-opus-4-7` | Claude Opus 4.7 |
| `claude-sonnet-4-6` | Claude Sonnet 4.6 |
| `claude-haiku-4-5` | Claude Haiku 4.5 |

### Gemini Models
| Model | Name |
|-------|------|
| `gemini-3.1-pro` | Gemini 3.1 Pro |
| `gemini-3-flash` | Gemini 3 Flash |

### Open Source Models
| Model | Name |
|-------|------|
| `qwen3.6-plus` | Qwen 3.6 Plus |
| `minimax-m2.5-free` | MiniMax M2.5 Free |
| `nemotron-3-super-free` | Nemotron 3 Super Free |

## Configuration

**API Key**: Set via environment variable
```bash
export OPENAI_API_KEY=your_key_here
```

## Tech Stack

Built with [Charm](https://charm.sh/) libraries:
- [Bubble Tea](https://github.com/charmbracelet/bubbletea) - TUI framework
- [Lipgloss](https://github.com/charmbracelet/lipgloss) - Styling

## License

MIT License - See [LICENSE](LICENSE)