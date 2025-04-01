if status is-interactive
    starship init fish | source
    # Limpia mensaje de bienvenida
    set -U fish_greeting
    # alias
    alias ls="lsd"
    alias lsa="lsd -a"
    alias lsl="lsd -l"
    alias lsla="lsd -la"
    alias fs="fastfetch"
    alias .="cd ~/.config"
    alias pr="cd ~/Documents/Projects/"
    alias prar="cd ~/Documents/Projects/Archived"
    alias prac="cd ~/Documents/Projects/Active"
    alias rebuild="sudo nixos-rebuild switch"
    alias nixos="sudo hx /etc/nixos/configuration.nix"

    set -Ux fish_user_paths $fish_user_paths ~/bin

end
