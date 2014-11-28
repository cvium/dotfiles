-- xmobar config used by Cedric Fung on 15" rMBP
-- Origin: Vic Fryzel (http://github.com/vicfryzel/xmonad-config)
-- Modifier: Cedric Fung (http://github.com/vec.io/.linux/xmonad)

Config {
    font = "xft:DejaVu Sans Mono:size=8:antialias=true",
    bgColor = "#000000",
    fgColor = "#ffffff",
    position = Static { xpos = 0, ypos = 0, width = 2560, height = 32 },
    lowerOnStart = False,
    allDesktops = True,
    persistent = True,
    commands = [
        -- Run MultiCpu ["-t","CPU: <total0> <total1> <total2> <total3> <total4> <total5> <total6> <total7>","-L","30","-H","60","-h","#FFB6B0","-l","#CEFFAC","-n","#FFFFCC"] 10,
        Run CoreTemp ["-t", "Temps: <core0> <core1> <core2>", "-L", "40", "-H", "60", "-l", "lightblue", "-n", "gray90", "-h", "red"] 50,
        Run Memory ["-t","M: <usedratio>%","-H","8192","-L","4096","-h","#FFB6B0","-l","#CEFFAC","-n","#FFFFCC"] 10,
        Run Battery ["-t", "<left>% <timeleft>", "-L", "20", "-H", "75", "-h", "green", "-n", "yellow", "-l", "red"] 60,
        -- Run DiskIO [("/", "R:<total>"), ("/home", "H:<total>")] [] 10,
        Run DynNetwork [] 10,
        Run Date "%a %b %_d %H:%M" "date" 10,
        Run Com "/home/claus/bin/getvolume.sh" [] "myVolume" 10,
        Run StdinReader
    ],
    sepChar = "%",
    alignSep = "}{",
    template = "%StdinReader% }{ %dynnetwork%  %coretemp%  %battery% vol: %myVolume% <fc=#FFFFCC>%date%</fc>"
}
