 dotfiles
==========
[![Build Status](https://travis-ci.org/chaos-bodensee/role_dotfiles.svg?branch=master)](https://travis-ci.org/chaos-bodensee/role_dotfiles)

Ansible role to deploy some dotfiles which may be useful

Affected files:
```ini
/etc/bash.bashrc
~/.bashrc
~/.vimrc
```
 needed vars:
---------------
```ini
# list all admins
admins:
  - l3d

# list of non-admins:
accounts:
  - ottojo
```

 Optional config:
-----------------
```ini
# optional .bashrc commands
extra_bashrc: 'alias l="ls -all"'
```

Please have a look into ``defaults/main.yml`` for more configuration options!
