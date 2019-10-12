# @dotfile

function __fzf_find_file

    find -type f \
    | ag "[\/]?(share|\.rustup|\.npm|\.git|node_modules|chromium|.cache)\/" --invert-match \
    | fzf -m \
    | while read -l s; set results $results $s; end

    if test -z "$results"
        commandline -f repaint
        return
    else
        commandline -t ""
    end

    for result in $results
        commandline -it -- (string escape $result)
        commandline -it -- " "
    end
    commandline -f repaint
end
