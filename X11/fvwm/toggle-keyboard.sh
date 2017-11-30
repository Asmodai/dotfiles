#!/bin/bash

device='AT Translated Set 2 keyboard'

if [[ ${1} = "enable" ]]
then
    xinput --enable "${device}"
elif [[ ${1} = "disable" ]]
then
    xinput --disable "${device}"
fi

