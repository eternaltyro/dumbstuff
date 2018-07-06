#!/bin/bash

# Rename files to replace spaces with underscores and remove all other
# special characters and switch to lower case
function fnfix {
    ls | while read -r FILE
    do
        mv -v "$FILE" $(echo $FILE | tr ' ' '_' | tr '[' '_' | tr -d '{}(),\!]' | tr '[A-Z]' '[a-z]')
    done
}

function sanitize {
    echo "$1" | /bin/tr ' ' '_' | /bin/tr '[' '_' | /bin/tr -d '{}(),\!]' | /bin/tr '[A-Z]' '[a-z]'
}

function namefix {
    for file in {.,}*; do /bin/mv "$file" sanitize "$file"; done
}
