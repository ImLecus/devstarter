#!/bin/bash
# Node JS project template

make_template(){
    cd $cwd || exit
    local index=$(cat << 'EOF'
function greet(){
    console.log('Hello world!')
}

EOF
)

    echo "$index" > index.js || abort_process
    

    local package=$(cat << EOF
{
  "name": "${options["project_name"]}",
  "version": "1.0.0",
  "description": "A basic Node.js project template",
  "main": "./index.js",
  "scripts": {
    "start": "node index.js"
  },
  "dependencies": {},
  "author": "",
  "license": "MIT"
}

EOF
)

    echo "$package" > package.json || abort_process
    mkdir -p src
}