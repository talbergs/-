# @dotfile
set -gx TERMINAL termite
set -gx EDITOR vide
set -gx BROWSER chromium
set -gx XKB_DEFAULT_LAYOUT "us,lv(apostrophe)"
set -gx XKB_DEFAULT_OPTIONS grp:alt_shift_toggle

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
  # ssh-add ~/.ssh/id_rsa
end

set fish_greeting # this unsets that greeting
# vim: fdm=marker ft=sh
