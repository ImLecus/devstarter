#!/bin/bash
# Repository template (README and gitignore)

make_repo(){
    cd $cwd || exit
    local readme="# ${project_name}"

    echo "$readme" > README.md || abort_process


    local gitignore=""
    echo "$gitignore" > .gitignore || abort_process

}