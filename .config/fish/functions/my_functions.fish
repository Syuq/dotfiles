function cff
    set file (find ~/.config/fish -type f | fzf)
    [ -z "$file" ] || $EDITOR $file
end

function ud
    if string match -rq '.*gentoo.*' (uname -r)
        sudo emerge --sync && sudo emerge -auDU @world
    else
        $AUR_HELPER -Syyu
    end 
end

function mcd
    mkdir -p $argv[1] && cd $argv[1]
end

function cfv
    set file (find ~/.config/nvim -type d -path ~/.config/nvim/.git -prune -o \
        ! -type d -print | fzf)
    [ -z "$file" ] || $EDITOR $file
end

function fb
    set file (find ~/.local/bin -type f | fzf)
    [ -z "$file" ] || $EDITOR $file
end

function bwin
    set winboot (efibootmgr | grep "Windows Boot Manager" |
        cut -d'*' -f1 | cut -d't' -f2)
    sudo efibootmgr --bootnext $winboot && rb
end

function frepo
    cd ~/user/works/repos
    set dir (ls $HOME/user/works/repos | fzf || echo .)
    [ "$dir" = "code" ] && cd code && cd (ls $HOME/user/works/repos/code |
        fzf || echo .) || cd $dir
end


function faur
    cd ~/user/works/aurs ; cd (ls $HOME/user/works/aurs | fzf || echo .)
end

function fparu
    if string match -rq '.*gentoo.*' (uname -r)
        echo "This function doesn't work on Gentoo"
    else
        $AUR_HELPER -Fy; $AUR_HELPER -Slq | fzf --height=100% --multi --preview \
            '$AUR_HELPER -Si {1}' | xargs -ro $AUR_HELPER -S --needed
    end
end

function fpac
    if string match -rq '.*gentoo.*' (uname -r)
        echo "This function doesn't work on Gentoo"
    else
        sudo pacman -Fy; pacman -Slq | fzf --height=100% --multi --preview \
            'pacman -Si {1}' | xargs -ro sudo pacman -S --needed
    end
end

function frparu
    if string match -rq '.*gentoo.*' (uname -r)
        echo "This function doesn't work on Gentoo"
    else
        $AUR_HELPER -Qqe | fzf --height=100% --multi --preview \
            '$AUR_HELPER -Si {1}' | xargs -ro $AUR_HELPER -Rns
    end
end

if type -q doas
    function sudo
        doas -n $argv
        if [ $status -eq 1 ] && ! doas -t
            if string match -rq '/dev/tty\d' (tty)
                doas $argv
            else
                set pass (rofi -dmenu -password -l 0 -p "Password" 2> /dev/null) && 
                    doas -p "$pass" $argv
            end
        end 
    end
end

function sv
    if type -q sudoedit
        sudoedit "$argv[1]"
    else if type -q doas
        set FILE (basename $argv[1])
        doas echo -n
        if [ $status -eq 0 ]
            if [ -f "$argv[1]" ]
                cp -f "$argv[1]" /tmp/"$FILE" 2> /dev/null
                [ $status -ne 0 ] && echo "Permission denied!" && return
            end
            $EDITOR /tmp/"$FILE"
            if ! diff "$argv[1]" /tmp/"$FILE" > /dev/null 2>&1
                [ -f /tmp/"$FILE" ] && cat /tmp/"$FILE" | doas tee "$argv[1]" > /dev/null
            end
            rm -f /tmp/"$FILE"
        end
    end
end
