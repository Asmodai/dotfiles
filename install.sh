#!/bin/bash
# -*- Mode: Shell-script -*-
#
# install.sh --- Dot files installer.
#
# Copyright (c) 2016 Paul Ward <asmodai@gmail.com>
#
# Author:     Paul Ward <asmodai@gmail.com>
# Maintainer: Paul Ward <asmodai@gmail.com>
# Created:    16 Aug 2016 21:31:24
# Keywords:   
# URL:        not distributed yet
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

if [[ ! -f install.sh ]];
then
    echo "Please run this sript from inside the dotfiles folder."
    exit 1
fi

yesOrNo() {
    local msg="$1"

    echo -n "${msg}? [Y/n] "

    while true;
    do
        read -N 1 input
        echo

        case ${input} in
            [yY]) YESORNO=$TRUE  ; return ;;
            [nN]) YESORNO=$FALSE ; return ;;
        esac
    done
}

installZsh() {
    yesOrNo "Install ZSH doftiles"

    if [[ "${YESORNO}" = "${TRUE}" ]];
    then
        echo "Installing ZSH dotfiles..."

        rm ${HOME}/.zshrc 2>/dev/null
        rm -rf ${HOME}/.zshrc.d 2>/dev/null

        ln -s ${_rootwd}/zshrc.d/zshrc ${HOME}/.zshrc
        ln -s ${_rootwd}/zshrc.d ${HOME}/.zshrc.d

        echo "Done."
    fi
}

installPowerLine() {
    yesOrNo "Install PowerLine config"

    if [[ "${YESORNO}" = "${TRUE}" ]];
    then
        echo "Installing PowerLine config..."

        rm -rf ${HOME}/.config/powerline 2>/dev/null
        ln -s ${_rootwd}/powerline ${HOME}/.config/powerline

        echo "Done."
    fi
}

installVim() {
    yesOrNo "Install vim config"

    if [[ "${YESORNO}" = "${TRUE}" ]];
    then
        echo "Installing vim config..."

        rm -rf ${HOME}/.vimrc
        ln -s ${_rootwd}/vim/vimrc ${HOME}/.vimrc

        echo "Done."
    fi
}

installZsh
installPowerLine
installVim

# install.sh ends here.
