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

# EOF
