<img src="https://github.com/vinceliuice/Sierra-gtk-theme/blob/imgs/logo.png" alt="Logo" align="right" /> Sierra Gtk Theme
======

Sierra is a Mac OSX like theme for GTK 3, GTK 2 and Gnome-Shell which supports GTK 3 and GTK 2 based desktop environments like Gnome, Pantheon, XFCE, Mate, etc.

This theme is based on Arc gtk theme of horst3180. Thanks horst3180 sincerely for his great job! 
horst3180 - Arc gtk theme: https://github.com/horst3180/Arc-theme

## Info

### GTK+ 3.20 or later

### GTK2 engines requirment
- GTK2 engine Murrine 0.98.1.1 or later.
- GTK2 pixbuf engine or the gtk(2)-engines package.

Fedora/RedHat distros:

    yum install gtk-murrine-engine gtk2-engines

Ubuntu/Mint/Debian distros:

    sudo apt-get install gtk2-engines-murrine gtk2-engines-pixbuf

ArchLinux:

    pacman -S gtk-engine-murrine gtk-engines

Other:
Search for the engines in your distributions repository or install the engines from source.

## Installation

### Flathub

Light Theme
`flatpak install flathub org.gtk.Gtk3theme.High-Sierra`

Dark Theme
`flatpak install flathub org.gtk.Gtk3theme.High-Sierra-Dark`

### Distributions

openSUSE [package](https://build.opensuse.org/package/show/home:jubalh/sierra-gtk-theme):
```
sudo zypper ar obs://home:jubalh homejubalh
sudo zypper ref
sudo zypper in sierra-gtk-theme
```
Ubuntu [PPA](https://launchpad.net/~dyatlov-igor/+archive/ubuntu/sierra-theme) (maintained by [@igor-dyatlov](https://github.com/igor-dyatlov)):
```
sudo add-apt-repository ppa:dyatlov-igor/sierra-theme
sudo apt update
sudo apt install sierra-gtk-theme       # point releases
sudo apt install sierra-gtk-theme-git   # git master branch
```

### From source

Run

    ./install.sh

#### Install tips

Usage:  `./Install`  **[OPTIONS...]**

|  OPTIONS:           | |
|:--------------------|:-------------|
|-d,  --dest           | Specify theme destination directory (Default: $HOME/.themes)|
|-n,  --name           | Specify theme name (Default: Sierra)|
|-c,  --color          | Specify theme color variant(s) **[light/dark]** (Default: All variants)|
|-o,  --opacity        | Specify theme opacity variant(s) **[standard/solid]** (Default: All variants)|
|-f,  --flat           | Specify theme flat variant(s) **[standard/compact]** (Default: All variants)|
|-t,  --thin           | Specify theme titlebutton variant(s) **[standard/thin]** (Default: All variants)|
|-na, --noapple        | Specify gnome-shell to not display apple logo (Default: Display apple logo)|
|-g,  --gdm            | Install GDM theme|
|-h,  --help           | Show this help|

## Screenshots

### GNOME Shell

#### Sierra
![01](https://github.com/vinceliuice/Sierra-gtk-theme/blob/imgs/screenshot1.jpeg?raw=true)
![02](https://github.com/vinceliuice/Sierra-gtk-theme/blob/imgs/screenshot2.jpeg?raw=true)
![03](https://github.com/vinceliuice/Sierra-gtk-theme/blob/imgs/screenshot3.jpeg?raw=true)
![04](https://github.com/vinceliuice/Sierra-gtk-theme/blob/imgs/screenshot4.jpeg?raw=true)
![05](https://github.com/vinceliuice/Sierra-gtk-theme/blob/imgs/screenshot5.jpeg?raw=true)
