#!/bin/bash

setup_nvim() {
    mkdir -p .config
    git clone https://github.com/nyebat/nvim-dotfiles
    mv -f  ~/nvim-dotfiles/* .config/
    rm -rf ~/.config/{.git/,README.md,fish/} nvim-dotfiles
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

setup_termux() {
    # setup termux color scheme
    theme="https://github.com/dracula/termux/archive/master.zip"
    curl -L -o ~/dracula.zip $theme
    unzip -o ~/dracula.zip
    mv -f ~/termux-master/colors.properties ~/.termux/colors.properties
    rm -rf ~/{termux-master,dracula.zip}

    # setup termux font
    font="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/0xProto.zip"
    curl -L -o ~/font.zip $font
    unzip -o ~/font.zip

    mv ~/0xProtoNerdFont-Regular.ttf ~/.termux/font.ttf
    rm ~/{font.zip,*.ttf,README.md,LICENSE}

    [ ! -d "$HOME/storage" ] && termux-setup-storage

}

set_fish_as_default() {
    shell="fish"
    current_shell=$(echo $SHELL | awk -F/ '{print $NF}')

    [ ! $(command -v $shell > /dev/null) ] && pkg install $shell
    if [ "$current_shell" != "$shell" ] && command -v $shell > /dev/null; then
        chsh -s fish
    fi
}


install_packages
setup_termux
setup_nvim
set_fish_as_default

echo "Setup dan instalasi selesai!"
