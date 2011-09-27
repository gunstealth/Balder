#!/bin/sh
#                                                       -*- .bash_profile - 1.0 -*-
# Copyright (C) (2006, 2011) Mauro N. Guerra.
#
# * 02/01/2006 re-write and cleanup.
# * 2008-2010  add-ons, fixes and cleanup.
# * 20/09/2011 export files to github, for better control of changes and improvements, plus version control.

# includes
. /bash_alias
. /bash_functions
- /bash_exports

# Algunos exports

export LC_ALL=es_AR.UTF-8
export PATH=${PATH}:~/bin:~/local/bin:~/local/scripts:~/usr/bin:/sbin:/usr/sbin:/usr/local/sbin
export EDITOR=joe
export VISUAL=cream
export PAGER=less

export HISTCONTROL=ignoredups
export HISTFILE LESS PS1 PS2

# Sets
set completion-ignore-case on
set -o joe
shopt -s cdspell
shopt -s checkhash
shopt -s no_empty_cmd_completion
shopt -s hostcomplete
shopt -s extglob  

# Si hay X chromium, si no... jejeje
if [ -n "$DISPLAY" ]; then
	BROWSER=chromium
else
	BROWSER=w3m
fi

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

if [ -z "${PS1}" ]; then
	return
fi

function update_ps1 ()
{
	PS1="(\[\033[1;32m\]\h\[\033[0m\])(\[\033[1;37m\]`tty`\[\033[0m\])\n[\W],[\[\033[0;32m\]`jobcount`\[\033[0m\]] "
}

PROMPT_COMMAND='update_ps1'
PS2='> '


eval `dircolors -b`

# It's useful to have auto-complete
# https://wiki.archlinux.org/index.php/Bashrc#Auto_completion
complete -cf sudo
complete -cf man
complete -cf killall
complete -cf ka
complete -cf alias
complete -cf info
complete -cf which


