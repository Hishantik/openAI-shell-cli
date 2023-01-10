<div align=center>
<font size=14>

**DekuAI-cli-tool**
</font>

![prs are welcome](https://img.shields.io/badge/Prs-Welcome%20-588157)
![os Android](https://img.shields.io/badge/Os-Android%20-588157?logo=Android)
![os Linux](https://img.shields.io/badge/Os-Linux%20-588157?logo=Linux)
![os MacOs](https://img.shields.io/badge/Os-macOS%20-588157?logo=macOS)
![os Windows](https://img.shields.io/badge/Os-Windows%20-588157?logo=windows)

***

<font size=4>

*An interactive & simple openai chatgpt based cli tool without installing any python or node.js modules.This tool uses `davinci-003` & `completion` endpoint to scrape data through [OpenAI api](https://openai.com/api/)*.

</font>
<font size=7>

**Showcase**
</font>

<img width=80% height=450 src="https://user-images.githubusercontent.com/60609786/210131672-19fbf2ae-c893-4354-8fba-7c9ff3cbdb02.gif"> 
</div>

***


### **Table of contents**

<font size=4>

- [Prerequisites](#prerequisites)
- [Installation](#installation)
   - [Android](#android)
   - [Linux](#linux)
      - [Debian](#debian)
   - [macOS](#macos)
   - [Windows](#windows)
- [Usage](#usage)
- [Uninstall](#uninstall)
- [Dependencies](#dependencies)
- [Contributing](#contributing)
- [License](#license)
- [Credits](#credits)
</font>

<font size=10>

**Getting Started**
</font>

### **Prerequisites**

<font size=2>

This cli tool highly depends on `curl` for request to api & `jq` to parse the json response.

- **OpenAI API key** is required.Create an OpenAI account and get free api key from [OpenAI](https://beta.openai.com/account/api-keys).
</font>

***

### **Installation**

<font size=2>

**Note :** After running installation command it will prompt you to enter openAI api key, enter your api key when prompted.
</font>

## **Android**

<font size=2>

Install termux [(guide)](https://termux.dev/en/)
</font>

**Termux package**
 
    pkg install curl -y

then
    
    curl -sS https://raw.githubusercontent.com/Hishantik/OpenAI-shell-cli/main/install.sh -o install && bash install && rm install

## Linux
#### Debian
    
     sudo apt update
     sudo apt install wget

 then    
     
     wget -qO- https://hishantik.github.io/dekuai-cli-ppa/KEY.gpg | sudo tee /etc/apt/trusted.gpg.d/dekuai-cli.asc
     wget -qO- https://hishantik.github.io/dekuai-cli-ppa/dekuai-cli-debian.list | sudo tee /etc/apt/sources.list.d/dekuai-cli-debian.list
     sudo apt update
     sudo apt install dekuai-cli
    
## macOS

<font size=2>

Install the dependencies required [(see below)](#dependencies).

Install [Homebrew](https://docs.brew.sh/Installation) if not installed.

To install dependencies required on macOS using homebrew run :
</font>
 
    brew install curl awk jq git

then from source
   
    git clone "https://github.com/Hoshantik/openAI-shell-cli" && cd ./openAI-shell-cli
    mv ./dekuai.sh "$(brew --prefix)"/bin/dekuai
    chmod +x "$(brew --prefix)/bin/dekuai"


## Windows

<font size=2>

To make it work with Windows you must install and configure WSL with debian based linux (ubuntu) in windows after complete installation of wsl 
run below command on shell
</font>

      apt-get upgrade && apt-get update
      apt-get install git curl jq 

then from source

      git clone "https://github.com/Hoshantik/openAI-shell-cli" && cd ./openAI-shell-cli
      mv ./dekuai.sh "$(brew --prefix)"/bin/dekuai
      chmod +x "$(brew --prefix)/bin/dekuai"
 
     
     

***
### **Usage**

<font size=2>

Simply run **dekuai** anywhere in the shell prompt

</font>

    dekuai
    

***
### **Uninstall**

<font size=2>

To uninstall ***(DekuAI)*** run below command in the shell prompt 

</font>
    
    dekuai -u

***

### Dependencies

- curl
- awk
- jq

***

### Contributing

<font size=2>

Pull request are welcome. To add some feature or changes please open an issue first to discuss what changes you would like to add.

- [Contribution guide](./CONTRIBUTING.md)
    
If you have any questions regarding the project , [**join our discord server**](https://discord.gg/dgJAesCnQ5)
</font>




[![Discord Server](http://invidget.switchblade.xyz/dgJAesCnQ5)](https://discord.gg/dgJAesCnQ5)



***

### License
    
    copyright © 2022 DekuAI open source project

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
    SOFTWARE.


***

### Credits

<div align=center>
<font size=2>

*A special thanks to the people who have contributed to this project.*
</font>
</div>

<div align=center>
<a href="https://github.com/Hishantik/openAI-shell-cli/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=Hishantik/openAI-shell-cli" />
</a>
</div>

