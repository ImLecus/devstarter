#!/bin/bash
language="none"
create_usage="Usage: devstarter create [language] [name]"

cwd=$(pwd)
templates_folder="$(dirname "$(realpath "$0")")/templates"
source "$(dirname "$(realpath "$0")")/colors.sh"

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
    echo "  repo:       Initial repository files"
    echo "  quarzum*:    Quarzum language"
    echo "  node*:       Node JS language"
    echo "  ruby*:       Ruby language"
    echo "  python:     Python language"
    echo "  perl*:       Perl language"
    echo ""
    echo "*: not implemented yet"
}

template_names=(
    "${BLUE} C"
    "${RED} C with CMake"
    "${c_QUARZUM} Quarzum"
    "${c_CPP} C++"
    "${BLUE} Python"
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

pointer_position=0

print_menu(){
    echo -e $CLEAR_SCREEN
    echo "Create a new project"
    echo "--------------------"
    echo "Which template do you want to use?"
    echo "(Move with the up and down arrows)"
    echo ""
    local pointer=""
    for i in ${!template_names[@]}; do 
        if [[ $i -eq $pointer_position ]]; then
            pointer="> "
        else
            pointer="  "
        fi
        echo -e  "${RESET}${pointer}${BOLD}${template_names[$i]}"
    done
    echo -e $RESET
}

init_manager(){
    
    print_menu

    while true; do
        read -s -n 1 key

        case $key in
            $'\x1b') # Escape character
                read -s -n 2 arrow

                case $arrow in
                    '[A')
                        ((pointer_position--))
                        if [[ pointer_position -lt 0 ]]; then
                            pointer_position=$(( ${#template_names[@]} - 1 ))
                        fi
                        ;;

                    '[B')
                        ((pointer_position++))
                        if [[ pointer_position -ge ${#template_names[@]} ]]; then
                            pointer_position=0
                        fi
                        ;;
                esac
                echo "${pointer_position}"
                print_menu
                ;;
            '') # Enter
                language=${template_ids[$pointer_position]}
                echo "Creating project at $cwd"
                source "$templates_folder/$language.sh"
                make_template
                break
                ;;

        esac
    done 
    

}