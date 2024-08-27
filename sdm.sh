#!/bin/bash
# sdm entry point

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
    if [[ ! -f "$templates_folder/$project_language.sh" ]]; then
        echo "Unsupported template '$project_language'"
        exit 3
    fi
}

abort_process(){
    echo "Something unexpected happened, aborting..."
    exit 4
}

#
#   PROJECT CONFIGURATION FILE AND OPTIONS
#

# Determines the project name. Generally used on
# README.md files.
project_name=""

# The target project version.
project_version=""

# The project main language. Used to execute the 
# project or any related package manager.
project_language=""


# Creates/updates a configuration file when
# a project is created.
#
# The file is called '.sdm' and it contains
# the project information stored as bash variables.
# If the first argument is true, the config file will be overwritten.
config_file(){
    touch "$cwd/.sdm"
    truncate -s 0 "$cwd/.sdm"
    if [[ -n $project_name ]]; then 
        echo "project_name=\"$project_name\"" >> "$cwd/.sdm" || abort_process
    fi
    if [[ -n $project_version ]]; then 
        echo "project_version=\"$project_version\"" >> "$cwd/.sdm" || abort_process
    fi
    if [[ -n $project_language ]]; then 
        echo "project_language=\"$project_language\"" >> "$cwd/.sdm" || abort_process
    fi
    
}

# Checks if the .sdm file exists and executes it as a sh file.
read_config(){
    if [[ -f "$cwd/.sdm" ]]; then
        source "$cwd/.sdm"
        true;
    else false; fi
}


#
#
#

print_help(){
    echo "Devstarter usage"
    echo "----------------"
    echo "Commands:"
    echo "  create [template]: Initializes a template"
    echo "  init: Starts the template manager"
    echo "  help: Shows this message"
    echo "  update [type]: Updates the project version"
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
    project_language=${TEMPLATE_IDS[$menu_pointer_position]}
    project_version="1.0"
    menu_pointer_position=0
    ask_for_repo
    wait_for_response
    options["repo"]="$menu_pointer_position"
    menu_pointer_position=0
    echo "Project name: "
    read -r project_name
    echo ""
    create_project
}


create_project(){
    check_template
    if [[ options["repo"] -eq 0 ]]; then
        make_repo
        git init || echo "Git is not installed. If it's a devstarter error, use 'git init' manually."
    fi
    source "$templates_folder/$project_language.sh"
    make_template
    config_file
    echo "Created project '$project_name' at $cwd"
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
        project_name=$1
    fi
}
check_args $# 1

case $1 in
    "create")
        check_args $# 2
        project_language=$2
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
    "update")
        read_config || echo ".sdm file not found"
        #IFS='.' read -r major minor patch <<< project_version
        #major=$((major + 1))
        #project_version="${major}.${minor}.${patch}"
        config_file
        ;;
    *)
        echo "Undefined command"
        print_help
        ;;
esac

