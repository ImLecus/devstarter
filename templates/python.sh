#!/bin/bash
# Python project template

make_template(){
    cd $cwd || exit
    local main=$(cat << 'EOF'
print("Hello world!")

EOF
)

    echo "$main" > main.py || abort_process

}