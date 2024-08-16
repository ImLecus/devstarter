#!/bin/bash
# C++ language project template

make_template(){
    cd $cwd || exit
    local main=$(cat << 'EOF'
#include <iostream>

using namespace std;

int main(){
    cout << "Hello world!" << endl;
    return 0;
}

EOF
)

    echo "$main" > main.cpp || abort_process

    mkdir -p include

    local config=$(cat << 'EOF'
#pragma once

EOF
)
    echo "$config" > include/config.hpp || abort_process

}