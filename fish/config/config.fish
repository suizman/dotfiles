set -x suizman_dotfiles $HOME/work/repos/dotfiles

if status is-interactive
    function fish_greeting
        $suizman_dotfiles/scripts/printing/greeting.py --image $suizman_dotfiles/img/ascii/samurai
    end
    # zoxide integration (if installed) provides `z` with the expected --add semantics
    if type -q zoxide
        zoxide init fish | source
    end
    # Commands to run in interactive sessions can go here
    if type -q starship
        starship init fish | source
    end    
end
    
