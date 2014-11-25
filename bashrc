#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias startr='startx /home/claus/.xinitrc retina'
alias startds='startx /home/claus/.xinitrc downscale'
PS1='[\u@\h \W]\$ '
