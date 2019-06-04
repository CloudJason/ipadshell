#!/bin/bash

set -e

if [ ! -d ~/code/ipadshell ]; then
  echo "Cloning ipadshell"
  # the reason we dont't copy the files individually is, to easily push changes
  # if needed
  mkdir -p ~/code
  cd ~/code
  git clone https://github.com/CloudJason/ipadshell.git
fi

cd ~/code/ipadshell
git remote set-url origin git@github.com:CloudJason/ipadshell.git

echo "Creating symlinks for dotfiles"
ln -s $(pwd)/rc-files/vimrc ~/.vimrc
ln -s $(pwd)/rc-files/zshrc ~/.zshrc
ln -s $(pwd)/rc-files/tmuxconf ~/.tmux.conf
ln -s $(pwd)/rc-files/tigrc ~/.tigrc
ln -s $(pwd)/rc-files/git-prompt.sh ~/.git-prompt.sh
ln -s $(pwd)/rc-files/gitconfig ~/.gitconfig
ln -s $(pwd)/rc-files/agignore ~/.agignore
ln -s $(pwd)/rc-files/sshconfig ~/.ssh/config

ln -s ~/code/merge_kubeconfig.sh /usr/local/bin/merge_kubeconfig.sh

# Copy IKS config files
cd ~/code/clusters
echo "Copying IKS related files"
mkdir -p /root/.bluemix/plugins/container-service/clusters
cp -R * /root/.bluemix/plugins/container-service/clusters


#mkdir ~/.kube 
#cp kubeconfig ~/.kube/config

#cp iks-merged-config.sh ~/opt/iks-merged-config.sh
#cp iks-download-cluster-configs.sh ~/opt/iks-download-cluster-configs.sh
#chmod +x ~/opt/iks-merged-config.sh
#chmod +x ~/opt/iks-download-cluster-configs.sh

# setup kubectx
ln -s ~/opt/kubectx/kubectx /usr/local/bin/kubectx
ln -s ~/opt/kubectx/kubens /usr/local/bin/kubens

# setup completions
mkdir ~/opt/completion
ln -s ~/opt/kubectx/completion/kubectx.zsh ~/opt/completion/_kubectx.zsh
ln -s ~/opt/kubectx/completion/kubens.zsh ~/opt/completion/_kubens.zsh

echo "Running sshd"
/usr/sbin/sshd -D