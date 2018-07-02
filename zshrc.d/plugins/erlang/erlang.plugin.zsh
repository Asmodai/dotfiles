# -*- mode: shell-script -*-

typeset -A erlcmds
erlcmds=()

check_erlang()
{
    local dir="$1"

    if [ -f "${dir}/activate" ]
    then
        erlcmds[$(basename ${dir})]="${dir}/activate"
    fi
}

set_erlang_aliases()
{
    for k in "${(@k)erlcmds}"
    do
        alias erlang$k="source $erlcmds[$k]"
    done
}

set_default_erlang()
{
    if [ -n "${ERLANG_VERSION}" ]
    then
        if (( $+erlcmds[${ERLANG_VERSION}] ))
        then
            source $erlcmds[${ERLANG_VERSION}]
        else
            echo "Could not find kerl install for Erlang ${ERLANG_VERSION}"
        fi
    fi
}

if [ -d ~/erlang ]
then
  export KERL_CONFIGURE_OPTIONS="--enable-smp-support \
                                 --enable-threads     \
                                 --enable-kernel-poll \
                                 --enable-hipe        \
                                 --enable-m64-build"
  export KERL_CONFIGURE_DISABLE_APPLICATIONS=odbc
  export KERL_BUILD_BACKEND=git
  export OTP_GITHUB_URL="https://github.com/erlang/otp"

  for erldir in $(ls -d ~/erlang/*)
  do
      check_erlang ${erldir}
  done
  set_erlang_aliases


  export ERLANG_VERSION="20.1.7.1"
  set_default_erlang
fi
