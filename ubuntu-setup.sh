#!/bin/bash

# Update and upgrade packages
sudo apt update
sudo apt upgrade -y

# Install Zsh
sudo apt install zsh -y

# Set Zsh as the default shell
chsh -s $(which zsh)

# Install Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Print a message indicating the completion of the process
echo "Setup complete! Please restart your terminal to use Zsh with Oh My Zsh."

