#!/bin/bash
# -*- Mode: Shell-script -*-
#
# installkde.sh --- Install script for KDE goodness.
#
# Copyright (c) 2022 Paul Ward <asmodai@gmail.com>
#
# Author:     Paul Ward <asmodai@gmail.com>
# Maintainer: Paul Ward <asmodai@gmail.com>
# Created:    04 Sep 2022 22:57:14
#
# {{{ License:
#
# This program is free software: you can redistribute it
# and/or modify it under the terms of the GNU General Public
# License as published by the Free Software Foundation,
# either version 3 of the License, or (at your option) any
# later version.
#
# This program is distributed in the hope that it will be
# useful, but WITHOUT ANY  WARRANTY; without even the implied
# warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
# PURPOSE.  See the GNU General Public License for more
# details.
#
# You should have received a copy of the GNU General Public
# License along with this program.  If not, see
# <http://www.gnu.org/licenses/>.
#
# }}}
# {{{ Commentary:
#
# }}}

TRUE="true"
FALSE="false"

_rootwd=`pwd`
_kdeConf=${HOME}/.local/share

if [[ ! -f install.sh ]]
then
    echo "Please run this sript from inside the dotfiles folder."
    exit 1
fi

yesOrNo() {
    local msg="$1"

    echo -n "${msg}? [Y/n] "

    while true;
    do
        read -n 1 input
        echo

        case ${input} in
            [yY]) YESORNO=$TRUE  ; return ;;
            [nN]) YESORNO=$FALSE ; return ;;
        esac
    done
}

installColorScheme() {
    yesOrNo "Install KDE colour scheme"

    if [[ "${YESORNO}" = "${TRUE}" ]]
    then
        if [ ! -d ${_kdeConf}/color-schemes/ ]
        then
            mkdir -p ${_kdeConf}/color-schemes/
        fi

        echo "Installing KDE colour scheme..."
        rm -f ${_kdeConf}/color-schemes/Mine.colors
        ln -s ${_rootwd}/X11/themes/kde/Mine.colors \
              ${_kdeConf}/color-schemes/Mine.colors
        echo "Done."
    fi
}

installKonsole() {
    yesOrNo "Install konsole colour scheme and profile?"

    if [[ "${YESORNO}" = "${TRUE}" ]]
    then
        if [ ! -d ${_kdeConf}/konsole/ ]
        then
            mkdir -p ${_kdeConf}/color-schemes/
        fi

        echo "Installing konsole colour scheme..."
        rm -f ${_kdeConf}/konsole/Mine.colorscheme
        ln -s ${_rootwd}/terminals/konsole/Mine.colorscheme \
              ${_kdeConf}/konsole/Mine.colorscheme
        echo "Done."

        echo "Installing konsole profile..."
        rm -f ${_kdeConf}/konsole/Mine.profile
        ln -s ${_rootwd}/terminals/konsole/Mine.profile \
              ${_kdeConf}/konsole/Mine.profile
        echo "Done."
    fi
}

installColorScheme
installKonsole

# installkde.sh ends here.
