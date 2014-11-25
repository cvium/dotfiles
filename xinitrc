#!/bin/sh

##### STANDARD STUFF
# screen powersave
xset +dpms
xset dpms 0 0 300
setxkbmap -layout dk
#sh ~/.fehbg &
xbindkeys

bg="/home/claus/Downloads/arch2.png"

# Gnome wants to control the cursor, I say no
gsettings set org.gnome.settings-daemon.plugins.cursor active false

# Natural Scrolling
gsettings set org.gnome.settings-daemon.peripherals.touchpad natural-scroll true

##### SET DPI STUFF
if [ "$1" == "retina" ]; then
  echo "Configuring retina dpi settings..."
  
  [[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

  # firefox
  scale="1.8"
  
  # Cursor
  xsetroot -xcf /usr/share/icons/Vanilla-DMZ/cursors/left_ptr 64 &
  
  # not necessary, but whatever
  #xrandr --dpi 220
  
  # scale 
  gsettings set org.gnome.desktop.interface scaling-factor 2 
  
  feh --bg-fill "$bg" &
  # session
  s="xmonad"
elif [ "$1" == "downscale" ]; then
  echo "Configuring downscaled dpi settings.."
  
  [[ -f ~/.Xresources_ds ]] && xrdb -merge ~/.Xresources_ds
  
  # firefox
  scale="-1"

  # scale 
  gsettings set org.gnome.desktop.interface scaling-factor 1 
  
  # cursor
  xsetroot -xcf /usr/share/icons/Vanilla-DMZ/cursors/left_ptr 16 &
  
  monitor=`xrandr | grep -i edp | cut -d " " -f 1`
  xrandr --newmode "1440x900_60.00" 106.50 1440 1528 1672 1904 900 903 909 934 -hsync +vsync
  xrandr --addmode $monitor 1440x900_60.00
  xrandr --output $monitor --mode 1440x900_60.00
  #xrandr --output $monitor --scale 0.5625x0.5625
 
  feh --bg-fill "$bg" &
  # session
  s="xmonad"
else
  printf "\nPlease choose retina or downscale..."
  
  exit 1

fi

# scale firefox
file="prefs"
if [[ -f ~/.mozilla/firefox/*.default/user.js ]]; then
  file="user"
elif [[ -f ~/.mozilla/firefox/*.default/prefs.js ]]; then
  file="prefs"
fi

sed -i -e 's/user_pref("layout.css.devPixelsPerPx.*/user_pref("layout.css.devPixelsPerPx", "'"$scale"'");/' ~/.mozilla/firefox/*.default/"$file".js

exec gnome-session --session="$s"
