<div align="center">

<img width="60" height="60" src="https://user-images.githubusercontent.com/60609786/217486509-9049409e-ea4c-423b-ad64-af54ab91620b.png">

# DekuAI

### The AI CLI That Feels Like Magic ✨

[![Go](https://img.shields.io/badge/Go-1.21+-00ADD8?style=for-the-badge&logo=go&logoColor=white)](https://go.dev/)
[![Platform](https://img.shields.io/badge/Platform-Linux%20|%20macOS%20|%20Windows-1B998B?style=for-the-badge&logo=linux&logoColor=white)
[![License](https://img.shields.io/badge/License-MIT-1B998B?style=for-the-badge)](LICENSE)

> Chat with GPT, Claude, Gemini, and 40+ AI models from your terminal

<img width="600" align="center" src="https://user-images.githubusercontent.com/60609786/217484128-764c7cdb-8027-4a94-9803-31727e70af13.gif#gh-dark-mode-only">

</div>

---

## 🚀 Quick Start

```bash
# One-liner installation
curl -fsSL https://raw.githubusercontent.com/Hishantik/openAI-shell-cli/main/install.sh | bash

# Or build from source
git clone https://github.com/Hishantik/openAI-shell-cli
cd openAI-shell-cli
go build -o dekuai .
./dekuai
```

## ⚡ Features

| Feature | Description |
|:--------|:------------|
| 🤖 **40+ Models** | GPT, Claude, Gemini, Qwen, MiniMax, and more |
| 🎨 **Beautiful TUI** | Built with Bubble Tea from Charm |
| ⚡ **Streaming** | Real-time responses as they generate |
| 🔄 **Switch Models** | Change models mid-conversation |
| 🌐 **Free Access** | Many models work without API keys |

## 🎮 Interactive Demo

```
╭────────────────────────────────────────────────────────────╮
│  🐒  DekuAI                              [ Model: GPT 5 ]  │
├────────────────────────────────────────────────────────────┤
│                                                            │
│  You: How do I learn Go?                                   │
│                                                            │
│  DekuAI: Here's a roadmap for learning Go:                 │
│          1. Start with Tour of Go                          │
│          2. Read "Go in Action"                           │
│          3. Build small projects                           │
│          4. Contribute to open source                     │
│                                                            │
│  Type 'm' to change model  •  'esc' to quit                │
├────────────────────────────────────────────────────────────┤
│  Ask: _                                                     │
╰────────────────────────────────────────────────────────────╯
```

## ⌨️ Keyboard Shortcuts

| Key | Action |
|:----|:-------|
| `m` | Open model selector menu |
| `↑` / `k` | Navigate up |
| `↓` / `j` | Navigate down |
| `Enter` | Select model / Send message |
| `Esc` | Close menu |
| `Ctrl+C` | Quit application |

## 🧠 Supported Models

<details>
<summary><b>Click to expand all models</b></summary>

### 🧠 GPT Models (OpenAI)
| Model | Name | Best For |
|:------|:----|:--------|
| `gpt-5.5` | GPT 5.5 | Most capable |
| `gpt-5` | GPT 5 | General purpose |
| `gpt-5.4-pro` | GPT 5.4 Pro | Advanced tasks |
| `gpt-4` | GPT 4 | Reasoning |
| `gpt-3.5-turbo` | GPT 3.5 | Fast & cheap |

### 🧠 Claude Models (Anthropic)
| Model | Name | Best For |
|:------|:----|:--------|
| `claude-opus-4-7` | Claude Opus 4.7 | Complex reasoning |
| `claude-opus-4-6` | Claude Opus 4.6 | Analysis |
| `claude-sonnet-4-6` | Claude Sonnet 4.6 | Balanced |
| `claude-haiku-4-5` | Claude Haiku 4.5 | Fast |
| `claude-3-5-haiku` | Claude 3.5 Haiku | Quick tasks |

### 🌟 Gemini Models (Google)
| Model | Name | Best For |
|:------|:----|:--------|
| `gemini-3.1-pro` | Gemini 3.1 Pro | Multimodal |
| `gemini-3-flash` | Gemini 3 Flash | Speed |

### 🦙 Open Source Models
| Model | Name | Provider |
|:------|:----|:--------|
| `qwen3.6-plus` | Qwen 3.6 Plus | Alibaba |
| `qwen3.5-plus` | Qwen 3.5 Plus | Alibaba |
| `minimax-m2.7` | MiniMax M2.7 | MiniMax |
| `minimax-m2.5-free` | MiniMax M2.5 Free | MiniMax |
| `glm-5.1` | GLM 5.1 | Zhipu |
| `kimi-k2.6` | Kimi K2.6 | Moonshot |
| `big-pickle` | Big Pickle | Unknown |
| `ring-2.6-1t-free` | Ring 2.6 1T | Free |
| `nemotron-3-super-free` | Nemotron 3 Super Free | NVIDIA |

</details>

## ⚙️ Configuration

```bash
# Set your API key (optional - many models work free!)
export OPENAI_API_KEY=sk-...

# Default settings
export DEKUAI_MODEL=gpt-5.5
export DEKUAI_BASE_URL=https://opencode.ai/zen/v1
```

Or use the built-in auth command:
```bash
dekuai auth
```

## 🛠️ Tech Stack

Built with [Charm.sh](https://charm.sh/) ✨

| Library | Purpose |
|:--------|:--------|
| [Bubble Tea](https://github.com/charmbracelet/bubbletea) | TUI Framework |
| [Lipgloss](https://github.com/charmbracelet/lipgloss) | Terminal Styling |

## 📦 Installation

### Linux / macOS
```bash
curl -fsSL https://raw.githubusercontent.com/Hishantik/openAI-shell-cli/main/install.sh | bash
```

### From Source
```bash
git clone https://github.com/Hishantik/openAI-shell-cli
cd openAI-shell-cli
go build -o dekuai .
sudo mv dekuai /usr/local/bin/
```

### Termux (Android)
```bash
pkg install golang -y
git clone https://github.com/Hishantik/openAI-shell-cli
cd openAI-shell-cli
go build -o dekuai .
./dekuai
```

## 🤝 Contributing

Contributions are welcome! Feel free to submit issues and pull requests.

[![Discord](https://img.shields.io/badge/Discord-Join-5865F2?style=flat-square&logo=discord&logoColor=white)](https://discord.gg/dgJAesCnQ5)

## 📄 License

MIT License - See [LICENSE](LICENSE)

---

<div align="center">

Made with ❤️ by [Hishantik](https://github.com/Hishantik)

</div>