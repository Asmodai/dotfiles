if [ -d /usr/share/themes ]
then
  #export GTK2_RC_FILES=/usr/share/themes/Numix/gtk-2.0/gtkrc
  #export GTK_THEME=Numix:dark
  #export GTK2_RC_FILES=/home/asmodai/.themes/MyDark/gtk-2.0/gtkrc
  #export GTK_THEME=MyDark

  # Let KDE handle all this.
  unset GTK_RC_FILES
  unset GTK2_RC_FILES
  unset GTK_THEME
fi
