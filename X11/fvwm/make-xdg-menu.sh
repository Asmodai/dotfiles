#!/bin/bash

/usr/local/bin/fvwm-menu-desktop                       \
    --regen-cmd XDGRegen                               \
    --enable-mini-icons                                \
    --theme "gnome"                                    \
    --set-menus /etc/xdg/menus/kf5-applications.menu \
    --size 16                                          \
    --app-icon openterm                                \
    --title "Applications"                             \
    >${FVWM_USERDIR:-"/home/asmodai/.fvwm"}/.XDGMenu   \
    #2>/dev/null

echo "Nop"
