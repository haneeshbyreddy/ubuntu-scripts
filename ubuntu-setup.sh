#!/bin/bash

# Update and upgrade packages
sudo apt update
sudo apt upgrade -y

sudo snap refresh
sudo snap install --classic nvim

# Array of packages to be installed
packages=(
  "default-jdk"
  "nodejs"
  "npm"
  "ranger"
  "fzf"
  "zsh"
)

for package in "${packages[@]}"; do
  echo "Installing: $package"
  sudo apt install $package -y
done

# Set Zsh as the default shell
chsh -s $(which zsh)

# Install Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Specify the desired theme
desired_theme="cloud"

git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Check if Oh My Zsh is installed
if [ -d "$HOME/.oh-my-zsh" ]; then
    # Update the Zsh theme in the ~/.zshrc file
    sed -i -E "s/ZSH_THEME=\"[^\"]+\"/ZSH_THEME=\"$desired_theme\"/" "$HOME/.zshrc"

    # Check if zsh-autosuggestions and zsh-syntax-highlighting are already added
    if grep -q "zsh-autosuggestions" "$HOME/.zshrc" && grep -q "zsh-syntax-highlighting" "$HOME/.zshrc"; then
        echo "zsh-autosuggestions and zsh-syntax-highlighting plugins are already added to ~/.zshrc."
    else
        # Add zsh-autosuggestions and zsh-syntax-highlighting to the plugins list in ~/.zshrc
        sed -i '/^plugins=/ s/[(]/&zsh-autosuggestions zsh-syntax-highlighting /' "$HOME/.zshrc"
        echo "zsh-autosuggestions and zsh-syntax-highlighting plugins added to ~/.zshrc."
    fi

    # Source the updated ~/.zshrc
    source "$HOME/.zshrc"
    echo "Changes applied. Restart your terminal to see the theme and plugin changes."
else
    echo "Oh My Zsh is not installed. Please install it first."
fi

