<div align=center>

__DekuAI__<img width=40 height=40 src="https://user-images.githubusercontent.com/60609786/217486509-9049409e-ea4c-423b-ad64-af54ab91620b.png">
==========

![Version](https://img.shields.io/badge/Version-v0.3.0-F6AA16?style=flat-square&logo=python&logoColor=FFFFFF)
![Python](https://img.shields.io/badge/Python-3.8+-1B998B?style=flat-square&logo=python&logoColor=FFFFFF)
![Discord](https://img.shields.io/discord/1058828666362138765?style=flat-square&logo=discord)

__`Supported platforms`__

![os Android](https://img.shields.io/badge/Os-Android%20-1B998B?style=flat-square&logo=Android)
![os Linux](https://img.shields.io/badge/Os-Linux%20-1B998B?style=flat-square&logo=Linux)
![os MacOs](https://img.shields.io/badge/Os-macOS%20-1B998B?style=flat-square&logo=macOS)
![os Windows](https://img.shields.io/badge/Os-Windows(WSL)%20-1B998B?style=flat-square&logo=windows)

***

<img width=280 height=280 align="right" src="https://user-images.githubusercontent.com/60609786/217484128-764c7cdb-8027-4a94-9803-31727e70af13.gif#gh-dark-mode-only">

__DekuAI__ is a powerful CLI tool for AI models from multiple providers. Chat with GPT, Claude, Gemini, and many open-source models directly in your terminal.

Built with Python for cross-platform support and a better developer experience while keeping the simple `dekuai` command.


__Features__

| Feature | Description |
|---------|-------------|
| **40+ Models** | GPT, Claude, Gemini, Qwen, MiniMax, and more |
| **Streaming** | Real-time response output |
| **Interactive Chat** | Switch models mid-conversation |
| **Image Generation** | DALL-E 3 support |


__Quick Start__

```bash
# Clone and install
git clone https://github.com/Hishantik/openAI-shell-cli
cd openAI-shell-cli
pip install -e .

# Start chatting
dekuai chat

# Or ask a single question
dekuai ask "Hello, how are you?"

# List all models
dekuai models
```

</div>

___

#### **Table of contents**

+ [Prerequisites](#prerequisites)
+ [Installation](#installation)
+ [Usage](#usage)
+ [Models](#models)
+ [Configuration](#configuration)
+ [Uninstall](#uninstall)
+ [Contributing](#contributing)
+ [License](#license)


**Getting Started**
-------------------

#### **Prerequisites**

+ **Python 3.8+**
+ **API Key** (optional - many models work without one via opencode.ai)

#### **Installation**

```bash
git clone https://github.com/Hishantik/openAI-shell-cli
cd openAI-shell-cli
pip install -e .
```

##### **Platform-specific**

| Platform | Command |
|----------|---------|
| **Android (Termux)** | `pkg install python -y && pip install -e .` |
| **Linux** | `sudo apt install python3 python3-pip -y && pip install -e .` |
| **macOS** | `brew install python3 && pip install -e .` |
| **Windows (WSL)** | Install WSL, then `pip install -e .` |

***

#### **Usage**

```bash
# Interactive chat
dekuai chat

# Single question
dekuai ask "What is Python?"

# Specify model
dekuai chat --model claude-opus-4-7
dekuai ask "Explain quantum physics" --model gemini-3.1-pro

# Image generation
dekuai generate "A beautiful sunset over mountains"

# List models
dekuai models

# Configuration
dekuai configure          # Show current config
dekuai setconfig -m gpt-5  # Change default model
```

##### **Chat Commands**

Inside the chat interface:

| Command | Description |
|---------|-------------|
| `models` | List all available models |
| `model <name>` | Switch to a different model |
| `exit` | Quit the chat |

***

#### **Models**

DekuAI supports 40+ models from multiple providers:

##### **GPT Models**
| Model ID | Name |
|----------|------|
| `gpt-5` | GPT 5 |
| `gpt-5.5` | GPT 5.5 |
| `gpt-5.4` | GPT 5.4 |
| `gpt-5.4-pro` | GPT 5.4 Pro |
| `gpt-5.4-mini` | GPT 5.4 Mini |
| `gpt-5.4-nano` | GPT 5.4 Nano |
| `gpt-5.3-codex` | GPT 5.3 Codex |
| `gpt-5.2` | GPT 5.2 |
| `gpt-4` | GPT 4 |
| `gpt-3.5-turbo` | GPT 3.5 Turbo |

##### **Claude Models**
| Model ID | Name |
|----------|------|
| `claude-opus-4-7` | Claude Opus 4.7 |
| `claude-opus-4-6` | Claude Opus 4.6 |
| `claude-sonnet-4-6` | Claude Sonnet 4.6 |
| `claude-sonnet-4` | Claude Sonnet 4 |
| `claude-haiku-4-5` | Claude Haiku 4.5 |
| `claude-3-5-haiku` | Claude Haiku 3.5 |

##### **Gemini Models**
| Model ID | Name |
|----------|------|
| `gemini-3.1-pro` | Gemini 3.1 Pro |
| `gemini-3-flash` | Gemini 3 Flash |

##### **Open Source Models**
| Model ID | Name | Provider |
|----------|------|----------|
| `qwen3.6-plus` | Qwen 3.6 Plus | OpenAI-compatible |
| `qwen3.5-plus` | Qwen 3.5 Plus | OpenAI-compatible |
| `minimax-m2.7` | MiniMax M2.7 | OpenAI-compatible |
| `minimax-m2.5-free` | MiniMax M2.5 Free | OpenAI-compatible |
| `glm-5.1` | GLM 5.1 | OpenAI-compatible |
| `kimi-k2.6` | Kimi K2.6 | OpenAI-compatible |
| `big-pickle` | Big Pickle | OpenAI-compatible |
| `ring-2.6-1t-free` | Ring 2.6 1T | OpenAI-compatible |
| `nemotron-3-super-free` | Nemotron 3 Super Free | OpenAI-compatible |

Use `dekuai models` to see the full list.

***

#### **Configuration**

**Config file**: `~/.config/dekuai/config.toml`

```toml
model = "gpt-3.5-turbo"
max_tokens = 4000
temperature = 0.7
base_url = "https://opencode.ai/zen/v1"
```

**Environment variables**:
```bash
export OPENAI_API_KEY=your_key_here
export DEKUAI_BASE_URL=https://opencode.ai/zen/v1
```

Or use CLI commands:
```bash
dekuai auth                    # Set API key
dekuai setconfig -m gpt-5      # Set default model
dekuai setconfig -t 8000        # Set max tokens
```

***

#### **Uninstall**

```bash
pip uninstall dekuai
rm -rf ~/.config/dekuai
```

---

#### Contributing

Pull requests are welcome! Please open an issue first to discuss changes.

If you have any issues, [**join our Discord server**](https://discord.gg/dgJAesCnQ5)


<div align=center>

[![Discord Server](http://invidget.switchblade.xyz/dgJAesCnQ5)](https://discord.gg/dgJAesCnQ5)

</div>

***

### License

```
copyright © 2024 DekuAI open source project

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

***

### Credits

<div align=center>

*People who have contributed on DekuAI.*
</div>

<div align=center>
<a href="https://github.com/Hishantik/openAI-shell-cli/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=Hishantik/openAI-shell-cli" />
</a>
</div>