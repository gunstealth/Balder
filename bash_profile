#!/bin/sh
#                                                       -*- .bashrc - 0.2 -*-
# Copyright (C) 2003, 2004, 2005, 2006 Mauro N. Guerra.
#
# * 02/01/2006 re-write and cleanup.
#

if [ -z "${PS1}" ]; then
	return
fi

LC_ALL=es_AR.UTF-8
PATH=${PATH}:~/bin:~/local/bin:~/usr/bin:/sbin:/usr/sbin:/usr/local/sbin
EDITOR=joe
VISUAL=joe
PAGER=less

#
# Nota sobre jobcount, update_ps1 and PROMPT_COMMAND:
# la asignacion a PS1 se realiza por la funcion update_ps1 para mantener
# actualizado la cantidad de tareas en "background".
# Descripcion:
#   (tty)[pwd],[numero de tareas en bg]
#

function jobcount ()
{
	jobs | wc -l | awk '{print $1}'
}
	  
function update_ps1 ()
{
	PS1="(\[\033[1;32m\]\h\[\033[0m\])(\[\033[1;37m\]`tty`\[\033[0m\])\n[\W],[\[\033[0;32m\]`jobcount`\[\033[0m\]] "
}

PROMPT_COMMAND='update_ps1'
PS2='> '

export HISTFILE LESS VISUAL EDITOR PAGER PATH LC_ALL PS1 PS2 MANPATH
export EDITOR VISUAL PAGER


eval `dircolors -b`

function clear ()
{
	tput clear
}

function psgrep ()
{
	ps -A | grep $1 | grep -v grep
}

function pskill ()
{
	local pid

	pid=$(ps -A | grep $1 | grep -v grep | awk '{ print $1 }')
	echo -n "killing $1 (pid ${pid})... "
	kill -9 ${pid}
	echo "ok"
}

function new-alias ()
{
	local name=$1
	local value="$2"

	echo alias ${name}=\'${value}\' >> ~/.bashrc
	eval alias ${name}=\'${value}\'
	alias ${name}
}

function push ()
{
	pushd .
}


function bat ()
{
	echo "Battery status: "
	cat /proc/acpi/battery/BAT0/state | grep "present"
	cat /proc/acpi/battery/BAT0/state | grep "charging state"
	cat /proc/acpi/battery/BAT0/info | grep "design capacity:"
	cat /proc/acpi/battery/BAT0/info | grep warning
	cat /proc/acpi/battery/BAT0/state | grep remaining
}

function ccopy ()
{ 
	cp $1 /tmp/ccopy.$1; 
}

function calc ()
{ 
	echo "${1}"|bc -l; 
}

alias cpaste="ls /tmp/ccopy* | sed 's|[^\.]*.\.||' | xargs -I % mv /tmp/ccopy.% ./%"
alias ls='ls -F --color'
alias l='ls -l -F --color'
alias la='ls -a -F --color'
alias logout='clear && logout'
alias j='joe'
alias ll='ls -lh -a -F --color'
alias cdp='cd /home/pub/'
alias cd..='cd ..'
alias msg='sudo tail -f /var/log/messages'
alias gmail='fetchmail -v -m "procmail -d %T"'
alias less='less -x 4'
alias rbak='rm *~'
alias cdw='cd ~/local/work'
alias sshot='import -window root shot-$(date +%Y%m%d%k%M).jpg'
alias dirf='find . -type d | sed -e "s/[^-][^\/]*\//  |/g" -e "s/|\([^ ]\)/|-\1/"'
alias clasicos="history | awk '{print $2}' | sort | uniq -c | sort -rn | head "

