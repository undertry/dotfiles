## Preview
<p align="center">
  <img src="showcase/ubuntu.gif" alt="urbix" width="800" height="300">
</p>

---

## Ubuntu-Bspwm Configuration

This repository contains configurations for Bspwm on Ubuntu 23.10, customized with terminal settings, Polybar, Picom, and additional enhancements.

### Main Packages

- **bspwm** (includes sxhkd)
- **polybar**
- **suckless-tools** (for desktop selection menu)

### Secondary Packages

- **neofetch**
- **lolcat**
- **git**
- **nitrogen**
- **feh**
- **lxappearance**
- **kitty**
- **thunar**
- **picom**
- **ranger**
- **htop**
- **btop**
- **cava**
- **cmatrix**
- **tty-clock**
- **pipes.sh or pipes-sh**
- **zsh**
- **neovim**
- **ninja**
- **lsd**
- **bat**
- **curl**
- **make**
- **pamixer**
- **pavucontrol**
- **playerctl**
- **dunst**
- **flameshot**
- **xsecurelock**
- **lightdm**
- **Betterlockscreen**

---

## Installation Steps

Before switching to bspwm on Ubuntu, ensure the following directories and configurations are set up:

1. Create necessary configuration directories:
   ```
   mkdir ~/.config/bspwm
   mkdir ~/.config/sxhkd
   mkdir ~/.config/polybar
   ```

2. Copy default configurations:
   ```
   cp /usr/share/doc/bspwm/examples/bspwmrc ~/.config/bspwm/
   cp /usr/share/doc/bspwm/examples/sxhkdrc ~/.config/sxhkd/
   cp /usr/share/doc/polybar/examples/config.ini ~/.config/polybar/
   ```

3. Make the Polybar launch script executable:
   ```
   chmod +x $HOME/.config/polybar/launch.sh
   ```

4. Create Picom and Kitty configuration directories:
   ```
   mkdir ~/.config/picom
   nano ~/.config/picom/picom.conf
   nano ~/.config/kitty/kitty.conf
   nano ~/.config/kitty/color.ini
   ```

---

## Additional Configurations and Enhancements

### Oh-my-zsh and Powerlevel10k Theme

Install oh-my-zsh and Powerlevel10k:
```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
```

### Zsh Plugins

Install plugins for zsh:
```bash
sudo apt install zsh-syntax-highlighting
sudo apt install zsh-autosuggestions
echo "source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ~/.zshrc
echo "source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh" >> ~/.zshrc
```

### Font Installation

Download Cascadia Code font:
```bash
git clone https://github.com/microsoft/cascadia-code.git
sudo cp -r ~/path-to-font/cascadia-code /usr/share/fonts/opentype
```

### Customization for Nano

Install Nano syntax highlighting:
```bash
git clone https://github.com/valerie-makes/nano-highlight.git
cd nano-highlight
make install
echo "include ~/.nano/syntax/ALL.nanorc" >> ~/.nanorc
```

### Neofetch Customization

Select and apply a theme from:
https://github.com/Chick2D/neofetch-themes

Copy the configuration to:
```bash
cp ~/.config/neofetch/config.conf
```

---

## Additional Configurations and Enhancements (cont.)

### Screen Resolution Customization

Create or edit `/etc/X11/xorg.conf` to set preferred resolution:
```bash
sudo nano /etc/X11/xorg.conf
```
Example configuration:
```plaintext
Section "Monitor"
    Identifier "Monitor0"
    Option "PreferredMode" "1920x1080"
    Option "RefreshRate" "75"
EndSection
```

### Optional: Picom Fork with Animations

Install dependencies:
```bash
sudo apt install libxext-dev libxcb1-dev libxcb-damage0-dev libxcb-xfixes0-dev libxcb-shape0-dev libxcb-render-util0-dev libxcb-render0-dev libxcb-randr0-dev libxcb-composite0-dev libxcb-image0-dev libxcb-present-dev libxcb-xinerama0-dev libxcb-glx0-dev libpixman-1-dev libdbus-1-dev libconfig-dev libgl1-mesa-dev libpcre2-dev libpcre3-dev libevdev-dev uthash-dev libev-dev libx11-xcb-dev ninja-build
```

Clone and install Picom:
```bash
git clone https://github.com/jonaburg/picom.git
cd picom
meson --buildtype=release . build
ninja -C build
sudo ninja -C build install
```

Restart Picom:
```bash
killall picom
picom &
```

### Neomutt (Terminal Email Client)

Clone and install Neomutt:
```bash
git clone https://github.com/neomutt/neomutt.git
cd neomutt
./configure
make
sudo make install
```

### Rofi Themes

Clone Rofi themes repository:
```bash
git clone https://github.com/Murzchnvok/rofi-collection.git
cd rofi-collection
```

Copy a theme to system-wide themes directory:
```bash
sudo cp -r nord/nord.rasi /usr/share/rofi/themes/
```

Alternatively, copy to local user themes directory:
```bash
cp -r nord/nord.rasi $HOME/.local/share/rofi/themes/
```

To copy all themes automatically:
```bash
sudo find ~/rofi-collection -name "*.rasi" -exec cp {} /usr/share/rofi/themes/ \;
```

Select a theme using:
```bash
rofi-theme-selector
```

### Neovim and LazyVim

Clone and install Neovim:
```bash
git clone https://github.com/neovim/neovim.git
cd neovim
make CMAKE_BUILD_TYPE=Release
sudo make install
```

Reset Neovim configuration:
```bash
rm -rf ~/.config/nvim
rm -rf ~/.local/share/nvim
rm -rf ~/.local/state/nvim
rm -rf ~/.cache/nvim
```

Clone LazyVim:
```bash
git clone https://github.com/LazyVim/starter ~/.config/nvim
```

Upon opening Neovim, LazyVim will be downloaded and installed automatically.

---










   
 
