 dotfiles
==========
[![MIT License](https://raw.githubusercontent.com/roles-ansible/ansible_role_dotfiles/master/.github/license.svg?sanitize=true)](https://github.com/roles-ansible/ansible_role_dotfiles/blob/master/LICENSE)
[![Galaxy](https://raw.githubusercontent.com/roles-ansible/ansible_role_dotfiles/master/.github/galaxy.svg?sanitize=true)](https://galaxy.ansible.com/do1jlr/dotfiles)

 intended use
---------------
This role is designed to manage linux hosts with the following roles. This role here basically only focuses on deploying some dotfiles, [@DO1JLR](https://github.com/DO1JLR) decided they are needed at all hosts that are ansible managed.
Other roles distribute ssh public keys, configure sshd, create users and manage sudo permissions or install a number of useful packages.

A list of suggested roles to manage your linux host:
 - [do1jlr.base](https://github.com/roles-ansible/ansible_role_base.git) *install some useful packages*
 - [do1jlr.users](https://github.com/roles-ansible/ansible_role_users.git) *create user and manage sudoers*
 - [do1jlr.auth](https://github.com/chaos-bodensee/role-ssh_authorized_keys.git) *deploy ssh pubkeys*
 - [do1jlr.sshd](https://github.com/roles-ansible/ansible_role_sshd.git) *configure sshd*
 - [do1jlr.dotfiles](https://github.com/roles-ansible/ansible_role_dotfiles) *(this one)*

 Good to know:
---------------
The listed roles use the same variables to create accounts, admins and so on. But the roles have to run in the correct order to work properly.
For example you can't deploy a ssh public key for a user that is not created.

### Get it directly from Ansible Galaxy
```bash
$ ansible-galaxy install do1jlr.dotfiles
```

Function of this role
-----------------------
Ansible role to deploy some dotfiles which may be useful

Affected files:
```ini
/etc/bash.bashrc
~/.bashrc
~/.vimrc
```
*(and optionally some more, if enabled)*

 variables:
---------------
The variable ``accounts`` is very important, because this will manage which user accounts will be configured.

```ini
# enable basic version check for this role
# set it to true to use it (recomended)
submodules_versioncheck: false

# for some ansible features we need the python selinux package at fedora
# disable it, if you don't want it
dotfiles__install_python_selinux: true

# modify bashrc
dotfiles__modify_bashrc: true

# list of aliases used in bashrc
dotfiles__aliases:
  - { alias: "ls", command: "ls ", color: True }
  - { alias: "grep", command: "grep", color: True }
  - { alias: "ll", command: "ls -alF", color: False }
  - { alias: "la", command: "ls -A", color: False }
  - { alias: "l", command: "ls -CF", color: False }
  - { alias: "lz", command: "ls -Z", color: False }
  - { alias: "EDITOR", command: "/usr/bin/vim", color: False }
  - { alias: "VISUAL", command: "/usr/bin/gedit", color: False }
  - { alias: "gitsubpull", command: "git submodule foreach '(git checkout \\$(git symbolic-ref --short refs/remotes/origin/HEAD | sed 's@^origin/@@'); git pull)'", color: False }
  - { alias: "pwgen", command: "/usr/bin/pwgen --num-passwords=3000 --numerals --capitalize --secure --no-vowels --ambiguous --symbols 95 1", color: false }


# enable bash completion
dotfiles__bash_completion_enabled: true

# fancy promt
dotfiles__user_prompt: '\[\033[01;33m\] $(printf "\xE2\x9D\xA4") \[\033[01;32m\]\u\[\033[01;36m\]@\[\033[01;32m\]\H\[\033[01;34m\] <\A> \[\033[01;35m\] \j \[\033[01;36m\] \w \[\033[01;33m\]\n\[\033[01;33m\] $(git branch 2>/dev/null | sed -n "s/* \(.*\)/\1 /p")$\[\033[01;00m\] '
dotfiles__root_prompt: '\[\033[01;31m\] $(printf "\xE2\x9D\xA4") \[\033[01;32m\]\u\[\033[01;36m\]@\[\033[01;32m\]\H\[\033[01;34m\] <\A> \[\033[01;35m\] \j \[\033[01;36m\] \w \[\033[01;33m\]\n\[\033[01;33m\] $(git branch 2>/dev/null | sed -n "s/* \(.*\)/\1 /p")$\[\033[01;00m\] '

# modify bash history
dotfiles__history_control: 'ignoreboth'
dotfiles__history_size: '-1'
dotfiles__history_file_size: '-1'

# optional additional entries to /etc/bash.bashrc
dotfiles__additional_bashrc_lines: []
# - eval `foo`
# - tmux new-session

# optional additional entries to ~/.bashrc
dotfiles__additional_user_bashrc_lines: []
#  - eval $(keychain --eval --quiet id_ed25519)

# optionally allow custom bashrc for root
dotfiles__allow_own_root_bashrc: false

# otional custom commands
```

Please have a look into ``defaults/main.yml`` for more configuration options!


### testing
If you want to find out more about our tests, please have a look at the github marketplace.

| test status | Github Marketplace |
| :---------  | :----------------  |
| [![Ansible Lint check](https://github.com/roles-ansible/ansible_role_dotfiles/workflows/Ansible%20Lint%20check/badge.svg)](https://github.com/roles-ansible/ansible_role_dotfiles/actions?query=workflow%3A%22Ansible+Lint+check%22) | [ansible-lint action](https://github.com/marketplace/actions/ansible-lint)
| [![Ansible check debian:stable](https://github.com/roles-ansible/ansible_role_dotfiles/workflows/Ansible%20check%20debian:stable/badge.svg)](https://github.com/roles-ansible/ansible_role_dotfiles/actions?query=workflow%3A%22Ansible+check+debian%3Astable%22) | [ansible test with debian stable](https://github.com/marketplace/actions/check-ansible-debian-stable) |
| [![Ansible check debian:latest](https://github.com/roles-ansible/ansible_role_dotfiles/workflows/Ansible%20check%20debian:latest/badge.svg)](https://github.com/roles-ansible/ansible_role_dotfiles/actions?query=workflow%3A%22Ansible+check+debian%3Alatest%22) | [ansible test with debian latest](https://github.com/marketplace/actions/check-ansible-debian-latest) |
| [![Ansible check debian:sid](https://github.com/roles-ansible/ansible_role_dotfiles/workflows/Ansible%20check%20debian:sid/badge.svg)](https://github.com/roles-ansible/ansible_role_dotfiles/actions?query=workflow%3A%22Ansible+check+debian%3Asid%22) | [ansible test with debian sid](https://github.com/marketplace/actions/check-ansible-debian-sid) |
| [![Ansible check debian:buster](https://github.com/roles-ansible/ansible_role_dotfiles/workflows/Ansible%20check%20debian:buster/badge.svg)](https://github.com/roles-ansible/ansible_role_dotfiles/actions?query=workflow%3A%22Ansible+check+debian%3Abuster%22) | [ansible test with debian buster](https://github.com/marketplace/actions/check-ansible-debian-buster) |
| [![Ansible check debian:stretch](https://github.com/roles-ansible/ansible_role_dotfiles/workflows/Ansible%20check%20debian:stretch/badge.svg)](https://github.com/roles-ansible/ansible_role_dotfiles/actions?query=workflow%3A%22Ansible+check+debian%3Astretch%22) | [ansible test with debian stretch](https://github.com/marketplace/actions/check-ansible-debian-stretch) |
| | |
| [![Ansible check archlinux:latest](https://github.com/roles-ansible/ansible_role_dotfiles/workflows/Ansible%20check%20archlinux:latest/badge.svg)](https://github.com/roles-ansible/ansible_role_dotfiles/actions?query=workflow%3A%22Ansible+check+archlinux%3Alatest%22) | [ansible test with archlinux latest](https://github.com/marketplace/actions/check-ansible-archlinux-latest) |
| | |
| [![Ansible check ubuntu:latest](https://github.com/roles-ansible/ansible_role_dotfiles/workflows/Ansible%20check%20ubuntu:latest/badge.svg)](https://github.com/roles-ansible/ansible_role_dotfiles/actions?query=workflow%3A%22Ansible+check+ubuntu%3Alatest%22) | [ansible test with ubuntu latest](https://github.com/marketplace/actions/check-ansible-ubuntu-latest) |
| [![Ansible check ubuntu:bionic](https://github.com/roles-ansible/ansible_role_dotfiles/workflows/Ansible%20check%20ubuntu:bionic/badge.svg)](https://github.com/roles-ansible/ansible_role_dotfiles/actions?query=workflow%3A%22Ansible+check+ubuntu%3Abionic%22) | [ansible test with ubuntu bionic](https://github.com/marketplace/actions/check-ansible-ubuntu-bionic) |
| [![Ansible check ubuntu:trusty](https://github.com/roles-ansible/ansible_role_dotfiles/workflows/Ansible%20check%20ubuntu:trusty/badge.svg)](https://github.com/roles-ansible/ansible_role_dotfiles/actions?query=workflow%3A%22Ansible+check+ubuntu%3Atrusty%22) | [ansible test with ubuntu trusty](https://github.com/marketplace/actions/check-ansible-ubuntu-trusty) |
| | |
| [![Ansible check fedora:latest](https://github.com/roles-ansible/ansible_role_dotfiles/workflows/Ansible%20check%20fedora:latest/badge.svg)](https://github.com/roles-ansible/ansible_role_dotfiles/actions?query=workflow%3A%22Ansible+check+fedora%3Alatest%22) | [ansible test with fedora latest](https://github.com/marketplace/actions/check-ansible-fedora-latest) |
| [![Ansible check fedora:33](https://github.com/roles-ansible/ansible_role_dotfiles/workflows/Ansible%20check%20fedora:33/badge.svg)](https://github.com/roles-ansible/ansible_role_dotfiles/actions?query=workflow%3A%22Ansible+check+fedora%3A33%22) | [ansible test with fedora 33](https://github.com/marketplace/actions/check-ansible-fedora-33) |
| [![Ansible check fedora:32](https://github.com/roles-ansible/ansible_role_dotfiles/workflows/Ansible%20check%20fedora:32/badge.svg)](https://github.com/roles-ansible/ansible_role_dotfiles/actions?query=workflow%3A%22Ansible+check+fedora%3A32%22) | [ansible test with fedora 32](https://github.com/marketplace/actions/check-ansible-fedora-32) |
| [![Ansible check fedora:31](https://github.com/roles-ansible/ansible_role_dotfiles/workflows/Ansible%20check%20fedora:31/badge.svg)](https://github.com/roles-ansible/ansible_role_dotfiles/actions?query=workflow%3A%22Ansible+check+fedora%3A31%22) | [ansible test with fedora 31](https://github.com/marketplace/actions/check-ansible-fedora-31) |
| | |
| [![Ansible check centos:latest](https://github.com/roles-ansible/ansible_role_dotfiles/workflows/Ansible%20check%20centos:latest/badge.svg)](https://github.com/roles-ansible/ansible_role_dotfiles/actions?query=workflow%3A%22Ansible+check+centos%3Alatest%22) | [ansible test with centos latest](https://github.com/marketplace/actions/check-ansible-centos-latest) |
| [![Ansible check centos:centos8](https://github.com/roles-ansible/ansible_role_dotfiles/workflows/Ansible%20check%20centos:centos8/badge.svg)](https://github.com/roles-ansible/ansible_role_dotfiles/actions?query=workflow%3A%22Ansible+check+centos%3Acentos8%22) | [ansible test with centos centos8](https://github.com/marketplace/actions/check-ansible-centos-centos8) |
| [![Ansible check centos:centos7](https://github.com/roles-ansible/ansible_role_dotfiles/workflows/Ansible%20check%20centos:centos7/badge.svg)](https://github.com/roles-ansible/ansible_role_dotfiles/actions?query=workflow%3A%22Ansible+check+centos%3Acentos7%22) | [ansible test with centos centos7](https://github.com/marketplace/actions/check-ansible-centos-centos7) |

