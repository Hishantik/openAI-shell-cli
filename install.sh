#!/usr/bin/zsh

# Check dependencies
if type curl &>/dev/null
then
        echo "" &>/dev/null
else
        apt update && apt upgrade
        apt install curl
fi
if type jq &>/dev/null
then
        echo "" &>/dev/null
else
        apt install jq
fi

curl -sS https://raw.githubusercontent.com/Hishantik/openAI-shell-cli/main/dekuai.sh -o ~/../usr/bin/dekuai


chmod +x ~/../usr/bin/dekuai

read -p "Please enter your OpenAI API key: " token

# Adding OpenAI token to shell profile
if [ -f ~/.zshrc ]; then
  echo "export OPENAI_TOKEN=$token" >> ~/.zshrc
  echo 'export PATH=$PATH:/usr/bin' >> ~/.zshrc
else
  if [ -f ~/.bashrc ]; then
    echo "export OPENAI_TOKEN=$token" >> ~/.bashrc
    echo 'export PATH=$PATH:/usr/bin' >> ~/.bashrc
  else
    export OPENAI_TOKEN=$token
    echo "You need to add this to your shell profile: export OPENAI_TOKEN=$token"
  fi
fi
echo "Installation complete."

