#!/bin/sh
sed -i \
         -e 's/#2b2a33/rgb(0%,0%,0%)/g' \
         -e 's/#d8d8d8/rgb(100%,100%,100%)/g' \
    -e 's/#2b2a33/rgb(50%,0%,0%)/g' \
     -e 's/#693876/rgb(0%,50%,0%)/g' \
     -e 's/#1c1b22/rgb(50%,0%,50%)/g' \
     -e 's/#a2a2a2/rgb(0%,0%,50%)/g' \
	*.svg
