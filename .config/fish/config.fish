if status is-interactive
    # Commands to run in interactive sessions can go here

starship init fish | source

if status --is-login
    if test -z "$DISPLAY" -a $XDG_VTNR = 1
        exec startx
    end
end

end
