# screen powersave
xset +dpms
xset dpms 0 0 300
xsetroot -xcf /usr/share/icons/Vanilla-DMZ/cursors/left_ptr 64 &
#xsetroot -cursor_name left_ptr
setxkbmap -layout dk
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources
# xcompmgr -c &
sh ~/.fehbg &
xbindkeys
#monitor=`xrandr | grep -i edp | cut -d " " -f 1`
#xrandr --newmode "1440x900_60.00" 106.50 1440 1528 1672 1904 900 903 909 934 -hsync +vsync
#xrandr --addmode $monitor 1440x900_60.00
#xrandr --output $monitor --mode 1440x900_60.00
#exec xmonad
gsettings set org.gnome.desktop.interface scaling-factor 2 

# Gnome wants to control the cursor, I say no
gsettings set org.gnome.settings-daemon.plugins.cursor active false

#gsettings set org.gnome.desktop.interface text-scaling-factor 1.2
#exec xmonad
exec gnome-session --session=xmonad
#exec gnome-session --session=xmonad-gnome #xmonad-gnome-session
#dbus-launch --exit-with-session xmonad
