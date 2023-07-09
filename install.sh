#!/bin/bash
# This installation script is stolen and modified from https://github.com/ChrisTitusTech/hyprland-titus since i don't understand bash scripting

#### Check for yay ####
ISYAY=/sbin/yay
if [ -f "$ISYAY" ]; then 
  echo -e "$COK - yay was located, moving on."
  yay -Suy
else 
  echo -e "$CWR - Yay was NOT located"
  read -n1 -rep $'[\e[1;33mACTION\e[0m] - Would you like to install yay (y,n) ' INSTYAY
  if [[ $INSTYAY == "Y" || $INSTYAY == "y" ]]; then
    git clone https://aur.archlinux.org/yay-git.git
    cd yay-git
    makepkg -si --noconfirm
    cd ..
    yay -Suy 
  else
    echo -e "$CER - Yay is required for this script, now exiting"
    exit
  fi
fi

# Core packages
read -n1 -rep 'Would you like to install core packages? (Hyprland, kitty, thunar, waybar..etc) (y,n) ' INST
if [[ $INST == "Y" || $INST == "y" ]]; then
  yay -R --noconfirm swaylock waybar
  yay -S --noconfirm hyprland-git jq polkit-gnome zsh ffmpeg neovim viewnior \
    rofi rofi-calc rofi-emoji pavucontrol thunar cliphist gvfs gvfs-mtp network-manager-applet \
    swaybg grim ffmpegthumbnailer tumbler playerctl brightnessctl bluez bluez-utils blueman \
    noise-suppression-for-voice thunar-archive-plugin file-roller kitty hyprpicker neofetch ntfs-3g \
    waybar-hyprland-git dunst cava btop wlogout swaylock-effects sddm-git pamixer \
    nwg-look-bin xdg-user-dirs 
  
  yay -S xdg-desktop-portal-hyprland-git

  echo -e "Changing shell to zsh"
  chsh -s $(which zsh)

  echo -e "Enabling bluetooth"
  sudo systemctl enable bluetooth
fi

# Option to install font
read -n1 -rep 'Would you like to install required font? (Nerd font ..etc) (y,n) ' FNT
if [[ $FNT == "Y" || $FNT == "y" ]]; then
  yay -S --noconfirm otf-sora ttf-nerd-fonts-symbols-common otf-firamono-nerd inter-font    \
    ttf-fantasque-nerd noto-fonts noto-fonts-emoji ttf-comfortaa \
    ttf-jetbrains-mono-nerd ttf-icomoon-feather ttf-iosevka-nerd ttf-roboto  \
    adobe-source-code-pro-fonts ttf-fira-code ttf-ms-win11-auto ttf-fira-code plus-jakarta-sans-font all-repository-fonts

  fc-cache -f
fi

# Theme package
read -n1 -rep 'Would you like to install theme components? (GTK Theme, cursor, icons...etc) (y,n) ' THME
if [[ $THME == "Y" || $THME == "y" ]]; then
  yay -S --noconfirm catppuccin-gtk-theme-mocha layan-cursor-theme-git papirus-icon-theme sddm-catppuccin-git
fi

read -n1 -rep 'Would you like to enable SDDM ? (y,n) ' WIFI
if [[ $WIFI == "Y" || $WIFI == "y" ]]; then
  LOC="/etc/sddm.conf"
  echo -e "[Theme]CursorTheme=Layan-white Cursors\nCurrent=catppuccin" | sudo tee -a $LOC
  echo -e "\n"
  echo -e "Enable SDDM service...\n"

  sudo systemctl enable sddm
  sleep 3
fi

read -n1 -rep 'Would you like to copy config files? (y,n) ' CFG
if [[ $CFG == "Y" || $CFG == "y" ]]; then
  echo -e "Copying config files...\n"
  cp -R ./btop ~/.config/
  cp -R ./cava ~/.config/
  cp -R ./hypr ~/.config
  cp -R ./kitty ~/.config/
  cp -R ./pipewire ~/.config/
  cp -R ./rofi ~/.config/
  cp -R ./swaylock ~/.config/
  cp -R ./waybar ~/.config/
  cp -R ./wlogout ~/.config/
  cp -R ./neofetch ~/.config/
  cp -R ./starship ~/.config/
  cp -R ./dunst ~/.config/
  cp -R ./zsh ~/.config/
  cp -R ./scripts ~/.config/
  cp -R ./spicetify/ ~/.config/
  cp -R ./xsettingsd/ ~/.config/
  cp -R ./user-dirs.dirs ~/.config/
  cp -R ./user-dirs.locale ~/.config/
  cp -R ./electron-flags.conf ~/ 
  cp -R ./.zshenv ~/
  cp -R ./.face.icon ~/

  echo -e "making neccessary dir...\n"

  mkdir ~/.cache/zsh
  touch ~/.cache/zsh/.histfile
  setfacl -m u:sddm:x ~/
  setfacl -m u:sddm:r ~/.face.icon

  xdg-mime default thunar.desktop inode/directory
fi

read -n1 -rep 'Would you like to install common tools? (web browser, pdf viewer) (y,n) ' COM
if [[ $COM == "Y" || $COM == "y" ]]; then
  yay -S --noconfirm firefox-bin brave-bin firefox-nightly-bin celluloid-git evince-git
fi

echo -e "Script had completed.\n"
echo -e "You can start Hyprland by typing Hyprland (note the capital H).\n"
read -n1 -rep 'Would you like to start Hyprland now? (y,n)' HYP
if [[ $HYP == "Y" || $HYP == "y" ]]; then
  exec Hyprland
else
  exit
fi
