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

installZsh() {
    yesOrNo "Install ZSH doftiles"

    if [[ "${YESORNO}" = "${TRUE}" ]]
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

    if [[ "${YESORNO}" = "${TRUE}" ]]
    then
        echo "Installing PowerLine..."

        pip install powerline-gitstatus
        pip install powerline-status

        echo "Installing PowerLine config..."

        rm -rf ${HOME}/.config/powerline 2>/dev/null
        ln -s ${_rootwd}/powerline ${HOME}/.config/powerline

        echo "Done."
    fi
}

installVim() {
    yesOrNo "Install vim config"

    if [[ "${YESORNO}" = "${TRUE}" ]]
    then
        echo "Installing vim config..."

        rm -rf ${HOME}/.vimrc

        case $(uname -s) in
            Darwin*) ln -s ${_rootwd}/vim/vimrc.macos ${HOME}/.vimrc;;
            *)       ln -s ${_rootwd}/vim/vimrc ${HOME}/.vimrc;;
        esac

        echo "Done."
    fi
}

installX11() {
    yesOrNo "Install X11 configs"

    if [[ "${YESORNO}" = "${TRUE}" ]]
    then
        echo "Installing X11 configs..."

        rm -rf ${HOME}/.Xdefaults
        rm -rf ${HOME}/.xsessionrc

        ln -s ${_rootwd}/X11/Xdefaults  ${HOME}/.Xdefaults
        ln -s ${_rootwd}/X11/xsessionrc ${HOME}/.xsessionrc

        echo "Done."
    fi
}

installThemes() {
    yesOrNo "Install themes"

    if [[ "${YESORNO}" = "${TRUE}" ]]
    then
        echo "Installing themes..."

        rm -rf ${HOME}/.themes/MyDark
        rm -rf ${HOME}/.xsessionrc
        rm -rf ${HOME}/.config/qt5ct

        mkdir -p ${HOME}/.themes
        ln -s ${_rootwd}/X11/themes/gtk/MyDark ${HOME}/.themes/MyDark
        ln -s ${_rootwd}/X11/themes/qt5ct      ${HOME}/.config/qt5ct
        ln -s ${_rootwd}/X11/xsessionrc        ${HOME}/.xsessionrc

        echo "Done."
    fi
}

installPlank() {
    yesOrNo "Install Plank config"

    if [[ "${YESORNO}" = "${TRUE}" ]]
    then
        echo "Installing Plank config..."

        rm -rf ${HOME}/.local/share/plank/themes 2>/dev/null
        mkdir -p ${HOME}/.local/share/plank/themes
        ln -s ${_rootwd}/X11/plank/Hacker ${HOME}/.local/share/plank/themes/

        echo "Done."
    fi
}

installSynapse() {
    yesOrNo "Install synapse config"

    if [[ "${YESORNO}" = "${TRUE}" ]]
    then
        echo "Installing synapse config..."

        rm -rf ${HOME}/.config/synapse
        mkdir -p ${HOME}/.config
        ln -s ${_rootwd}/X11/synapse ${HOME}/.config/synapse

        echo "Done."
    fi
}

installFVWM() {
    yesOrNo "Install FVWM config"

    if [[ "${YESORNO}" = "${TRUE}" ]]
    then
        echo "Installing FVWM config..."

        rm -rf ${HOME}/.fvwm
        ln -s ${_rootwd}/X11/fvwm ${HOME}/.fvwm

        echo "Done."
    fi
}

installCDE() {
    yesOrNo "Install CDE configs"

    if [[ "${YESORNO}" = "${TRUE}" ]]
    then
        echo "Installing CDE configs..."

        rm -rf ${HOME}/.dtprofile
        ln -s ${_rootwd}/X11/cde/dtprofile ${HOME}/.dtprofile

        echo "Done."
    fi
}

installKDE() {
    yesOrNo "Install KDE settings"

    if [[ "${YESORNO}" = "${TRUE}" ]]
    then
        ${_rootwd}/installkde.sh
    fi
}

installConky() {
    yesOrNo "Install Conky configs"

    if [[ "${YESORNO}" = "${TRUE}" ]]
    then
        echo "Installing Conky config..."
        rm -rf ${HOME}/.conky 2>/dev/null
        mkdir -p ${HOME}/bin 2>/dev/null
        ln -s ${_rootwd}/X11/conky ${HOME}/.conky
        ln -s ${_rootwd}/X11/conky/conky ${HOME}/bin/
        echo "Done."
    fi
}

installStalonetray() {
    yesOrNo "Install stalonetray config"

    if [[ "${YESORNO}" = "${TRUE}" ]]
    then
        echo "Installing stalonetray config..."
        rm -rf ${HOME}/.stalonetrayrc
        ln -s ${_rootwd}/X11/stalonetray/rc ${HOME}/.stalonetrayrc
        echo "Done."
    fi
}

installFonts() {
    yesOrNo "Install fonts"

    if [[ "${YESORNO}" = "${TRUE}" ]]
    then
        echo "Installing fonts..."
        bash X11/fonts/install.sh
        echo "Done."
    fi
}

installZsh
installPowerLine
installVim

installX11
installFonts
installThemes
test -f /usr/bin/plank && installPlank
test -f /usr/bin/fvwm2 && installFVWM
test -f /usr/bin/conky && installConky
test -f /usr/bin/stalonetray && installStalonetray
test -f /usr/bin/synapse && installSynapse
test -d /usr/dt && installCDE
test -d ${HOME}/.kde/ && installKDE

# install.sh ends here.
