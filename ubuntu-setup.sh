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

# Specify the desired theme
desired_theme="cloud"

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

