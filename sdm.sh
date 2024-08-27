#!/bin/bash
# devstarter entry point

# options:
#   repo: initializes the 'repo.sh' template
#   folder: creates a folder and initializes the template inside
#   template: defines the template id
#   project_name: defines the project name
declare -A options
options["template"]=""
options["project_name"]="my_project"

create_usage="Usage: devstarter create [templates] [name]"
cwd=$(pwd)

# Project folders
DIR="$(dirname "$(realpath "$0")")"
templates_folder="$DIR/templates"
source "$DIR/src/colors.sh"
source "$DIR/src/menu.sh"
source "$DIR/src/repo.sh"
source "$DIR/src/templates.sh"

# Checks if the numer of arguments is lower than the expected
check_args() {
    if [[ $1 -lt $2 ]]; then
        echo "$create_usage"
        exit 1
    fi
}

check_template(){
    if [[ ! -f "$templates_folder/${options["template"]}.sh" ]]; then
        echo "Unsupported template '${options["template"]}'"
        exit 3
    fi
}

abort_process(){
    echo "Something unexpected happened, aborting..."
    exit 4
}

# Creates a configuration file when
# a project is created.
# The file is called '.devstarter' and it contains
# the project information stored as bash variables.
create_config_file(){
    echo "" > .devstarter || abort_process
}

print_help(){
    echo "Devstarter usage"
    echo "----------------"
    echo "Commands:"
    echo "  create [template]: Initializes a template"
    echo "  init: Starts the template manager"
    echo "  help: Shows this message"
    echo ""
    echo "Templates:"
    echo "  c:          C language"
    echo "  cmake:      C language with CMake"
    echo "  cpp:        C++ language"
    echo "  quarzum:    Quarzum language"
    echo "  node*:       Node JS language"
    echo "  ruby*:       Ruby language"
    echo "  python:     Python language"
    echo "  perl*:       Perl language"
    echo ""
    echo "*: not implemented yet"
}

CLEAR_SCREEN="\033[H\033[J"


print_menu(){
    menu_header+="${CLEAR_SCREEN}\n"
    menu_header+="Create a new project\n"
    menu_header+="--------------------\n"
    menu_header+="Which template do you want to use?\n"
    menu_header+="(Move with the up and down arrows, confirm with Enter)\n"
    show_menu "${TEMPLATE_NAMES[@]}"
}

ask_for_repo(){
    menu_header+="${CLEAR_SCREEN}\n"
    menu_header+="Do you want to initialize a new git repository?\n"
    local options=("Yes" "No")
    show_menu "${options[@]}"
}

init_manager(){
    print_menu
    wait_for_response
    options["template"]=${TEMPLATE_IDS[$menu_pointer_position]}
    menu_pointer_position=0
    ask_for_repo
    wait_for_response
    options["repo"]="$menu_pointer_position"
    menu_pointer_position=0
    echo "Project name: "
    read options["project_name"]
    echo ""
    create_project
}


create_project(){
    check_template
    if [[ options["repo"] -eq 0 ]]; then
        make_repo
        git init || echo "Git is not installed. If it's a devstarter error, use 'git init' manually."
    fi
    source "$templates_folder/${options["template"]}.sh"
    make_template
    create_config_file
    echo "Created project '${options["project_name"]}' at $cwd"
}

parse_flag(){
    if [[ $1 == -* ]]; then
        case $1 in
            "-r")
                options["repo"]=0
                ;;
            *)
                echo "Unknown flag '$1'"
                exit 5
                ;;
        esac
    else
        options["project_name"]=$1
    fi
}
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

