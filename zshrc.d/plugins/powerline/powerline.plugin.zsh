# -*- Mode: Shell-script -*-
#
# powerline.plugin.zsh --- powerline (PowerLine) theme.
#
# Copyright (c) 2016 Paul Ward <asmodai@gmail.com>
#
# Author:     Paul Ward <asmodai@gmail.com>
# Maintainer: Paul Ward <asmodai@gmail.com>
# Created:    17 Mar 2016 00:04:58
# Keywords:   
# URL:        not distributed yet
#
# {{{ License:
#
# This program is free software: you can redistribute it
# and/or modify it under the terms of the GNU General Public
# Licenseas published by the Free Software Foundation,
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

() {
    local _pip=''

    LC_ALL=""
    LC_CTYPE="en_GB.UTF-8"
#    POWERLINE_PATH="${ZSH_CUSTOM}/plugins/powerline"

    if [[ "${OSTYPE}" = darwin* ]]
    then
        _pip="/opt/local/bin/pip"

        # Because Apple.
        test -f /usr/local/bin/pip && _pip="/usr/local/bin/pip"
    else
        _pip="pip"
    fi

    POWERLINE_LIB=`${_pip} show powerline-status | grep "^Location:" | awk '{ print $2 }'`

    case "${OSTYPE}" in
        darwin*)
            POWERLINE_PATH="${HOME}/Library/Python/2.7/bin"
            test -f  /usr/local/bin/powerline-daemon && POWERLINE_PATH="/usr/local/bin"
            ;;
        *)
            POWERLINE_PATH="/usr/local/bin"
            test -f /bin/powerline-daemon && POWERLINE_PATH="/bin"
            ;;
    esac
    

    ps auxw | grep powerline | grep -v grep >/dev/null 2>&1
    if [ $? -ne 0 ]
    then
        $POWERLINE_PATH/powerline-daemon -q
    fi

    source $POWERLINE_LIB/powerline/bindings/zsh/powerline.zsh
}

# Invoke poerline-zsh
#powerline_prompt() {
#    RETVAL=$?
    #export PROMPT="$(${POWERLINE_PATH}/powerline-zsh.py -m konsole $RETVAL)"
#}

# Generate prompt.
#precmd_functions+=(powerline_prompt)

# powerline.plugin.zsh ends here
