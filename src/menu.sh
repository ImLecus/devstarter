#!/bin/bash

menu_pointer_position=0
menu_pointer_icon='>'
menu_entries=()
menu_header=""

# show_menu needs this arguments:
# 1. A list with all the entries
#
# Shows the menu including the pointer
show_menu(){
    echo -e $menu_header
    local pointer=""
    menu_entries=("$@")
    for i in ${!menu_entries[@]}; do 
        if [[ $i -eq $menu_pointer_position ]]; then
            pointer="${menu_pointer_icon} ${UNDERLINE}"
        else
            pointer="  "
        fi
        echo -e  "${RESET}${pointer}${BOLD}${menu_entries[$i]}"
    done
    echo -e $RESET
}

# update_menu_pointer needs one argument:
# 1. The new pointer position
#
# Internally, the function will check if
# the index is out of bounds
update_menu_pointer(){
    menu_pointer_position=$1
    if [[ menu_pointer_position -lt 0 ]]; then
        menu_pointer_position=$(( ${#menu_entries[@]} - 1 ))
    elif [[ menu_pointer_position -ge ${#menu_entries[@]} ]]; then
        menu_pointer_position=0
    fi
}

# close_menu needs no arguments
#
# Resets the last menu data
close_menu(){
    menu_pointer_position=0
    menu_entries=()
    menu_header=""
    menu_lines=0;
}

# wait_for_response needs no arguments
#
# Reads a character (including escape characters)
# in console. If it's an up or down arrow, move
# the pointer, it will close the menu with the
# 'Enter' key
wait_for_response(){

    while true; do
        local char=''
        read -s -n 1 char
        if [[ $char == $'\x1b' ]]; then  # Escape characters
            read -s -n 2 char
        fi

        case $char in
            $'[A')
                update_menu_pointer $(($menu_pointer_position - 1))
                show_menu "${menu_entries[@]}"
                ;;
            $'[B')
                update_menu_pointer $(($menu_pointer_position + 1))
                show_menu "${menu_entries[@]}"
                ;;
            
            $'') # Enter
                close_menu
                break
                ;;
        esac
    done
}