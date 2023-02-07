#!/usr/bin/sh

sleep 0.03;clear


############################
### TERMINAL SCREEN SIZE ###
###########################

WIDTH=$(tput cols)
HEIGHT=$(tput lines)


#####################
### HELP & USAGE ###
###################


usage() {
   glow -p github.com/hishantik/openAI-shell-cli || error "connection error...."     
}

###########################
### CUSTOM ERROR OUTPUT ##
#########################

error () {
  gum style --border rounded --border-foreground "#EF233C" --foreground "#FFFFFF"  "$*🙊" >&2
}

#####################
## EXITING ERROR ###
###################

exiting () {
    error "$*"
    exit 1                                                                                                                                                                                 
}

######################
#### CUSTOM OUTPUT ##
####################

info () {
  gum style --border rounded --border-foreground "#1B998B" --foreground "#F6AA1C"  --bold  \
    --padding "1 1 0 1" --margin "1 1"\
    "$1" "$2"                           
}


######################
### UNINSTALL CLI ###
####################

uninstall(){
  spinner "monkey" "uninstalling...."
  rm "$0"
}

#################
### LOGIN ######
################


provideToken(){
  clear
  gum style\
  --foreground "#1B998B" --width $WIDTH --border hidden\
  --align center --bold "WELCOME TO $(gum style --foreground "#FFB703" "🐒 DekuAI") LOGIN SECTION" \
  "$(gum style --faint --foreground "#FFFFFF" "Visit 👉 https://github.com/hishantik/openAI-shell-cli")" 

  gum style\
    --border rounded --border-foreground "#1B998B"\
    --foreground "#F6AA1C" --align center  --width 18\
    --bold "LOGIN" --padding "0 0" --margin "1 $((($WIDTH-14)/2))"

  TOKEN=$(gum input --cursor.foreground "#F6AA1C" --prompt.foreground "#1B998B"\
   --prompt.margin "0 1 0 5"  --prompt "Enter your openai token 🙈" --password --placeholder " openai token"
  )
  if [ -z "$TOKEN" ];then
    echo "" &> /dev/null
  else
    if [ -n "$1" ]; then
      if [ -f $HOME/.zshrc ]; then 
       sed -i '/OPENAI_TOKEN/c\export OPENAI_TOKEN=$TOKEN' $HOME/.zshrc
      else
        if [ -f $HOME/.bashrc ]; then
          sed -i '/OPENAI_TOKEN/c\export OPENAI_TOKEN=$TOKEN' $HOME/.bashrc
        else
          sed -i '/OPENAI_TOKEN/c\export OPENAI_TOKEN=$TOKEN' $HOME/.profile
        fi
      fi
    else
      if [ -f $HOME/.zshrc ]; then 
        echo "export OPENAI_TOKEN=$TOKEN" >> $HOME/.zshrc
        source $HOME/.zshrc
      else
        if [ -f $HOME/.bashrc ]; then
          echo "export OPENAI_TOKEN=$TOKEN" >> ~/.bashrc
          source $HOME/.bashrc
        else
          echo "export OPENAI_TOKEN=$TOKEN" >> ~/.profile
          source $HOME/.profile
        fi
      fi
    fi
  fi
  sleep 0.5; clear
}


######################
#### CHECK TOKEN ####
#####################

checktoken(){
  result=$(grep "OPENAI_TOKEN" $HOME/.zshrc)
  if [ -n "$result" ]; then
    echo "" &> /dev/null
  else
    gum style --foreground "Sorry could not find openai token.Please provide one."
    provideToken $result
  fi
}


#################
## CLI OPTIONS ##
################


option(){
  gum style\
    --foreground "#1B998B" --bold "DekuAI OPTIONS :"
  gum style\
    --faint --margin "1 1" "press j ↑ | k ↓ • esc quit • enter  choose" & 
  OPTION=$(gum choose --item.margin "1 0 0 3" \
    --item.border-foreground "#1B998B" --item.align center --item.width 11 --item.border rounded --cursor "> " \
    --cursor.background "#F6AA1C" --cursor.width 13 --cursor.align center --cursor.foreground "#001219" --cursor.bold\
    --cursor.padding "0 1" --cursor.margin "1 0 0 3"\
    --limit 1 "dekuai"  "help" "update" "version" "login" "uninstall" "exit") 
  case "$OPTION" in
    "dekuai") "$0" ;;
    "help") usage && option;;
    "update")update && dekuai;;
    "version") version && option;;
    "login") provideToken && option;;
    "unistall") uninstall && exit 0;;
    "exit") quit ;;
  esac  
}


#################
## UPDATE CLI ##
###############

