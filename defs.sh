#!/bin/bash
language="none"
templates_folder="./templates"
create_usage="Usage: devstarter create [language]"

check_args() {
    if [[ $1 -lt $2 ]]; then
        echo $create_usage
        exit 1
    fi
}

check_language(){
    if [[ ! -f "$templates_folder/$language.sh" ]]; then
        echo "Unsupported language '$language'"
        exit 3
    fi
}