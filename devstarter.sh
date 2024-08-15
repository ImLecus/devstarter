#!/bin/bash
# devstarter entry point
source ./defs.sh

check_args $# 1

case $1 in
    "create")
        check_args $# 2
        language=$2
        check_language
        echo "Creating project"
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

