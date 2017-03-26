#!/bin/bash

xrdb -merge ~/.Xdefaults

export GTK2_RC_FILES=/home/asmodai/.themes/MyDark/gtk-2.0/gtkrc
export GTK_THEME=MyDark

case ${1} in
    start)
        compton -bcGC                            \
                --backend glx --vsync opengl-swc \
                --config /home/asmodai/.fvwm/compton               2>/dev/null &
        hsetroot -fill /home/asmodai/Pictures/Wallpapers/Backdrop.jpg
        xscreensaver -no-splash                                    2>/dev/null &
        dunst                                                      2>/dev/null &
        gnome-settings-daemon                                      2>/dev/null &
        xfce4-power-manager                                        2>/dev/null &
        pasystray                                                  2>/dev/null &
        /usr/bin/conky -c /home/asmodai/.conky/conkyrc             2>/dev/null &
        nm-applet                                                  2>/dev/null &
        plank                                                      2>/dev/null &
        gtk-redshift                                               2>/dev/null &
        synapse -s                                                 2>/dev/null &
        dropbox start                                              2>/dev/null &
        ;;
    stop)
        killall xscreensaver                                       2>/dev/null
        killall compton                                            2>/dev/null
        killall conky                                              2>/dev/null
        killall pasystray                                          2>/dev/null
        killall nm-applet                                          2>/dev/null
        killall plank                                              2>/dev/null
        killall gtk-redshift                                       2>/dev/null
        killall redshift                                           2>/dev/null
        killall synapse                                            2>/dev/null
        ;;
    restart)
        ./startup.sh stop
        ./startup.sh start
        ;;
    *)
        echo "Huh?"
        ;;
esac