update () {
        update="$(curl  -fsSL "https://raw.githubusercontent.com/Hishantik/openAI-shell-cli/main/dekuai.sh")" || error "Connection error..."
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



##########################
## OVERLOADING SPINNER ##
########################

spinner(){
    gum spin --spinner "$1" --title "$2🐒"  --spinner.foreground "#F6AA1C" --title.bold --title.foreground "#1B998B"  --title.foreground "#1B998B" --title.bold \
      --spinner.margin "1 0 0 1" -- sleep 3    
}



#################
## CLI VERSION ##
################

VERSION="1.2.3"

version (){
  sleep 1;clear
   spinner "monkey" "loading please wait..."
   info "🐒 Version : $VERSION"
}


######################
## RESPONSE SPINNER ##
#####################

loading(){
  while kill -0 "$pid" 2> /dev/null; do
    gum spin --spinner points --title "loading please wait...🐒"  --spinner.foreground "#FFB703" --title.foreground "#1B998B" --title.bold -- sleep 5    
  done
}


######################
## QUITTING PROGRAM ##
#####################


quit(){
  running=false
  spinner "monkey" "quitting...."
  gum style \
    --border rounded --padding "0 1 0 1" --margin "1 1 1 1" --border-foreground "#1B998B" --foreground "#F6AA1C"\
     "🐒 Bye have a great day!!"
  exit 0
}




########################
## COMMAND LINE ARGS ##
######################


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





#####################
## MAIN GOES HERE ##
####################



####################
## PROGRAM HEADER ##
###################

#first checks for token if it is available  in rc  file o r not

checktoken

gum style\
  --foreground "#1B998B" --width $WIDTH --border hidden\
  --align center --bold "WELCOME TO $(gum style --foreground "#FFB703" "🐒 DekuAI")" \
  "$(gum style --faint --foreground "#FFFFFF" "press esc → exit • ctrl + d → enter ")" 



######################
## PROGRAM RUNNING ##
####################

running=true
while $running; do
  gum style --margin "1 2 0 $((($WIDTH-50)/2))" --foreground "#1B998B" --bold "ASK 🙈 : "
  QUESTION=$(gum write\
    --char-limit 0 --base.border rounded --width 80\
    --prompt "  "  --placeholder "Type your questions here......"\
    --cursor.foreground "#FFB703" --cursor.background "#FFB703" --cursor.bold --base.border-foreground '#1B998B'\
    --base.margin "1 $((($WIDTH-50)/2))" --base.width 50 --base.height 7 --placeholder.bold --base.padding "1 0"\
  )

   sleep 0.5; clear
   QUE=$(gum style \
     --border rounded "🙉. $QUESTION"\
     --bold --width 2 --height 1\
     --border-foreground "#FFB703" --foreground "#1B998B" --padding "0 1"
 )
  

  if [ -z "$QUESTION" ]; then
    gum confirm --prompt.margin "2 0 0 2" --selected.background "#1B998B" --prompt.foreground "# F6AA1C" "🐒 Are you sure you want to quit?" && quit || continue  
  else
    if [ "$QUESTION" = "clear" ]; then
      clear
    else
      if [ "$QUESTION" = "options" ]; then
         option
       else   
           RESPONSE=" "
           #Check whether the user inputlenght is long or short
           MAX_INPUT_LENGTH=1024
           INPUT_CHUNK_SIZE=512
           #dividing input into chunks of word according to input chuk size
           if [ ${#QUESTION} -gt $MAX_INPUT_LENGTH ];then
              QUESTION=$(echo "User input is too long...")
              for i in $(seq 0 $INPUT_CHUNK_SIZE $((${#QUESTION}-1)));do
                CHUNK=${QUESTION:$i:$INPUT_CHUNK_SIZE}
                curl https://api.openai.com/v1/completions \
                      -sS \
                      -H 'Content-Type: application/json' \
                      -H "Authorization: Bearer $OPENAI_TOKEN" \
                      -d '{
                              "model": "text-davinci-003",
                              "prompt": "'"${CHUNK}"'",
                              "max_tokens": 3048,
                              "temperature": 0.7,
                              "best_of":1,
                              "top_p":1,
                              "frequency_penalty": 0.81,
                              "presence_penalty": 0.8
                  }' | jq -M -r '.choices[].text|gsub("\\\\n";"\n")' | awk '{ printf "%s\n", $0 }' >> ~/.local/answers.txt 
              done
            else    
              #if user input length is not too long ....
               QUESTION=$(echo "$QUESTION" | grep -v '^ *$' |tr '\n' ' ')
               curl https://api.openai.com/v1/completions \
                        -sS \
                        -H 'Content-Type: application/json' \
                        -H "Authorization: Bearer $OPENAI_TOKEN" \
                        -d '{
                                "model": "text-davinci-003",
                                "prompt": "'"${QUESTION}"'",
                                "max_tokens": 3048,
                                "temperature": 0.7,
                                "best_of":1,
                                "top_p":1,
                                "frequency_penalty": 0.81,
                                "presence_penalty": 0.8
               }' | jq -M -r '.choices[].text|gsub("\\\\n";"\n")' | awk '{ printf "%s\n", $0 }' > ~/.local/answers.txt 
            fi &
            pid=$!
            loading
            RESPONSE=$(cat ~/.local/answers.txt)
            echo  "DekuAI 🐵 : $RESPONSE" > ~/.local/answers.txt 
            OUTPUT=$(gum style --foreground "#83C5BE" "$(gum format --theme notty< ~/.local/answers.txt)")
            gum style \
              --width $(($WIDTH-10)) --foreground "#83C5BE" --padding "1 4 2 4" --margin "0 0 0 5"  --border thick  --border-foreground "#1B998B"  "${QUE}" "${OUTPUT}"
            gum confirm --selected.margin "1 1 1 4" --unselected.margin "1 1 1 4" --prompt.margin "2 0 0 4" --selected.background "#1B998B" --prompt.foreground "# F6AA1C" "🐒 Next Question?" && continue || quit  
      fi
    fi
  fi
done
