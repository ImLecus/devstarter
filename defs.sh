#!/bin/bash
language="none"
create_usage="Usage: devstarter create [language] [name]"

cwd=$(pwd)
templates_folder="$(dirname "$(realpath "$0")")/templates"

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

abort_process(){
    echo "Something unexpected happened, aborting..."
    exit 4
}
