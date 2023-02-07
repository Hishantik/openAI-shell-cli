#!/bin/sh

sleep 0.5;clear
WIDTH=$(tput cols)

URL="https://beta.openai.com/account/api-keys"

# login_openAI(){

# }

chrome(){
  am start -a android.intent.action.VIEW -d $URL
} 

choose_browser(){
  sleep 0.5;clear
  gum style\
    --foreground "#1B998B" --bold "Choose browser that is installed in your device :"
  gum style\
    --faint --margin "1 1" "press j ↑ | k ↓ • esc quit • enter  choose" &
  OPTION=$(gum choose --item.margin "1 0 0 3" \
    --item.border-foreground "#1B998B" --item.border rounded --cursor "> " \
    --cursor.background "#F6AA1C" --cursor.width 11 --cursor.align center --cursor.foreground "#001219" --cursor.bold\
    --cursor.padding "0 1" --cursor.margin "1 0 0 3"\
    --limit 1 "chrome"  "firefox" "brave" "operamini" "exit")
  case "$OPTION" in
    "chrome") chrome ;;
    "firefox") firefox;;
    "brave") brave;;
    "operamini") operamini;;
    "exit") exit 0;;
  esac
}

checkfile(){
  result=$(grep "OPENAI_TOKEN" $HOME/.zshrc)
  if [ -n "$result" ]; then
    dekuai
  else
    gum style --foreground "Sorry could not find openai token.Please provide one."
    login_token
  fi
}

checkToken(){
  gum confirm --selected.margin "1 1 1 2" --unselected.margin "1 1 1 2" --prompt.margin "0 0 0 2" --selected.background "#1B998B" --prompt.foreground "# F6AA1C" "🐒 Have you logged in or used token previously ?" && checkfile || choose_browser
}


gum style\
  --bold --border hidden --align center --width $WIDTH --foreground "#1B998B" "WELCOME TO SETUP SECTION OF" "🐒$(gum style \
   --underline  --foreground "#FFB703" " DekuAI")"
checkToken
















