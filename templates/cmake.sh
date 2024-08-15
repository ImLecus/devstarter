#!/bin/bash
# C language project template with CMake

make_template(){
    cd $cwd || exit
    local main=$(cat << 'EOF'
#include <stdio.h>

int main(){
    printf("Hello world!\n");
    return 0;
}

EOF
)

    echo "$main" > main.c || abort_process

    mkdir -p include

    local config=$(cat << 'EOF'
#ifndef CONFIG_H
#define CONFIG_H

#endif

EOF
)
    echo "$config" > include/config.h || abort_process

    mkdir -p build

    local cmake_lists=$(cat << 'EOF'
cmake_minimum_required(VERSION 3.10)

project(new_cmake_project VERSION 1.0 LANGUAGES C)

set(CMAKE_C_STANDARD 99)
set(CMAKE_C_STANDARD_REQUIRED True)

add_executable(program main.c)

EOF
)
    echo "$cmake_lists" > CMakeLists.txt || abort_process

}