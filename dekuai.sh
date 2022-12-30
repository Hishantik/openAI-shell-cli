#!/usr/bin/bash
echo -e "Welcome to DekuAI. You can quit with '\033[36mexit\033[0m'."
running=true

while $running; do
  echo -e "\n Ask :"
  read command

  if [ "$command" == "exit" ]; then
    running=false
  else
	response=$(curl https://api.openai.com/v1/completions \
		-sS \
  		-H 'Content-Type: application/json' \
  		-H "Authorization: Bearer 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" \
  		-d '{
  			"model": "text-davinci-003",
  			"prompt": "'"${command}"'",
  			"max_tokens": 1000,
  			"temperature": 0.7
	}' | jq -r '.choices[].text' | awk '{ printf "%s", $0 }')
	
	echo -e "\n\033[36mDekuAI :\033[0m${response}"
  fi
done
