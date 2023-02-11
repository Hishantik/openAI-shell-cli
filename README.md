<div align=center>


__DekuAI__<img width=40 height=40 src="https://user-images.githubusercontent.com/60609786/217486509-9049409e-ea4c-423b-ad64-af54ab91620b.png">
==========

<!-- ![prs are welcome](https://img.shields.io/badge/Prs-Welcome%20-588157) -->


![Version](https://img.shields.io/badge/Version-v0.1.2-F6AA16?style=flat-square&logo=gnubash&logoColor=FFFFFF)
![Version](https://img.shields.io/badge/🐵_Prs-welcome-1B998B?style=flat-square)
![Discord](https://img.shields.io/discord/1058828666362138765?style=flat-square&logo=discord)

__`Supported platforms`__

![os Android](https://img.shields.io/badge/Os-Android%20-1B998B?style=flat-square&logo=Android)
![os Linux](https://img.shields.io/badge/Os-Linux%20-1B998B?style=flat-square&logo=Linux)
![os MacOs](https://img.shields.io/badge/Os-macOS%20-1B998B?style=flat-square&logo=macOS)
![os Windows](https://img.shields.io/badge/Os-Windows(WSL)%20-1B998B?style=flat-square&logo=windows)

***



<img width=280 height=280 align="right" src="https://user-images.githubusercontent.com/60609786/217484128-764c7cdb-8027-4a94-9803-31727e70af13.gif#gh-dark-mode-only">
<!-- <img width=300 height=300 align="right" src="https://user-images.githubusercontent.com/60609786/217485106-a61424a8-feef-4d2f-9a73-4cf96cd5c262.gif#gh-light-mode-only"> -->

__Generate response from `openai GPT-3 model` given any text prompt it will try to return a text completion in simple and concise format.__

_DekuAI saves your time providing you a feature similar to [chatGPT](https://chat.openai.com/chat) in your terminal. It is an interactive AI based ~~CLI~~ tool with the power of TUI that provides you a general purpose `"text-in,text-out"` interface in your terminal. It uses gpt-3 model `text-davinci-003` & `completion` endpoint which is very powerful interface that attempts to match whatever context or pattern you gave it to extract data using [OpenAI api](https://openai.com/api/).
For example if you give the API the prompt "As Descartes said, I think, therefore", it will return the completion " I am" with high probability._


__Native Support__

| supported platforms | completion             |      dalle         |
|:--------------------|:----------------------:|-------------------:|
| _Android (Termux)_  |  :heavy_check_mark:    |:heavy_check_mark:  |             
| _Linux (Debian)_    |  :heavy_check_mark:    |:heavy_check_mark:  |             
|_Linux (Archlinux)_  |            :x:         | :x:                |
| _Mac Os (iterm)_    |    :heavy_check_mark:  |    :x: (comming soon)|
| _Windows (WSL)_     |  :heavy_check_mark:    |   :x:              |
| ____________________|________________        |_______________


**Showcase**
------------

https://user-images.githubusercontent.com/60609786/217540475-a69c759f-01dc-40bf-b318-5b870262cc18.webm


<details>
<summary>snapshots</summary>



1. Auth Section

![Screenshot from 2023-02-08 18-51-18](https://user-images.githubusercontent.com/60609786/217542748-690bc649-b5a0-4e6d-ac33-8d1600b6f849.png)

2. Prompt Section

![Screenshot from 2023-02-08 18-53-22](https://user-images.githubusercontent.com/60609786/217543293-99108fbb-7ed5-4b41-8b3e-51a204080851.png)

3. Output Section

![Screenshot from 2023-02-08 19-02-46](https://user-images.githubusercontent.com/60609786/217545058-feacc2c0-cb2e-4721-a4e7-9d804f327f1f.png)

</details>



</div>

___


#### **Table of contents**


+ [Prerequisites](#prerequisites)
+ [Installation](#installation)
   - [Android](#android)
   - [Linux](#linux)
      * [Debian](#debian)
   - [macOS](#macos)
   - [Windows](#windows)
+ [Usage](#usage)
+ [Uninstall](#uninstall)
+ [Dependencies](#dependencies)
+ [Contributing](#contributing)
+ [License](#license)
+ [Credits](#credits)



**Getting Started**
-------------------

#### **Prerequisites**



DekuAI uses packages such as `curl` for request to api , `jq` to parse the json data, `gum` for interface, `awk` to interpret the pattern of string & `grep` to search for text within the file.

+ To use DeuAI **Openai API key token** is required. Create an OpenAI account and obatain api key token from [Openai](https://beta.openai.com/account/api-keys).
</font>

___

#### **Installation**


**Note :** *If it throw any common error while installing such as **(permission denied)**,then try to run install script using sudo command. After sucessful installation, enter your api key when prompted.*

#### **Android**


Install termux **[(guide)](https://termux.dev/en/)**


**Termux package**

~~~shell
pkg install curl -y
~~~ 


then



~~~shell
sh -c "$(curl -fsSL https://raw.githubusercontent.com/hishantik/OpenAI-shell-cli/main/install.sh)"
~~~

#### Linux

##### Debian

**from source** 

~~~shell
sudo apt install curl -y    
~~~

then

~~~shell
sudo sh -c "$(curl -fsSL https://raw.githubusercontent.com/hishantik/OpenAI-shell-cli/main/install.sh)"
~~~

**Using package manager**

~~~shell
sudo apt update && apt install wget -y 
~~~

 then    

 ~~~shell
wget -qO- https://hishantik.github.io/dekuai-cli-ppa/KEY.gpg | sudo tee /etc/apt/trusted.gpg.d/dekuai-cli.asc
wget -qO- https://hishantik.github.io/dekuai-cli-ppa/dekuai-cli-debian.list | sudo tee /etc/apt/sources.list.d/dekuai-cli-debian.list
sudo apt update
sudo apt install dekuai-cli
~~~    
    


#### macOS



Install the dependencies required [(see below)](#dependencies).

Install [Homebrew](https://docs.brew.sh/Installation) if not installed.

To install dependencies required on macOS using homebrew run :

 ~~~shell
 brew install curl
 ~~~

then
**from source**

~~~shell
sh -c "$(curl -fsSL https://raw.githubusercontent.com/hishantik/OpenAI-shell-cli/main/install.sh)"
~~~
  

#### Windows


To make it work with Windows you must install and configure WSL with debian based linux (ubuntu) in windows after complete installation of wsl 
run below command on shell

~~~shell
 sudo apt-get upgrade && apt-get update
 sudo apt-get install curl 
~~~

then **from source**

~~~shell
sudo sh -c "$(curl -fsSL https://raw.githubusercontent.com/hishantik/OpenAI-shell-cli/main/install.sh)"
 ~~~
 
     
     

***
#### **Usage**


Simply run **dekuai** anywhere in the shell prompt


~~~shell
 dekuai
~~~

or to see more options type

~~~shell
dekuai --menu
~~~

<details>
<summary>Keybinds</summary>

|   binds    |    description   |
|------------|------------------|
| <kbd>-m</kbd> or <kbd>--mmenu</kbd> | to see more features and options |
|    <kbd>-v</kbd> or  <kbd>--version</kbd>     |shows current version|
|<kbd>-h</kbd> or <kbd>--help</kbd> |shows help text|
|<kbd>-U</kbd> or <kbd>--update</kbd>|update to newest version available|
|<kbd>-u</kbd> or <kbd>--uninstall</kbd>|To uninstall the cli|

</details>

___

#### **Uninstall**


To uninstall ***(DekuAI)*** run below command in the shell prompt 

</font>
    
~~~shell
 dekuai -u
~~~
or **type**

~~~shell
dekuai --menu 
~~~

it will show to uninstall button.


---

#### Dependencies

+ [curl](#)
+ [awk](#)
+ [jq](#)
+ [grep](#)
+ [glow](#)
+ [gum](#)

---

#### Contributing


Pull request are welcome. To add some feature or changes please open an issue first to discuss what changes you would like to add.

+ [Contribution guide](./CONTRIBUTING.md)
    
If you have any issues regarding the DekuAI , [**join our discord server**](https://discord.gg/dgJAesCnQ5)


<div align=center>


[![Discord Server](http://invidget.switchblade.xyz/dgJAesCnQ5)](https://discord.gg/dgJAesCnQ5)

</div>

***

### License

 ```   
    copyright © 2022 DekuAI open source project

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

