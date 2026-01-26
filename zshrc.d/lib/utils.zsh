#!/usr/bin/env zsh
# -*- Mode: Shell-script -*-
#
# utils.zsh --- Various utilities.
#
# Copyright (c) 2016-2025 Paul Ward <asmodai@gmail.com>
#
# Author:     Paul Ward <asmodai@gmail.com>
# Maintainer: Paul Ward <asmodai@gmail.com>
# Created:    17 Aug 2016 19:24:43
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

. ${ZSH}/lib/defns.zsh

# Get version from the Linux Standard Base.
function getLSB () {
    if [[ -f /usr/bin/lsb_release ]];
    then
        echo $(/usr/bin/lsb_release -i | awk '{ print $3 }')

        return
    fi

    echo ${FALSE}
}

# Get the underlying distribution.
function getDistro() {
    local gotLSB=$(getLSB)

    if [[ ! "${gotLSB}" = "${FALSE}" ]]
    then
        echo "${gotLSB}"
    else
        local releases=(/etc/*-release)

        case "${(j: :)releases}" in
            (*almalinux*) echo "AlmaLinux" ;;
            (*rocky*)     echo "Rocky"     ;;
            (*centos*)    echo "CentOS"    ;;
            (*redhat*)    echo "RedHat"    ;;
            (*)           echo "Unknown"   ;;
        esac
    fi
}

# Is the distro derived from RedHat?
function isRedHat () {
    local distro=$(getDistro)

    case $distro in
        AlmaLinux) echo ${TRUE}  ;;
        Rocky)     echo ${TRUE}  ;;
        CentOS)    echo ${TRUE}  ;;
        RedHat)    echo ${TRUE}  ;;
        *)         echo ${FALSE} ;;
    esac
}

# Is the distro equal to the given one?
function isDistro () {
    [[ "$(getDistro)" = "$1" ]] && echo ${TRUE} || echo ${FALSE}
}

# utils.zsh ends here.
