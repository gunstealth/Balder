#!/bin/sh
#                                                       -*- .bash_profile - 0.5 -*-
# Copyright (C) (2003, 2011) Mauro N. Guerra.
#
# * 02/01/2006 re-write and cleanup.
# * 2008-2010  add-ons, fixes and cleanup.
# * 20/09/2011 export files to github, for better control of changes and improvements, plus version control.


if [ -z "${PS1}" ]; then
	return
fi

export LC_ALL=es_AR.UTF-8
export PATH=${PATH}:~/bin:~/local/bin:~/usr/bin:/sbin:/usr/sbin:/usr/local/sbin
export EDITOR=joe
export VISUAL=cream
export PAGER=less

export HISTFILE LESS PS1 PS2

# Less Colors for Man Pages
export LESS_TERMCAP_mb=$'\E[01;31m'       # begin blinking
export LESS_TERMCAP_md=$'\E[01;38;5;74m'  # begin bold
export LESS_TERMCAP_me=$'\E[0m'           # end mode
export LESS_TERMCAP_se=$'\E[0m'           # end standout-mode
export LESS_TERMCAP_so=$'\E[38;5;246m'    # begin standout-mode - infobox
export LESS_TERMCAP_ue=$'\E[0m'           # end underline
export LESS_TERMCAP_us=$'\E[04;38;5;146m' # begin underline

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


eval `dircolors -b`



