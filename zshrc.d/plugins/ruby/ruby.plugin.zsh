# -*- Mode: Shell-script -*-

# Check for Ruby Version Manager
if [ -f ${HOME}/.rvm/scripts/rvm ];
then
    export PATH=${PATH}:${HOME}/.rvm/bin

    source ${HOME}/.rvm/scripts/rvm
fi

# ruby.plugin.zsh ends here.
