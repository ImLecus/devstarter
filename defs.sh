#!/bin/bash
language="none"
create_usage="Usage: devstarter create [language] [name]"
project_name="my_project"
cwd=$(pwd)
templates_folder="$DIR/templates"
source "$DIR/src/colors.sh"
source "$DIR/src/menu.sh"
source "$DIR/src/repo.sh"
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

# options:
#   repo: initializes the 'repo.sh' template
#   folder: creates a folder and initializes the template inside
declare -A options

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
    echo "  cpp*:        C++ language"
    echo "  quarzum*:    Quarzum language"
    echo "  node*:       Node JS language"
    echo "  ruby*:       Ruby language"
    echo "  python:     Python language"
    echo "  perl*:       Perl language"
    echo ""
    echo "*: not implemented yet"
}

template_names=(
    "${BLUE}C"
    "${RED}C with CMake"
    "${c_QUARZUM}Quarzum"
    "${c_CPP}C++"
    "${BLUE}Python"
)
template_ids=(
    "c"
    "cmake"
    "quarzum"
    "cpp"
    "python"
)

ARROW_UP='\033[A'
ARROW_DOWN='\033[B'
CLEAR_SCREEN="\033[H\033[J"


print_menu(){
    menu_header+="${CLEAR_SCREEN}\n"
    menu_header+="Create a new project\n"
    menu_header+="--------------------\n"
    menu_header+="Which template do you want to use?\n"
    menu_header+="(Move with the up and down arrows, confirm with Enter)\n\n"
    show_menu "${template_names[@]}"
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
    language=${template_ids[$menu_pointer_position]}
    menu_pointer_position=0
    ask_for_repo
    wait_for_response
    options["repo"]="$menu_pointer_position"
    menu_pointer_position=0
    echo "Project name: "
    read project_name

    create_project
}


create_project(){
    if [[ options["repo"] -eq 0 ]]; then
        make_repo
        git init || echo "Git is not installed. If it's a devstarter error, use 'git init' manually."
    fi
    echo "Creating project at $cwd"
    source "$templates_folder/$language.sh"
    make_template
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