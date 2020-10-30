# /etc/bashrc

# System wide functions and aliases
# Environment stuff goes in /etc/profile

# This file may be overwritten by ansible. Please think about commiting
# changes you want to keep persistent.

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
{% for alias in base__aliases %}
{% if alias.color %}
    alias {{ alias.alias }}='{{ alias.command }} --color=auto'
{% endif%}
{% endfor %}
fi

{% for alias in base__aliases %}
{% if not alias.color %}
    alias {{ alias.alias }}='{{ alias.command }}'
{% endif%}
{% endfor %}

{%if base__bash_completion_enabled %}
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

{% endif %}

# fancy Prompt
if [ $(id -u) -eq 0 ]; then
    export PS1="{{ base__root_prompt }} "
else
    export PS1="{{ base__user_prompt }} "
fi

# History to syslog
PROMPT_COMMAND='AT_PROMPT=t'
function log2syslog
{
    [ -z "${AT_PROMPT+set}" ] && return 1
    COMMAND=$(fc -ln -0|cut -f 2-)
    if [ -n "${BASH_COMMAND}" ] && [ "${BASH_COMMAND}" != "AT_PROMPT=t" ] && [ "${BASH_COMMAND}" != '[ "$SHLVL" = 1 ]' ]; then
        if [ "${USER}" != "$(logname)" ]; then
            LOGUSER="$(logname)@${USER}"
        fi
        logger -p local4.notice -t bash -i -- "${LOGUSER:-$USER}: ${PWD} : ${COMMAND}"
    fi
    unset AT_PROMPT
}

{% if base__log_to_syslog %}
trap log2syslog DEBUG
{% endif %}

HISTCONTROL={{ base__history_control }}
shopt -s histappend
HISTSIZE={{ base__history_size }}
HISTFILESIZE={{ base__history_file_size }}

{% for _row in base__additional_bashrc_lines | default() %}
{{ _row }}
{% endfor %}
# vim:ts=4:sw=4
