if [ -x '/opt/local/bin/php' ];
then
  alias php="/opt/local/bin/php"
fi

if [ -d "${HOME}/.config/composer/vendor/bin" ];
then
    PATH=$PATH:${HOME}/.config/composer/vendor/bin
    export PATH
fi

if [ -d "${HOME}/.phpbrew" ];
then
    source ${HOME}/.phpbrew/bashrc
fi
