#!/bin/bash
# Repository template (README and gitignore)

make_template(){
    cd $cwd || exit
    local readme=$(cat << 'EOF'
# My repository

EOF
)

    echo "$readme" > README.md || abort_process


    local gitignore=$(cat << 'EOF'

EOF
)
    echo "$gitignore" > .gitignore || abort_process

}