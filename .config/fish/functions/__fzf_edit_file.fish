# @dotfile
function __fzf_edit_file

    find -type f \
    | ag "[\/]?(share|\.rustup|\.npm|\.git|node_modules|chromium|.cache)\/" --invert-match \
    | fzf -m \
    | while read -l s; set results $results $s; end

    if test -z "$results"
        commandline -f repaint
        return
    end

    $EDITOR $results
end
