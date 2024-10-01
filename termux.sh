#!/bin/bash

setup_termux() {
    # setup color scheme
    theme="https://github.com/dracula/termux/archive/master.zip"
    curl -L -o ~/dracula.zip $theme
    unzip -o ~/dracula.zip -d ~/
    cp -r ~/termux-master/colors.properties ~/.termux/colors.properties
    rm -rf ~/{termux-master,dracula.zip}

    # setup font
    font="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/0xProto.zip"
    curl -L -o ~/font.zip $font
    unzip -o ~/font.zip -d ~/

    cp -r ~/0xProtoNerdFont-Regular.ttf ~/.termux/font.ttf
    rm -rf ~/{font.zip,*.ttf,README.md,LICENSE}

    [ ! -d "$HOME/storage" ] && termux-setup-storage

}

setup_nvim() {
    [ ! -d ~/.config ] && mkdir -p .config
    git clone https://github.com/nyebat/nvim-dotfiles ~/dotfiles
    rm -rf ~/dotfiles/{.git/,README.md}
    cp -r  ~/dotfiles/. ~/ && rm -rf ~/{dotfiles,termux.sh}
}

install_packages() {
    pkg update && pkg upgrade -y

    packages=(
        neofetch
        mpd
        ncmpcpp
        fish
        whiptail
        neovim
        build-essential
        git
        ripgrep
        python
        rust
        rust-analyzer
        lua-language-server
    )

    pkg install -y "${packages[@]}"
}


set_fish_as_default() {
    shell="fish"
    current_shell=$(echo $SHELL | awk -F/ '{print $NF}')

    [ ! $(command -v $shell > /dev/null) ] && pkg install $shell
    if [ "$current_shell" != "$shell" ] && command -v $shell > /dev/null; then
        chsh -s fish
    fi
}


setup_termux
setup_nvim
install_packages
set_fish_as_default

termux-reload-settings
echo "Setup dan instalasi selesai!"

