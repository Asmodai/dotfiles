# Only care for this if it's not already set.
if [[ "x${STARSHIP_DATA}" == "x" ]]
then
    STARSHIP_DATA=/usr/local/share/starship
    export STARSHIP_DATA
fi

_starship=$(which starship 2>/dev/null)

if [[ -f "${_starship}" ]]
then
    _colors=$(tput colors)
    case ${_colors} in
        256) STARSHIP_CONFIG=${STARSHIP_DATA}/starship.toml      ;;
        16)  STARSHIP_CONFIG=${STARSHIP_DATA}/starship-16.toml   ;;
        8)   STARSHIP_CONFIG=${STARSHIP_DATA}/starship-8.toml    ;;
        *)   STARSHIP_CONFIG=${STARSHIP_DATA}/starship-mono.toml ;;
    esac

    export STARSHIP_CONFIG

    eval "$(${_starship} init zsh)"
fi

unset _starship
