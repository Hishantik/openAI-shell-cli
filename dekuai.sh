#!/bin/sh


VERSION="1.2.3"



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
  gum style --foreground "#FFFFFF" --background "#D90429" "$*" >&2
}

exiting () {
    error "$*"
    exit 1                                                                                                                                                                                 
}

info () {
  gum style --border rounded --border-foreground "#1B998B" --foreground "#F6AA1C"  --bold  \
    --padding "1 1 0 1" --margin "1 1"\
    "$1" "$2"                           
}

uninstall(){
  rm "$0"
}

option(){
  OPTION=$(gum choose --cursor "📌 " --cursor.foreground "#FCA311" --selected.foreground "#8AC926" --limit 1 {"help","version"})
  case "$OPTION" in
    "help") usage && option;;
    "version") version && option;;
  esac  
}

update () {
        update="$(curl  -sS "https://raw.githubusercontent.com/Hishantik/openAI-shell-cli/main/dekuai.sh")" || die "Connection error"
        update="$(printf '%s\n' "$update" | diff -u "$0" -)"
        if [ -z "$update" ]; then
                info "DekuAI is up to date :)"
        else
                if printf '%s\n' "$update" | patch "$0" - ; then
                        info "DekuAI has been updated"
                else
                  exiting "Can't update for some reason!"                                                     
                fi
        fi
        exit 0
}



spinner(){
    gum spin --spinner dot --title "$1"  --spinner.foreground "#B5E48C" --title.bold --title.foreground "#2EC4BC"  -- sleep 3    
}

version (){
  sleep 1;clear
   spinner "loading please wait"
   info "💡 Version : $VERSION"
}

loading(){
  while kill -0 "$pid" 2> /dev/null; do
    gum spin --spinner points --title "loading please wait...."  --spinner.foreground "#B5E48C" --title.bold -- sleep 5    
  done
}


quit(){
  running=false
  gum style \
    --border rounded --padding "0 1" --border-foreground "#EF233C" --background "#EF233C"\
    --foreground "#FFFFFF" "😇 Bye have a great day!!"
  exit 0
}


OPT=$(getopt -o ovuUh -l options,version,update,help,uninstall --n "$0" -- "$@")

eval set -- "$OPT"
unset OPT

while true; do
        case $1 in
        -o | --options) option && exit 0;;
        -v | --version) version && exit 0 ;;
        -u | --uninstall) uninstall && exit 0;;
        -U | --update) update &&  exit 0 ;;
        -h | --help) usage && exit 0 ;;
        --) shift && break ;;
        *) printf "\33[0:31mInvalid option: %s" "$1" && usage && exit 1 ;;
        esac
        shift
done


CTRL=$(gum style\
  --foreground "#D5BDAF" "(Press ctrl+d to $(gum style --foreground "#588157" "Enter"))"
)

gum style\
  --border rounded --border-foreground "#2EC4BC" --foreground "#D9ED92"\
  --align center --width 50  --padding "1 3" --bold\
  "Welcome to DekuAI" 'You can type press esc to quit & type clear to clear screen.'
running=true
while $running; do
  ASK=$(gum style --foreground "#2C666E" --bold "ASK : $(gum style --foreground "#FFFFFF" --faint "(Press ctrl+d to $(gum style --foreground "#FF0054" --bold "Enter"))")")
  echo -e "\n\n $ASK"
  QUESTION=$(gum write\
    --char-limit 0 --base.border rounded --base.align left\
    --prompt "  "  --placeholder "Type your questions here......"\
    --cursor.foreground "#FFB703" --cursor.background "#FFB703" --cursor.bold --base.border-foreground '#FFC300'\
    --base.margin "1 0" --base.width 50 --placeholder.bold --placeholder.width 50)

   sleep 0.5; clear
   QUE=$(gum style \
     --border rounded "Q. $QUESTION"\
     --bold\
     --border-foreground "#FFB703" --foreground "#00AFB9" --padding "0 1"
 )
  

  if [ -z "$QUESTION" ]; then
    gum confirm --selected.background "#007F5F" "Are you sure you want to quit?" && quit || continue  
  else
    if [ "$QUESTION" = "clear" ]; then
      clear
    else
      if [ "$QUESTION" = "options" ]; then
         option
       else   
           RESPONSE=" "
           curl https://api.openai.com/v1/completions \
                  -sS \
                -H 'Content-Type: application/json' \
                -H "Authorization: Bearer $OPENAI_TOKEN" \
                -d '{
                        "model": "text-davinci-003",
                        "prompt": "'"${QUESTION}"'",
                        "max_tokens": 4000,
                        "temperature": 0.7,
                        "best_of":1,
                        "top_p":1,
                        "frequency_penalty": 0.81,
                        "presence_penalty": 0.8
            }' | jq -M -r '.choices[].text|gsub("\\\\n";"\n")' | awk '{ printf "%s\n", $0 }' > ~/.local/answers.txt &
            pid=$!
            loading
            RESPONSE=$(cat ~/.local/answers.txt)
            echo -e "DekuAI 😄 : $RESPONSE" > ~/.local/answers.txt 
            OUTPUT=$(gum style --foreground "#83C5BE" "$(gum format < ~/.local/answers.txt -t code)")
            gum style \
            --width 70 --padding "0 3"  --border thick --foreground "#83C5BE" --border-foreground "#EF233C"  "${QUE}" "${OUTPUT}"
      fi
    fi
  fi
done
