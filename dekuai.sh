#!/usr/bin/bash
echo -e "\033[0;36mWelcome to DekuAI. You can quit with \033[1;33m'exit'\033[0;36m & clear screen with \033[1;33m'clear'."
running=true
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
