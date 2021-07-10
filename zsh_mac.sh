#!/usr/bin/env bash
SCRIPT_DIR=$(cd "$(dirname "$0")"; pwd -P)

# Install and set zsh as default shell
brew install zsh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Install powerline fonts
git clone https://github.com/powerline/fonts.git --depth=1 /tmp/fonts
cd /tmp/fonts
./install.sh
cd ..
rm -rf fonts

# Install plugins
git clone https://github.com/zsh-users/zsh-completions ~/.oh-my-zsh/custom/plugins/zsh-completions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
brew install autojump

# zshrc
python3 ${SCRIPT_DIR}/zshrc_modify.py
