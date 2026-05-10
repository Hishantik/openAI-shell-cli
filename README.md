<div align=center>

__DekuAI__<img width=40 height=40 src="https://user-images.githubusercontent.com/60609786/217486509-9049409e-ea4c-423b-ad64-af54ab91620b.png">
==========

<!-- ![prs are welcome](https://img.shields.io/badge/Prs-Welcome%20-588157) -->


![Version](https://img.shields.io/badge/Version-v0.2.0-F6AA16?style=flat-square&logo=python&logoColor=FFFFFF)
![Python](https://img.shields.io/badge/Python-3.8+-1B998B?style=flat-square&logo=python&logoColor=FFFFFF)
![Discord](https://img.shields.io/discord/1058828666362138765?style=flat-square&logo=discord)

__`Supported platforms`__

![os Android](https://img.shields.io/badge/Os-Android%20-1B998B?style=flat-square&logo=Android)
![os Linux](https://img.shields.io/badge/Os-Linux%20-1B998B?style=flat-square&logo=Linux)
![os MacOs](https://img.shields.io/badge/Os-macOS%20-1B998B?style=flat-square&logo=macOS)
![os Windows](https://img.shields.io/badge/Os-Windows(WSL)%20-1B998B?style=flat-square&logo=windows)

***


<img width=280 height=280 align="right" src="https://user-images.githubusercontent.com/60609786/217484128-764c7cdb-8027-4a94-9803-31727e70af13.gif#gh-dark-mode-only">

__DekuAI__ is a modern CLI tool for OpenAI's GPT and DALL-E models. It provides interactive chat with streaming responses and image generation directly in your terminal.

Built with Python for cross-platform support and a better developer experience while keeping the simple `dekuai` command.


__Features__

| Feature | Description |
|---------|-------------|
| **GPT Chat** | Interactive chat with streaming responses using GPT-3.5-turbo |
| **DALL-E** | Generate images from text prompts |
| **Streaming** | Real-time response output |
| **Config** | TOML-based configuration |


__Quick Start__

```bash
# Install
pip install -e .

# Authenticate
dekuai auth

# Chat
dekuai chat

# Generate images
dekuai generate "A cute cat astronaut"
```

</div>

___

#### **Table of contents**

+ [Prerequisites](#prerequisites)
+ [Installation](#installation)
   - [Python (Recommended)](#python)
   - [Shell (Legacy)](#shell-legacy)
   - [Android](#android)
   - [Linux](#linux)
   - [macOS](#macos)
   - [Windows](#windows)
+ [Usage](#usage)
+ [Configuration](#configuration)
+ [Uninstall](#uninstall)
+ [Contributing](#contributing)
+ [License](#license)


**Getting Started**
-------------------

#### **Prerequisites**

+ **Python 3.8+** - Required for the new Python CLI
+ **OpenAI API Key** - Get one at [platform.openai.com](https://platform.openai.com/api-keys)

#### **Installation**

##### **Python (Recommended)**

```bash
# Install from source
pip install -e .

# Or use the installer
./install-python.sh
```

##### **Shell (Legacy)**

For the legacy shell version:

```shell
sh -c "$(curl -fsSL https://raw.githubusercontent.com/hishantik/OpenAI-shell-cli/main/install.sh)"
```

##### **Android**

Install [Termux](https://termux.dev/en/) first, then:

```shell
pkg install python -y
sh -c "$(curl -fsSL https://raw.githubusercontent.com/hishantik/OpenAI-shell-cli/main/install-python.sh)"
```

##### **Linux (Debian/Ubuntu)**

```shell
sudo apt install python3 python3-pip -y
git clone https://github.com/Hishantik/openAI-shell-cli
cd openAI-shell-cli
pip install -e .
```

##### **macOS**

```shell
brew install python3
git clone https://github.com/Hishantik/openAI-shell-cli
cd openAI-shell-cli
pip install -e .
```

##### **Windows**

Install [WSL](https://docs.microsoft.com/en-us/windows/wsl/) with Ubuntu, then:

```shell
sudo apt install python3 python3-pip
git clone https://github.com/Hishantik/openAI-shell-cli
cd openAI-shell-cli
pip install -e .
```

***

#### **Usage**

```bash
dekuai auth         # Store your OpenAI API key
dekuai chat         # Start interactive GPT chat
dekuai generate "A cute cat"  # Generate DALL-E images
dekuai configure    # Show current configuration
dekuai --help       # All available options
```

<details>
<summary>Command Options</summary>

| Command | Description |
|---------|-------------|
| `dekuai auth` | Store your OpenAI API key |
| `dekuai chat` | Interactive GPT chat with streaming |
| `dekuai generate <prompt>` | Generate DALL-E images |
| `dekuai generate "prompt" -n 2 -s 512x512` | Multiple images, custom size |
| `dekuai configure` | Show current config |
| `dekuai --version` | Show version |
| `dekuai --help` | Help |

</details>

***

#### **Configuration**

**Config file**: `~/.config/dekuai/config.toml`

**Environment variable**:
```bash
export OPENAI_API_KEY=your_key_here
```

Or use `dekuai auth` to securely store your key.

***

#### **Uninstall**

```bash
pip uninstall dekuai
rm -rf ~/.config/dekuai
```

---

#### Contributing

Pull requests are welcome! Please open an issue first to discuss changes.

+ [Contribution guide](./CONTRIBUTING.md)

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