#!/bin/bash

# Function to print status messages
print_message() {
    echo "⏳ $1..."
}

# Function to check command success
check_success() {
    if [ $? -eq 0 ]; then
        echo "✅ $1 completed successfully"
    else
        echo "❌ Error during $1"
        exit 1
    fi
}

# Update system
print_message "Updating system packages"
sudo apt update && sudo apt upgrade -y
check_success "System update"

# Install essential packages
print_message "Installing essential packages"
sudo apt install -y build-essential procps curl file git unzip
check_success "Essential packages installation"

# Install and configure zsh
print_message "Installing zsh"
sudo apt install -y zsh
check_success "Zsh installation"

print_message "Setting zsh as default shell"
chsh -s $(which zsh)
check_success "Zsh shell configuration"

# Install Oh My Zsh
print_message "Installing Oh My Zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
check_success "Oh My Zsh installation"

# Install Homebrew
print_message "Installing Homebrew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" </dev/null
check_success "Homebrew installation"

# Configure Homebrew PATH
print_message "Configuring Homebrew"
echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> ~/.zshrc
source ~/.zshrc
check_success "Homebrew configuration"

# Install Neovim
print_message "Installing Neovim"
sudo apt install -y neovim
check_success "Neovim installation"

# Install Python and pip
print_message "Installing Python and pip"
sudo apt install -y python3 python3-pip
check_success "Python installation"

# Install Docker
print_message "Installing Docker"
sudo apt install -y docker.io
sudo usermod -aG docker $USER
check_success "Docker installation"

# Install kubectl
print_message "Installing kubectl"
sudo apt install -y kubectl
check_success "kubectl installation"

# Install Terraform
print_message "Installing Terraform"
brew install terraform
check_success "Terraform installation"

# Install AWS CLI
print_message "Installing AWS CLI"
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
rm -rf aws awscliv2.zip
check_success "AWS CLI installation"

# Install Azure CLI
print_message "Installing Azure CLI"
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
check_success "Azure CLI installation"

# Install additional development tools
print_message "Installing additional development tools"
sudo apt install -y jq tree tmux git-flow
check_success "Additional tools installation"

# Configure zsh plugins
print_message "Configuring zsh plugins"
sed -i 's/plugins=(git)/plugins=(git docker kubectl terraform aws azure)/g' ~/.zshrc
check_success "Zsh plugins configuration"

echo "🎉 Installation complete! Please restart your terminal."
