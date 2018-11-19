#!/bin/bash
set -x
if [[ -d themes/.git ]]
then
   (cd themes && git pull origin master)
else
    git clone https://github.com/getpelican/pelican-themes.git /site/themes
fi

 
