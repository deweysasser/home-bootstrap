#!/bin/bash

# Purpose:  bootstrap my home directory system

VCSHURL=https://raw.github.com/RichiH/vcsh/master/vcsh

vcsh="${TMPDIR:-/tmp}/.vcsh"


if [ ! -e "$vcsh" ] ; then
    curl $VCSHURL > "$vcsh" && chmod +x "$vcsh"
    trap 'rm -f $vcsh' 0
fi

if  "$vcsh" list | grep shared  ; then
    echo "Looks like you're already bootstraped with a 'shared' repository"
else
    "$vcsh" clone git@github.com:dmsasser/home-shared shared
    export PATH="$HOME/bin:$PATH"

    mr -d "$HOME" up
    
    echo "Make sure you put $HOME/bin on your \$PATH"
fi
