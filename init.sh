ln -sf dotfiles/bash_profile ~/.bash_profile
ln -sf dotfiles/settings/vimrc ~/.vimrc

# make directories
mkdir -p ~/development

# initial setup
git config --global user.name "Alexander Krasnoschekov / sol / 搜龙"
git config --global user.email "akrasnoschekov@gmail.com"
