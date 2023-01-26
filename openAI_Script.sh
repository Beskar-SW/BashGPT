#!/bin/bash

API_KEY=""

# Establecer los valores predeterminados para los parámetros
prompt=""
#model="text-davinci-003"
model=""
#model="curie"
temperature=0.9

# Recuperar los valores de las banderas
while getopts "p:k:m:" opt; do
  case $opt in
    p)
      prompt="$OPTARG"
      ;;
    k)
      API_KEY="$OPTARG"
      ;;
    m)
      model="$OPTARG"
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      ;;
  esac
done

# Enviar una solicitud POST a la 
curl https://api.openai.com/v1/completions \
    -H 'Content-Type: application/json' \
    -H "Authorization: Bearer $API_KEY" \
    -d "{\"prompt\":\"$prompt\", \"model\":\"$model\", \"max_tokens\": 2000,\"temperature\":
    $temperature}" \
    | jq -c .choices[0].text > result.txt && echo "" \
    && sed -i -e 's/\\n//g' result.txt \
    && cat result.txt 
