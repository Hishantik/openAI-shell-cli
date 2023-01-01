#!/usr/bin/bash

# Check dependencies
if type curl &>/dev/null
then
        echo "" &>/dev/null
else
  if type apt &/dev/null
  then
        apt update && apt upgrade
        apt install curl
  else
    if type pkg &/dev/null
    then 
        pkg update && pkg upgrade
        pkg install curl
    else
        printf "Can't find package installer for required dependencies. Install package 'curl' & 'jq' manually......"
        exit 0
    fi
  fi
fi

if type jq &>/dev/null
then
        echo "" &>/dev/null
else
        apt install jq
fi

curl -sS https://raw.githubusercontent.com/Hishantik/openAI-shell-cli/main/dekuai.sh -o ~/../usr/bin/dekuai


chmod +x ~/../usr/bin/dekuai

echo -n "Please enter your OpenAI API key (you can one get from https://https://openai.com/account/api-keys): "
read token

if [ -f ~/.zshrc ]; then
  echo "export OPENAI_TOKEN=$token" >> ~/.zshrc
  echo "export PATH=$PATH:/usr/bin" >> ~/.zshrc
else
  if [ -f ~/.bashrc ]; then
    echo "export OPENAI_TOKEN=$token" >> ~/.bashrc
    echo "export PATH=$PATH:/usr/bin" >> ~/.bashrc
  else
    export OPENAI_TOKEN=$token
    echo "You need to add this to your shell profile: export OPENAI_TOKEN=$token"
  fi
fi
echo "Installation complete."
source ~/.zshrc || source ~/.bashrc

