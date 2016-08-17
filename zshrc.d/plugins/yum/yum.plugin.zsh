#!/usr/bin/env zsh
# -*- Mode: Shell-script -*-
#
# yum.plugin.zsh --- Yum plugin.
#
# Copyright (c) 2016 Paul Ward <asmodai@gmail.com>
#
# Author:     Paul Ward <asmodai@gmail.com>
# Maintainer: Paul Ward <asmodai@gmail.com>
# Created:    15 Aug 2016 20:42:41
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

. ${ZSH}/lib/utils.zsh

if [[ "$(isDistro CentOS)" = "${TRUE}" ]];
then
    alias ys="yum search"
    alias yp="yum info"
    alias yl="yum list"
    alias ygl="yum grouplist"
    alias yli="yum list installed"
    alias ymc="yum makecache"

    alias yu="sudo yum update"
    alias yi="sudo yum install"
    alias ygi="sudo yum groupinstall"
    alias yr="sudo yum remove"
    alias ygr="sudo yum groupremove"
    alias yrl="sudo yum remove --remove-leaves"
    alias yc="sudo yum clean all"
else
    echo "The Yum module will not work on $(getDistro)."
fi

# yum.plugin.zsh ends here.
