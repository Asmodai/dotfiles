STARSHIP_DATA=/usr/local/share/starship
export STARSHIP_DATA

_starship=$(which starship 2>/dev/null)

if [[ -f "${_starship}" ]]
then
    _colors=$(tput colors)
    case ${_colors} in
        256) STARSHIP_CONFIG=${STARSHIP_DATA}/starship.toml    ;;
        *)   STARSHIP_CONFIG=${STARSHIP_DATA}/starship-16.toml ;;
    esac

    export STARSHIP_CONFIG

    eval "$(${_starship} init zsh)"
fi

unset _starship
