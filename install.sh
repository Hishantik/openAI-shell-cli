#!/bin/sh

SYSTEM=$(uname -o)


android(){
  pkg update 
  for i in gum curl glow jq 
  do
    if which $i > /dev/null; then
      echo "package $i is already installed in the system"
    else
      pkg install "$i"
    fi
  done
  if which dekuai > /dev/null; then
    dekuai -u
    curl -sS https://raw.githubusercontent.com/Hishantik/openAI-shell-cli/main/dekuai.sh -o ~/../usr/bin/dekuai || echo "Connection error please use vpn and run the script again...."
    chmod +x ~/../usr/bin/dekuai
  else
    curl -sS https://raw.githubusercontent.com/Hishantik/openAI-shell-cli/main/dekuai.sh -o ~/../usr/bin/dekuai || echo "Connection error please use vpn and run the script again...."
    chmod +x ~/../usr/bin/dekuai
  fi
}

macos(){
   result=$(grep "185.199.108.133 raw.githubusercontent.com" /etc/hosts)
    if [ -n "$result" ]; then
      echo "" &> /dev/null
    else
      sudo echo "185.199.108.133 raw.githubusercontent.com" >> /etc/hosts
    fi
   while $running; do
     if which brew > /dev/null; then
       for i in gum curl glow jq
       do
         if which $i > /dev/null; then
           echo "package $i is already installed in the system"
         else
           brew install "$i"
         fi
       done
       break
     else
       /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
     fi
  done
  if which dekuai > /dev/null; then
    dekuai -u  
    sudo curl -sS https://raw.githubusercontent.com/Hishantik/openAI-shell-cli/main/dekuai.sh -o "$(brew --prefix)"/bin/dekuai || echo "Connection error please use vpn and run the script again...."
    chmod +x "$(brew --prefix)"/bin/dekuai
  else
    sudo curl -sS https://raw.githubusercontent.com/Hishantik/openAI-shell-cli/main/dekuai.sh -o "$(brew --prefix)"/bin/dekuai || echo "Connection error please use vpn and run the script again...."
    chmod +x "$(brew --prefix)"/bin/dekuai
  fi

}

linux(){
  sudo mkdir -p /etc/apt/keyrings
  curl -fsSL https://repo.charm.sh/apt/gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/charm.gpg
  echo "deb [signed-by=/etc/apt/keyrings/charm.gpg] https://repo.charm.sh/apt/ * *" | sudo tee /etc/apt/sources.list.d/charm.list
  result=$(grep "185.199.108.133 raw.githubusercontent.com" /etc/hosts)
  if [ -n "$result" ]; then
    echo "" &> /dev/null
  else
    sudo echo "185.199.108.133 raw.githubusercontent.com" >> /etc/hosts
  fi
  sudo apt update
  for i in gum curl glow jq 
  do
    if which $i > /dev/null; then
      echo "package $i is already installed in the system"
    else
      apt install "$i"
    fi
  done
  if which dekuai > /dev/null; then
    sudo dekuai -u
    sudo curl -sS https://raw.githubusercontent.com/Hishantik/openAI-shell-cli/v1/dekuai.sh -o /usr/bin/dekuai 
    sudo chmod +x /usr/bin/dekuai
  else
    sudo curl -sS https://raw.githubusercontent.com/Hishantik/openAI-shell-cli/v1/dekuai.sh -o /usr/bin/dekuai 
    sudo chmod +x /usr/bin/dekuai
  fi
}



checkOS(){
  case "$SYSTEM" in
    "Android") android;;
    "GNU/Linux") linux;;
    "Darwin") macos;;
  esac
}


#############
### MAIN ###
#############
checkOS
dekuai



