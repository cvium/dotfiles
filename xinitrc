#!/bin/sh

##### STANDARD STUFF
# screen powersave
xset +dpms
xset dpms 0 0 300
setxkbmap -layout dk

xbindkeys

bg="/home/claus/Downloads/arch2.png"

# Gnome wants to control the cursor, I say no
gsettings set org.gnome.settings-daemon.plugins.cursor active false

# Natural Scrolling
gsettings set org.gnome.settings-daemon.peripherals.touchpad natural-scroll true
gsettings set org.gnome.settings-daemon.peripherals.touchpad disable-while-typing true

# Tap to click
gsettings set org.gnome.settings-daemon.peripherals.touchpad tap-to-click true

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

  # text scale 
  gsettings set org.gnome.desktop.interface text-scaling-factor 1.2 
elif [ "$1" == "downscale" ]; then
  echo "Configuring downscaled dpi settings.."
  
  [[ -f ~/.Xresources_ds ]] && xrdb -merge ~/.Xresources_ds
  
  # firefox
  scale="-1"

  # scale 
  gsettings set org.gnome.desktop.interface scaling-factor 1 
  
  # text scale
  gsettings set org.gnome.desktop.interface text-scaling-factor 1
  
  # cursor
  xsetroot -xcf /usr/share/icons/Vanilla-DMZ/cursors/left_ptr 16 &
  
  monitor=`xrandr | grep -i edp | cut -d " " -f 1`
  xrandr --newmode "1440x900_60.00" 106.50 1440 1528 1672 1904 900 903 909 934 -hsync +vsync
  # cvt 1280 800 -> 1280x800 59.81 Hz (CVT 1.02MA) hsync: 49.70 kHz; pclk: 83.50 MHz
  xrandr --newmode "1280x800_60.00" 83.50  1280 1352 1480 1680  800 803 809 831 -hsync +vsync
  xrandr --addmode $monitor 1440x900_60.00
  xrandr --addmode $monitor 1280x800_60.00
  xrandr --output $monitor --mode 1280x800_60.00
  #xrandr --output $monitor --mode 1440x900_60.00
  #xrandr --output $monitor --scale 0.5625x0.5625
 
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

# Scale firefox depending on dpi
sed -i -e 's/user_pref("layout.css.devPixelsPerPx.*/user_pref("layout.css.devPixelsPerPx", "'"$scale"'");/' ~/.mozilla/firefox/*.default/"$file".js

feh --bg-fill "$bg" &
exec gnome-session --session=xmonad
