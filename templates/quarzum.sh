#!/bin/bash
# Quarzum project template

make_template(){
    cd $cwd || exit
    local main=$(cat << 'EOF'
import "@std/console.qz"

function main(){
    out("Hello world!");
}

EOF
)

    echo "$main" > main.qz || abort_process

    mkdir -p modules

}