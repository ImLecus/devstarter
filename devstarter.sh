#!/bin/bash
# devstarter entry point
DIR="$(dirname "$(realpath "$0")")"
source "$DIR/defs.sh"
check_args $# 1

case $1 in
    "create")
        check_args $# 2
        options["template"]=$2
        check_template

       
        if [[ $# -gt 2 ]]; then 
            shift 2

            for arg in "$@"; do
                parse_flag "$arg"
            done
        fi

        create_project
        ;;
    "init")
        init_manager
        ;;
    "help")
        print_help
        ;;
    *)
        echo "Undefined command"
        print_help
        ;;
esac

