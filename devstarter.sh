#!/bin/bash
# devstarter entry point
DIR="$(dirname "$(realpath "$0")")"
source "$DIR/defs.sh"
check_args $# 1

case $1 in
    "create")
        check_args $# 2
        language=$2
        check_language
        echo "Creating project at $cwd"
        source "$templates_folder/$language.sh"
        make_template
        ;;
    "init")
        echo "Hello world!"
        ;;
    *)
        echo "Undefined command"
        echo $create_usage
        exit 2
        ;;
esac

