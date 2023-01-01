#!/usr/bin/bash



VERSION="1.0.1"



usage() {
        while read -r line; do
                printf "\033[0;36m%s\n" "$line"
        done <<-EOF

        Usage:
          ${0##*/} -h | -u | -v 

        Options:
          -v | --version to display current version of cli
          -U | --update to upadte current cli to newest versiono
          -u | --uninstall to uninstall DekuAI (might works only with android)
          -h | --help to display this help text
EOF
}


error () {
  printf "\33[2K\r\033[1;31m%s\033[0m\n" "$*" >&2
}

quit () {
    err "$*"
    exit 1                                                                                                                                                                                 
}

info () {
  printf "\33[2K\r\033[1;33m%s \033[1;35m%s\033[0m\n" "$1" "$2"                           
}

uninstall(){
  rm "$0"
}

update () {
        update="$(curl  -sS "https://raw.githubusercontent.com/Hishantik/openAI-shell-cli/main/dekuai.sh")" || die "Connection error"
        update="$(printf '%s\n' "$update" | diff -u "$0" -)"
        if [ -z "$update" ]; then
                info "Script is up to date :)"
        else
                if printf '%s\n' "$update" | patch "$0" - ; then
                        info "Script has been updated"
                else
                        quit "Can't update for some reason!"                                                     
                  fi
        fi
        exit 0
}


version (){
   info "Version : $VERSION"
}

loading(){
        echo -ne '           loading —————                      [20%]\r'
        sleep 0.5
        echo -ne '           loading —————————                  [40%]\r'
        sleep 0.5
        echo -ne '           loading ——————————————             [60%]\r'
        sleep 0.5
        echo -ne '           loading ————————————————————       [80%]\r'
        sleep 0.5
        echo -ne '           loading —————————————————————————— [100%]\r'
        echo -ne '\n'
}


OPT=$(getopt -o vuUh -l version,update,help,uninstall --n "$0" -- "$@")

eval set -- "$OPT"
unset OPT

while true; do
        case $1 in
        -v | --version) version && exit 0 ;;
        -u | --uninstall) uninstall && exit 0;;
        -U | --update) update &&  exit 0 ;;
        -h | --help) usage && exit 0 ;;
        --) shift && break ;;
        *) printf "\33[0:31mInvalid option: %s" "$1" && usage && exit 1 ;;
        esac
        shift
done
echo -e "\033[0;36mWelcome to DekuAI. You can quit with \033[1;33m'exit'\033[0;36m & clear screen with \033[1;33m'clear'."
running=true
while $running; do
  echo -e -n "\n \033[0;36mAsk :\033[1;32m "
  read command
  tput civis
  if [ "$command" == "exit" ]; then
    running=false
  else
    if [ "$command" == "clear" ]; then
      clear
    else
            response=$(curl https://api.openai.com/v1/completions \
                  -sS \
                -H 'Content-Type: application/json' \
                -H "Authorization: Bearer $OPENAI_TOKEN" \
                -d '{
                        "model": "text-davinci-003",
                        "prompt": "'"${command}"'",
                        "max_tokens": 1000,
                        "temperature": 0.7
            }' | jq -r '.choices[].text' | awk '{ printf "%s", $0 }')
      loading
            echo -e "\n\033[0;36mDekuAI : \033[1;33m${response}"
    fi
  fi
  tput cnorm
done
