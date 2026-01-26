# http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html
# http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html#Zle-Builtins
# http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html#Standard-Widgets

# Make sure that the terminal is in application mode when zle is active, since
# only then values from $terminfo are valid
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} ))
then
    function zle-line-init() {
        echoti smkx
    }

    function zle-line-finish() {
        echoti rmkx
    }

    zle -N zle-line-init
    zle -N zle-line-finish
fi

# Use Emacs key bindings.
bindkey -e

# E-w - Kill from the cursor to the mark.
bindkey '\ew' kill-region

# E-l - Run `ls'.
bindkey -s '\el' 'ls\n'

# C-r - Search backward incrementally.
bindkey '^r' history-incremental-search-backward

# PgUp - Move up a line or move up in history.
if [[ "${terminfo[kpp]}" != "" ]]
then
    bindkey "${terminfo[kpp]}" up-line-or-history
fi

# PgDn - Move down a line or move down in history.
if [[ "${terminfo[knp]}" != "" ]]
then
    bindkey "${terminfo[knp]}" down-line-or-history
fi

# Typing + [Up-Arrow] - Fuzzy find history forward
if [[ "${terminfo[kcuu1]}" != "" ]]
then
    autoload -U up-line-or-beginning-search
    zle -N up-line-or-beginning-search

    bindkey "${terminfo[kcuu1]}" up-line-or-beginning-search
fi

# Typing + [Down-Arrow] - Fuzzy find history backward
if [[ "${terminfo[kcud1]}" != "" ]]
then
    autoload -U down-line-or-beginning-search
    zle -N down-line-or-beginning-search

    bindkey "${terminfo[kcud1]}" down-line-or-beginning-search
fi

# Home - Go to beginning of line.
if [[ "${terminfo[khome]}" != "" ]]
then
    bindkey "${terminfo[khome]}" beginning-of-line
fi

# End - Go to end of line.
if [[ "${terminfo[kend]}" != "" ]]
then
    bindkey "${terminfo[kend]}" end-of-line
fi

# Space - Do history expansion.
bindkey ' ' magic-space

# C-RightArrow - Move forward one word.
bindkey '^[[1;5C' forward-word

# C-LeftArrow - Move backward one word.
bindkey '^[[1;5D' backward-word

# Sh-Tab - Move through completion menu backwards.
if [[ "${terminfo[kcbt]}" != "" ]]
then
    bindkey "${terminfo[kcbt]}" reverse-menu-complete
fi

# Backspace - Backward delete character.
bindkey '^?' backward-delete-char

# Delete - Forward delete character.
if [[ "${terminfo[kdch1]}" != "" ]]
then
    bindkey "${terminfo[kdch1]}" delete-char
else
    bindkey "^[[3~" delete-char
    bindkey "^[3;5~" delete-char
    bindkey "\e[3~" delete-char
fi

# C-x C-e - Edit the current command line in $EDITOR
autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line

# C-m - File rename magick
bindkey "^[m" copy-prev-shell-word

# F15 (Help) - Run help
bindkey "^[[28~" run-help

# F16 (Do) - Edit comand line.
bindkey "^[[29~" edit-command-line

# Gold key
PF1_MOD='\eOP'

# Insert a `--' sequence.
_gold_key_hyphen_widget() {
    BUFFER="--"
}

# Descripe Gold Mode(tm).
_gold_key_describe_widget() {
    BUFFER=""
    CURSOR=0

    bindkey -L | grep --color=never '\[OP' | less
    zle reset-prompt
}

# Reload zsh configuration.
_gold_key_recalc_widget() {
    zle accept-line
    BUFFER="source ~/.zshrc"
    zle accept-line
}

# Insert current time/date.
_gold_key_date_widget() {
    BUFFER="$(date)"
}

# Invoke our custom ZSH statistics command.
_gold_key_status_widget() {
    zle accept-line

    BUFFER="zsh_stats"
    zle accept-line
}

# Set up widgets.
zle -N gold-key-describe _gold_key_describe_widget
zle -N gold-key-hyphen   _gold_key_hyphen_widget
zle -N gold-key-recalc   _gold_key_recalc_widget
zle -N gold-key-date     _gold_key_date_widget
zle -N gold-key-status   _gold_key_status_widget

# `Gold key' mappings.
bindkey '\eOQ' redisplay                     # PF2 (Page)          - Redisplay.
bindkey '\eOR' delete-word                   # PF3 (Del Word)      - Delete word.
bindkey '\eOS' delete-char                   # PF4 (Del Char)      - Delete character.
#                                              F11 (Lock)          - No mapping.
#                                              F12 (Hyph Pull)     - No mapping.
#                                              F13 (Rub Sent)      - No mapping.
bindkey "${PF1_MOD}\-" gold-key-hyphen       # - (Print Hyph)      - Send `--'
#                                              = (Abbrv)           - No mapping.
bindkey "${PF1_MOD}\b" kill-whole-line       # BS (Rub Line)       - Kill whole line.
bindkey "${PF1_MOD}q"  end-of-line           # q (Superscript)     - End of Line.
#                                              w (Write Docmt)     - No mapping.
#                                              r (Ruler)           - No mapping.
bindkey "${PF1_MOD}t" beginning-of-buffer    # t (Top Docmt)       - Beginning of Buffer.
#                                              y (Footnote)        - No mapping.
#                                              u (UDP)             - No mapping.
#                                              p (Page Marker)     - No mapping.
bindkey "${PF1_MOD}[" edit-command-line      # [ (Cmd)             - Edit Command Line.
#                                              ] (Change Editor)   - No mapping.
bindkey "${PF1_MOD}a" beginning-of-line      # a (Subscript)       - Beginning of line.
bindkey "${PF1_MOD}s" spell-word             # s (Spell Check)     - Spell Word.
#                                              d (Dead Key)        - No mapping.
#                                              f (File Docmt)      - No mapping.
#                                              g (Get Docmt)       - No mapping.
bindkey "${PF1_MOD}h" gold-key-describe      # h (Help)            - Describe mode.
#                                              j (Lang Aids)       - No mapping.
#                                              k (Quit Docmt)      - No mapping.
#                                              l (Libry)           - No mapping.
bindkey "${PF1_MOD};" global-history-replace # ; (Global Rplac)    - Replace history.
bindkey "${PF1_MOD}'" gold-key-recalc        # ' (Recalc)          - Reload .zshrc
bindkey "${PF1_MOD}\\" gold-key-date         # \ (Date & Time)     - Insert date/time.
bindkey "${PF1_MOD}^M" set-mark-command      # Enter (Para Marker) - Set mark.
bindkey "${PF1_MOD}z" gold-key-status        # z (Status)          - ZSH statistics.
#                                              c (Center)          - No mapping.
bindkey "${PF1_MOD}v" where-is               # v (View)            - Where Is.
bindkey "${PF1_MOD}b" end-of-buffer          # b (Bot Docmt)       - End of Buffer.
#                                              n (New Page)        - No mapping.
bindkey "${PF1_MOD}m" menu-complete          # m (Menu)            - Menu Complete.

bindkey "${PF1_MOD}," history-incremental-search-backward # , (Srch) - Hist srch back.
bindkey "${PF1_MOD}." history-incremental-search-forward # . (Cont Src) - Hist srch fwd.
bindkey "${PF1_MOD}/" accept-and-menu-complete # / (Cont Srch & Sel) - Accept / menu complete.

# EOF
