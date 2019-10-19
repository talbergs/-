# @dotfile
# env {{{1
set -gx TERMINAL termite
set -gx EDITOR vide
set -gx USER (whoami)
set -gx BROWSER chromium
set -gx XKB_DEFAULT_LAYOUT "us,lv(apostrophe)"
set -gx XKB_DEFAULT_OPTIONS grp:alt_shift_toggle

set -gx ZBX_ROOT ~/dev_zbx

# less {{{2
set -gx LESS_TERMCAP_mb \e'[1;31m'       #  begin bold
set -gx LESS_TERMCAP_md \e'[1;33m'       #  begin blink
set -gx LESS_TERMCAP_so \e'[01;44;37m'   #  begin reverse video
set -gx LESS_TERMCAP_us \e'[01;37m'      #  begin underline
set -gx LESS_TERMCAP_me \e'[0m'          #  reset bold/blink
set -gx LESS_TERMCAP_se \e'[0m'          #  reset reverse video
set -gx LESS_TERMCAP_ue \e'[0m'          #  reset underline
set -gx MANPAGER        'less -s -M +Gg' #  verbose prompt + hlsearch

# paths {{{1
# Global path preppend any bin folder in ~/.progs
if test -d ~/.progs
  set -pgx PATH (du ~/.progs | cut -f2 | grep '/bin$')
end

# Rust binaries
if test -d ~/.cargo/bin
  set -pgx PATH $HOME/.cargo/bin
end

# Global path preppend every folder in ~/.scripts
if test -d ~/.scripts
  set -pgx PATH (du $HOME/.scripts | cut -f2)
end

# Dev-box binaries
if test -d ~/.zbx-box/bin
  set -pgx PATH $HOME/.zbx-box/bin
end

# ssh {{{1
if test -z (pgrep ssh-agent)
  eval (ssh-agent -c)
  set -Ux SSH_AUTH_SOCK $SSH_AUTH_SOCK
  set -Ux SSH_AGENT_PID $SSH_AGENT_PID
  set -Ux SSH_AUTH_SOCK $SSH_AUTH_SOCK

  if test -e ~/.ssh/id_rsa
    ssh-add ~/.ssh/id_rsa
  end
end
# alias {{{1
abbr -a -g d docker
abbr -a -g dc docker-compose

abbr -a -g gst git status
abbr -a -g g git
abbr -a -g ga git add
abbr -a -g gc git commit
abbr -a -g gp git push
abbr -a -g gd git diff
abbr -a -g gb git branch
abbr -a -g gr git remote
abbr -a -g gco git checkout
abbr -a -g gcof git checkout '(git status --short | awk \'{print $2}\' | fzf -m)'
abbr -a -g gcob git checkout '(git branch --all | sed \'s/^\\s*//\' | fzf --height 15)'
abbr -a -g glog git log --format=fuller --first-parent --abbrev-commit

abbr -a -g .fish $EDITOR ~/.config/fish/config.fish
abbr -a -g .i3 $EDITOR ~/.config/i3/config
abbr -a -g .vim $EDITOR ~/.config/nvim/init.vim
abbr -a -g .sway $EDITOR ~/.config/sway/config

# vim: fdm=marker ft=sh
