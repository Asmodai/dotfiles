#!/bin/bash
# -*- Mode: Shell-script -*-
#
# get_ext_ip.sh --- Get external IP.
#
# Copyright (c) 2017 Paul Ward <asmodai@gmail.com>
#
# Author:     Paul Ward <asmodai@gmail.com>
# Maintainer: Paul Ward <asmodai@gmail.com>
# Created:    10 Mar 2017 08:41:05
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

nc -z 8.8.8.8 53 >/dev/null 2>&1
if [ $? -eq 0 ]
then
    curl -s -k http://api.ipify.org
else
    echo "Not connected"
fi

# get_ext_ip.sh ends here.
