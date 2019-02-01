 dotfiles
==========
![Travis Status](https://travis-ci.org/DO1JLR/role_dotfiles.svg?branch=master)

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
```

 Optional config:
-----------------
```ini
# optional .bashrc commands
bash:
  bashrc: 'alias l="ls -all"'
```

Please have a look into ``defaults/main.yml`` for more configuration options!
