# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "astron"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
   time.timeZone = "America/Argentina/Buenos_Aires";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
   i18n.defaultLocale = "es_AR.UTF-8";
  # console = {
    # fonts = "JetBrainsMono Nerd Font";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "Hack" ]; })
  ];


  services.xserver.enable = true;
  services.xserver.displayManager.sddm.enable = true; # Usa SDDM como gestor de inicio de sesión
  services.xserver.desktopManager.gnome.enable = true;
    # services.xserver.desktopManager.plasma5.enable = true; # Habilita KDE Plasma
  # Configuración opcional para mejorar el rendimiento en Wayland


  # environment.pathsToLink = [ "/libexec" ]; # links /libexec from derivations to /run/current-system/sw 

  # services.xserver = {
    # enable = true;

    # desktopManager = {
      # xterm.enable = false;
    # };
   
    # displayManager = {
      # lightdm.enable = true; # Habilita LightDM como Display Manager
      # plasma5.enable = true;
      # defaultSession = "none+i3";
    # };

  #   windowManager.i3 = {
  #     enable = true;
  #     extraPackages = with pkgs; [
  #       dmenu      # Application launcher
  #       # i3status   # Status bar por defecto de i3
  #       i3lock     # Screen locker
  #       # i3blocks   # Alternativa a i3status
  #       polybar    # Potentialy bar
  #     ];
  #   };
  # };


  programs.hyprland.enable = true;
  programs.hyprland.xwayland.enable = true;  # Para compatibilidad con apps X11

   # Enable the X11 windowing system.
   # services.xserver.enable = true;
   # services.xserver.windowManager.i3.enable = true;
   # services.xserver.windowManager.bspwm.enable = true;
   # # services.xserver.windowManager.i3.package = pkgs.i3-gaps;


  # Configure keymap in X11
   services.xserver.xkb.layout = "es";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;
  services.pipewire = {
    enable = true;
    audio.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Enable sound.
   # hardware.pulseaudio.enable = true;
   # hardware.pulseaudio.support32Bit = true;

  # Desactivar PipeWire
   # services.pipewire.enable = false;
  # OR
  # services.pipewire = {
    # enable = true;
    # pulse.enable = true;
  # };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
   users.users.tiagocomba = {
     isNormalUser = true;
     extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
     shell = pkgs.fish;
   };

   programs.fish.enable = true;
  
   boot.loader.grub.device = "dev/nvme0n1";
   # services.xserver.displayManager.lightdm.enable = true;
   # services.displaymanager.startx.enable = true;
   # services.getty.autologinUser = "tiagocomba";
   # services.displayManager = {
   #  autoLogin.enable = true;
   #  autoLogin.user = "username";
   #  };  
   #    # programs.firefox.enable = true;


  # services.displayManager.autoLogin = {
    # enable = true;
    # user = "tiagocomba"; # Reemplaza con tu nombre de usuario
  # };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
   environment.systemPackages = with pkgs; [
     vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
     wget
     xorg.xinit
     xorg.xset
     gnome.gnome-tweaks                # Herramienta de ajustes de GNOME
     hyprpaper # fondo de pantalla
     waybar    # barra de estado
     wofi      # lanzador de aplicaciones
     mako      # Notificaciones
     # i3-gaps
     # i3status
     # i3lock
     lxappearance
     gradience
     btop
     xdotool
     gparted
     alacritty
     toilet
     cowsay
     lolcat
     dmenu
     fastfetch
     firefox
     nitrogen
     picom
     flatpak
     udisks2
     gvfs
     gparted
     gnome-disk-utility
     nautilus
     xfce.thunar
     starship
     helix
     git
     unzip
     lsd
     bat
     fish
     pamixer
     playerctl
     glow
     mdcat
     steam
     vulkan-tools
     vulkan-loader
     vulkan-validation-layers
     libva
     libvdpau
     wineWowPackages.stable
     (polybar.override { pulseSupport = true; })
          (picom.overrideAttrs (oldAttrs: rec {
        pname = "compfy";
        version = "1.7.2";
        buildInputs = [
          pcre2
        ]
        ++
          oldAttrs.buildInputs;
        src = pkgs.fetchFromGitHub {
          owner = "allusive-dev";
          repo = "compfy";
          rev = version;
          hash = "sha256-7hvzwLEG5OpJzsrYa2AaIW8X0CPyOnTLxz+rgWteNYY=";
        };
        postInstall = '''';
      }))
   ];
# gnome
  services.dbus.enable = true;
# paquetes no libres
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "steam"
    "nvidia-x11"
    "steam-unwrapped"
    "nvidia-settings"
  ];


# steam
programs.steam.enable = true;
programs.gamemode.enable = true;
# kernel para gaming
boot.kernelPackages = pkgs.linuxPackages_zen;

# Proton y vulkan
 hardware.opengl.enable = true;
  hardware.opengl.driSupport32Bit = true;

# nvidia
 services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    open = false;
    nvidiaSettings = true;
  };


# fsync y esync (proton)
environment.sessionVariables = {
    WINEESYNC = "1";
    WINEFSYNC = "1";
  };
# services.polybar.enable = true;
   
# Servicios para activar flatpak

   xdg.portal.enable = true;
   xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];			

   xdg.portal.config.common.default = "*";

   services.flatpak.enable = true;


# Servicios para el soporte de dispositivos de almacenamiento

   services.udev.packages = [ pkgs.udev ];
   hardware.enableRedistributableFirmware = true;

# Servicio para el monaje automático de dispositivos de almacenamiento

   services.udisks2.enable = true;
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
   system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.11"; # Did you read the comment?

}

