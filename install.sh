#!/bin/bash

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

read -n1 -rep 'Would you like to install core packages? (Hyprland, kitty, thunar, waybar..etc) (y,n)' INST
if [[ $INST == "Y" || $INST == "y" ]]; then
    yay -R --noconfirm swaylock waybar
    yay -S --noconfirm hyprland-git polkit-gnome zsh ffmpeg neovim viewnior \
    rofi rofi-calc rofi-emoji pavucontrol thunar cliphist gvfs gvfs-mtp network-manager-applet bluez bluez-utils blueman nm-applet \
    swaybg grimblast-git ffmpegthumbnailer tumbler playerctl brightnessctl bat exa \
    noise-suppression-for-voice thunar-archive-plugin file-roller kitty \
    waybar-hyprland-git xdg-desktp-portal-hyprland dunst cava btop wlogout swaylock-effects sddm-git pamixer \
    nwg-look-bin
	
    echo -e "Changing shell to zsh"
    chsh -s $(which zsh)

    echo -e "Enabling bluetooth"
    sudo systemctl enable bluetooth
fi

read -n1 -rep 'Would you like to install required font? (Nerd font ..etc) (y,n)' FNT
if [[ $FNT == "Y" || $FNT == "y" ]]; then
	yay -S --noconfirm otf-sora ttf-nerd-fonts-symbols-common otf-firamono-nerd inter-font    \
    ttf-fantasque-nerd noto-fonts noto-fonts-emoji ttf-comfortaa  \
    ttf-jetbrains-mono-nerd ttf-icomoon-feather ttf-iosevka-nerd ttf-roboto  \
    adobe-source-code-pro-fonts ttf-fira-code ttf-ms-win11-auto ttf-fira-code plus-jakarta-sans-font
fi

read -n1 -rep 'Would you like to install theme components? (GTK Theme, cursor, icons...etc) (y,n)' THME
if [[ $THME == "Y" || $THME == "y" ]]; then
	yay -S --noconfirm  catppuccin-gtk-theme-mocha layan-cursor-theme-git papirus-icon-theme sddm-catppuccin-git
fi

read -n1 -rep 'Would you like to enable SDDM autologin? (y,n)' WIFI
if [[ $WIFI == "Y" || $WIFI == "y" ]]; then
    LOC="/etc/sddm.conf"
    echo -e "[Theme]\nCurrent=catppuccin" | sudo tee -a $LOC
    echo -e "\n"
    echo -e "Enable SDDM service...\n"
    sudo systemctl enable sddm
    sleep 3
fi

read -n1 -rep 'Would you like to copy config files? (y,n)' CFG
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
    cp -R ./zsh ~/.config/
    cp -R ./scripts ~/.config/
    cp -R ./electron-flags.conf ~/
    cp -R ./user-dirs.dirs ~/
    cp -R ./user-dirs.locale ~/
    cp -R ./zshenv ~/

read -n1 -rep 'Would you like to install additional application? (web browser, pdf viewer, vlc) (y,n)' APP
if [[ $APP == "Y" || $APP == "y" ]]; then
    yay -S --noconfirm firefox-bin firefox-nightly-bin zathura zathura-cb zathura-djvu zathura-pdf-mupdf zathura-pdf-poppler zathura-ps vlc
fi

read -n1 -rep 'Would you like to install dev app? (Vscode, postman) (y,n)' DEV
if [[ $DEV == "Y" || $DEV == "y" ]]; then
    yay -S --noconfirm visual-studio-code-bin gnome-keyring nvm-git
fi

read -n1 -rep 'Would you like to install office tools (Libre office) (y,n)' OFFC
if [[ $OFFC == "Y" || $OFFC == "y" ]]; then
    yay -S --noconfirm libreoffice-fresh
fi

read -n1 -rep 'Would you like to install Graphic tools (Gimp, Inkscape, Krita) (y,n)' GRAPH
if [[ $GRAPH == "Y" || $OFFC == "y" ]]; then
    yay -S --noconfirm gimp inkscape krita obs-studio blender
fi

echo -e "Script had completed.\n"
echo -e "You can start Hyprland by typing Hyprland (note the capital H).\n"
read -n1 -rep 'Would you like to start Hyprland now? (y,n)' HYP
if [[ $HYP == "Y" || $HYP == "y" ]]; then
    exec Hyprland
else
    exit
fi
