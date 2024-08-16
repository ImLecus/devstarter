#!/bin/bash
# Web project template (Vanilla)

make_template(){
    cd $cwd || exit
    local index=$(cat << 'EOF'
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <h1>Hello world!</h1>

    </script src="script.js">
</body>
</html>

EOF
)

    echo "$index" > index.html || abort_process
    echo "" > style.css || abort_process
    echo "" > script.js || abort_process    
    mkdir -p assets
    mkdir -p assets/fonts
    mkdir -p assets/images

}