#!/usr/bin/env bash
SCRIPT_DIR=$(dirname $0)

function install_zsh() {
    if [ "$1" = "mac" ]
    then
        brew install zsh
    elif [ "$1" = "ubuntu" ]
    then
        sudo apt -y install zsh
    fi
}

function install_powerline_fonts() {
    if [ "$1" = "mac" ]
    then
        git clone https://github.com/powerline/fonts.git --depth=1 /tmp
        cd /tmp/fonts
        ./install.sh
        cd ..
        rm -rf fonts
    elif [ "$1" = "ubuntu" ]
    then
        sudo apt -y install fonts-powerline
    fi
}

function install_plugins() {
    git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-completions
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

    if [ "$1" = "mac" ]
    then
        brew install autojump
    elif [ "$1" = "ubuntu" ]
    then
        sudo apt -y install autojump
    fi
}

function main() {
    OS="mac"
    case ${OSTYPE} in
        darwin*)
            brew install curl git
            OS="mac" ;;
        linux*)
            apt -y install curl git
            OS="ubuntu" ;;
        *)
            echo "OS ${OSTYPE} not supported"
            exit 1
            ;;
    esac

    echo "Installing and set oh-my-zsh as default shell...."
    install_zsh ${OS}
    sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

    echo "Installing powerline fonts...."
    install_powerline_fonts ${OS}

    echo "Installing zsh plugins..."
    install_plugins ${OS}

    # Download terminal color scheme
    echo "Downloading terminal color scheme..."
    git clone git@github.com:mbadolato/iTerm2-Color-Schemes.git ${HOME}/iTerm2-Color-Schemes
}

main
