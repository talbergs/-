# @dotfile
set -gx TERMINAL termite
set -gx EDITOR vide
set -gx USER (whoami)
set -gx BROWSER chromium
set -gx XKB_DEFAULT_LAYOUT "us,lv(apostrophe)"
set -gx XKB_DEFAULT_OPTIONS grp:alt_shift_toggle

set -gx LESS_TERMCAP_mb \e'[1;31m'       #  begin bold
set -gx LESS_TERMCAP_md \e'[1;33m'       #  begin blink
set -gx LESS_TERMCAP_so \e'[01;44;37m'   #  begin reverse video
set -gx LESS_TERMCAP_us \e'[01;37m'      #  begin underline
set -gx LESS_TERMCAP_me \e'[0m'          #  reset bold/blink
set -gx LESS_TERMCAP_se \e'[0m'          #  reset reverse video
set -gx LESS_TERMCAP_ue \e'[0m'          #  reset underline
set -gx MANPAGER        'less -s -M +Gg' #  verbose prompt + hlsearch

# Global path preppend any bin folder in ~/.progs
if test -d ~/.progs
  set -pgx PATH (du ~/.progs | cut -f2 | grep '/bin$')
end

# Global path preppend every folder in ~/.scripts
if test -d ~/.cargo/bin
  set -pgx PATH $HOME/.cargo/bin
end

# Global path preppend every folder in ~/.scripts
if test -d ~/.scripts
  set -pgx PATH (du $HOME/.scripts | cut -f2)
end

if test -z (pgrep ssh-agent)
  eval (ssh-agent -c)
  set -Ux SSH_AUTH_SOCK $SSH_AUTH_SOCK
  set -Ux SSH_AGENT_PID $SSH_AGENT_PID
  set -Ux SSH_AUTH_SOCK $SSH_AUTH_SOCK

  if test -e ~/.ssh/id_rsa
    ssh-add ~/.ssh/id_rsa
  end
end

set fish_greeting # this unsets that greeting
# vim: fdm=marker ft=sh
