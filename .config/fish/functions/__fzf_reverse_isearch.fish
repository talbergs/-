# @dotfile

function __fzf_reverse_isearch
    history merge
    history -z \
    | fzf --read0 --tiebreak=index --toggle-sort=ctrl-r \
    | perl -pe 'chomp if eof' \
    | read -lz result
    and commandline -- $result
    commandline -f repaint
end
