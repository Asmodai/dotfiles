#!/usr/bin/env zsh
# -*- Mode: Shell-script -*-
#
# package.zsh --- Package utilities.
#
# Copyright (c) 2016-2025 Paul Ward <asmodai@gmail.com>
#
# Author:     Paul Ward <asmodai@gmail.com>
# Maintainer: Paul Ward <asmodai@gmail.com>
# Created:    17 Aug 2016 20:20:43
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

typeset -A PLUGINS

function pluginAdd () {
    local name="$1"
    local text="$2"

    PLUGINS[$name]="${text}"
}

function pluginList () {
    local color=${FALSE}
    local output=""

    if [ "$1" ];
    then
      color=${TRUE}
    fi

    for key in "${(@k)PLUGINS}";
    do
        local k=$(echo -ne $key)

        if [ "${color}" = "${TRUE}" ]
        then
            # TODO: This should be written.
            output="${output}   :$k:${PLUGINS[$k]}\n"
        else
            output="${output}   :$k:${PLUGINS[$k]}\n"
        fi
    done

    if [[ ! "${output}" = "" ]];
    then
        echo -ne "${output}" | column -t -s ':' -c 80
    fi
}

# package.zsh ends here.
