# @dotfile
function fish_title
    set -l command (echo $_)

    if test (count $argv) -eq 0 
        echo $TERMINAL
        # printf  " {}"
    else if test $command = $EDITOR
        printf $argv
    else
        printf $argv
    end
end


