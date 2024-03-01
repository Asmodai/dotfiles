#!/usr/bin/env zsh
# -*- Mode: Shell-script -*-
#
# utils.zsh --- Various utilities.
#
# Copyright (c) 2016 Paul Ward <asmodai@gmail.com>
#
# Author:     Paul Ward <asmodai@gmail.com>
# Maintainer: Paul Ward <asmodai@gmail.com>
# Created:    17 Aug 2016 19:24:43
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

. ${ZSH}/lib/defns.zsh

function getRHEL () {
    test -f /etc/redhat-release && echo $TRUE || echo $FALSE
}

function getCentOS () {
    test -f /etc/centos-release && echo $TRUE || echo $FALSE
}

function getLSB () {
    if [[ -f /usr/bin/lsb_release ]];
    then
        echo $(/usr/bin/lsb_release -i | awk '{ print $3 }')
        return
    fi

    echo ${FALSE}
}

function getDistro () {
    local gotCentOS=$(getCentOS)
    local gotRHEL=$(getRHEL)
    local gotDebian=$(getLSB)
    local distro=

    if [ ${gotCentOS} = ${TRUE} ];
    then
        distro="CentOS"
    elif [ ${gotRHEL} = ${TRUE} ];
    then
        distro="RedHat"
    elif [ ! ${gotDebian} = ${FALSE} ];
    then
        distro=${gotDebian}
    else
        distro="unknown"
    fi

    echo ${distro}
}

function isRedHat () {
    local distro=$(getDistro)

    case $distro in
        RedHat)    echo ${TRUE}  ;;
        CentOS)    echo ${TRUE}  ;;
        *)         echo ${FALSE} ;;
    esac
}

function isDistro () {
    [[ "$(getDistro)" = "$1" ]] && echo ${TRUE} || echo ${FALSE}
}

# utils.zsh ends here.
