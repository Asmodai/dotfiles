# -*- Mode: Shell-Script -*-

if [ -d "${HOME}/.rbenv" ]
then
  PATH="${HOME}/.rbenv/bin:$PATH"
  export PATH

  eval "$(rbenv init -)"
fi

if [ -d "${HOME}/.rbenv/plugins/ruby-build" ]
then
  PATH="${HOME}/.rbenv/plugins/ruby-build/bin:$PATH"
  export PATH
fi

# Check for Ruby Version Manager
if [ -f ${HOME}/.rvm/scripts/rvm ];
then
    export PATH=${PATH}:${HOME}/.rvm/bin

    source ${HOME}/.rvm/scripts/rvm
fi

# ruby.plugin.zsh ends here.
