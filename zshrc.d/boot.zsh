#!/usr/bin/env zsh
# -*- Mode: Shell-script -*-
#
# boot.zsh --- Bootup script.
#
# Copyright (c) 2016 Paul Ward <asmodai@gmail.com>
#
# Author:     Paul Ward <asmodai@gmail.com>
# Maintainer: Paul Ward <asmodai@gmail.com>
# Created:    15 Aug 2016 19:58:12
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

if [ "${DISABLE_AUTO_UPDATE}" != 'true' ];
then
    /usr/bin/env ZSH=$ZSH DISABLE_UPDATE_PROMPT=${DISABLE_UPDATE_PROMPT} zsh -f ${ZSH}/tools/check_for_update.zsh
fi

# Check if there's a ${HOME}/.local/bin
if [ -t "${HOME}/.local/bin" ]
then
    export PATH="${HOME}/.local/bin:${PATH}"
fi

# Add a function path.
fpath=(${ZSH}/functions ${ZSH}/completions ${fpath})

# Load all stock stuff.
autoload -U compaudit compinit

# Where should we cache stuff?
if [[ -z "${ZSH_CACHE_DIR}" ]];
then
    ZSH_CACHE_DIR="${ZSH}/cache"
fi

# Custom overrides
if [[ -z "${ZSH_CUSTOM}" ]];
then
    ZSH_CUSTOM="${ZSH}/custom"
fi

# Load all config files
for config (${ZSH}/lib/*.zsh);
do
    custom="${ZSH_CUSTOM}/lib/${config:t}"

    [ -f "${custom}" ] && config=${custom}

    source $config
done
unset config

function isPlugin () {
    local base=$1
    local name=$2

    test -f ${base}/plugins/${name}/${name}.plugin.zsh \
         || test -f ${base}/plugins/${name}/_${name}
}

function listPlugins () {
  local base=$1
  typeset -a dirs

  if [ -z ${base} ]
  then
      echo "No argument provided!"
      return
  fi
  
  for i in $(ls -d ${base}/plugins/*);
  do
    dirs+=`basename $i`
  done

  echo ${(j: :)dirs}
}


# Add all defined plugins.
for plugin ($(listPlugins "${ZSH}"));
do
    if isPlugin ${ZSH_CUSTOM} ${plugin};
    then
        fpath=(${ZSH_CUSTOM}/plugins/${plugin} ${fpath})
    elif isPlugin ${ZSH} ${plugin};
    then
        fpath=(${ZSH}/plugins/${plugin} ${fpath})
    fi
done

# Get our short hostname.
if [[ "${OSTYPE}" = darwin* ]];
then
    SHORT_HOST=$(scutil --get ComputerName 2>/dev/null) || SHORT_HOST=${HOST/.*/}
else
    SHORT_HOST=${HOST/.*/}
fi

if [ -z "${ZSH_COMPDUMP}" ];
then
    ZSH_COMPDUMP="${ZROOTDIR:-${HOME}}/.zcompdump-${SHORT_HOST}-${ZSH_VERSION}"
fi

if [[ ${ZSH_DISABLE_COMPFIX} != true ]];
then
    if !compaudit &>/dev/null;
    then
        handle_completion_insecurities
    else
        compinit -d "${ZSH_COMPDUMP}"
    fi
else
    compinit -i -d "${ZSH_COMPDUMP}"
fi

# Load all of the plugins given in .zshrc
for plugin ($(listPlugins "${ZSH}"));
do
    cfile=${ZSH_CUSTOM}/plugins/${plugin}/${plugin}.plugin.zsh
    bfile=${ZSH}/plugins/${plugin}/${plugin}.plugin.zsh

    if [ -f ${cfile} ];
    then
        source ${nfile}
    elif [ -f ${bfile} ];
    then
        source ${bfile}
    fi
done

# Try to load custom configs
for config (${ZSH_CUSTOM}/*.zsh(N));
do
    source $config
done
unset config

# boot.zsh ends here.
