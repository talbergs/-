# @dotfile
set -gx TERMINAL termite
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

set fish_greeting # this unsets that greeting
# vim: fdm=marker ft=sh
