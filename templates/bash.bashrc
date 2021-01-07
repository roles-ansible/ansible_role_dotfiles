# /etc/bashrc

# System wide functions and aliases
# Environment stuff goes in /etc/profile

# This file may be overwritten by ansible. Please think about commiting
# changes you want to keep persistent.

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
{% for alias in dotfiles__aliases %}
{% if alias.color %}
    alias {{ alias.alias }}="{{ alias.command }} --color=auto"
{% endif%}
{% endfor %}
fi

{% for alias in dotfiles__aliases %}
{% if not alias.color %}
    alias {{ alias.alias }}="{{ alias.command }}"
{% endif%}
{% endfor %}

{%if dotfiles__bash_completion_enabled %}
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
    export PS1='{{ dotfiles__root_prompt }} '
else
    export PS1='{{ dotfiles__user_prompt }} '
fi


HISTCONTROL={{ dotfiles__history_control }}
shopt -s histappend
{% if ansible_os_family == 'Redhat' %}
# HISTSIZE={{ dotfiles__history_size }}
# HISTFILESIZE={{ dotfiles__history_file_size }}
{% elif ansible_distribution == "CentOS" %}
# HISTSIZE={{ dotfiles__history_size }}
# HISTFILESIZE={{ dotfiles__history_file_size }}
{% else %}
HISTSIZE={{ dotfiles__history_size }}
HISTFILESIZE={{ dotfiles__history_file_size }}
{% endif %}


{% for _row in dotfiles__additional_bashrc_lines | default() %}
{{ _row }}
{% endfor %}
# vim:ts=4:sw=4
