if status is-interactive
    # Limpia la pantalla al inicio
    clear
    # Limpia mensaje de bienvenida
    set -U fish_greeting
    # toilet -f mono9 -F gay "#!"
    # cat ~/.config/fish/ascii/alert.txt | lolcat
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

    # # Mostrar un arte ASCII aleatorio al iniciar la terminal
    # set ascii_files (ls ~/.config/fish/ascii/*.txt)
    # set file_count (count $ascii_files)
    # set random_index (math (random 1 $file_count)) # Generar índice aleatorio (1 a file_count)
    # set random_ascii $ascii_files[$random_index] # Seleccionar archivo aleatorio
    # cat $random_ascii
    set -Ux fish_user_paths $fish_user_paths ~/bin

end
