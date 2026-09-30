#!/usr/bin/env zsh
# -*- Mode: Shell-script -*-
#
# 00macOS.zsh --- macOS hackery.
#
# Copyright (c) 2026 Paul Ward <paul@lisphacker.uk>
#
# Author:     Paul Ward <paul@lisphacker.uk>
# Maintainer: Paul Ward <paul@lisphacker.uk>
# Created:    23 Sep 2026 12:23:59
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

# Check that we are using macOS.
if [[ "$(getDistro)" == "macOS" ]]
then
    # Check if our local Unix folder exists.
    if [[ ! -d "${HOME}/Unix" ]]
    then
        echo "No UNIX"
        return
    fi

    # Check for binaries directory.
    if [[ -d "${HOME}/Unix/bin" ]]
    then
        PATH="${HOME}/Unix/bin:${PATH}"
        export PATH
    fi

    # Check for Go binaries.
    if [[ -d "${HOME}/Unix/go/bin" ]]
    then
        GOROOT="${HOME}/Unix/go"
        export GOROOT

        PATH="${HOME}/Unix/go/bin:${PATH}"
        export PATH
    fi

    # Override starship data if present
    if [[ -d "${HOME}/Unix/share/starship" ]]
    then
        STARSHIP_DATA="${HOME}/Unix/share/starship"
        export STARSHIP_DATA
    fi
fi

# 00macOS.zsh ends here.
