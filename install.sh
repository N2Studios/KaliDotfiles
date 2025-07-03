#!/bin/bash

# ╔══════════════════════════════════════════════════════════════════════════════╗
# ║                    VERTICAL CYBER INTELLIGENCE DEV TERMINAL                  ║
# ║                      Kali Linux + Hyprland Setup Script                      ║
# ╚══════════════════════════════════════════════════════════════════════════════╝

set -euo pipefail  # Exit on error, undefined vars, pipe failures

# ═══════════════════════════════════════════════════════════════════════════════
# 🎨 COLORS AND FORMATTING
# ═══════════════════════════════════════════════════════════════════════════════
readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[1;33m'
readonly BLUE='\033[0;34m'
readonly MAGENTA='\033[0;35m'
readonly CYAN='\033[0;36m'
readonly BOLD='\033[1m'
readonly NC='\033[0m' # No Color

# ═══════════════════════════════════════════════════════════════════════════════
# 🔧 CONFIGURATION
# ═══════════════════════════════════════════════════════════════════════════════
readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly CONFIG_DIR="$HOME/.config"
readonly DOTFILES_DIR="$SCRIPT_DIR"
readonly FONTS_DIR="$HOME/.local/share/fonts"
readonly LOG_FILE="/tmp/hyprland-install.log"

# Package arrays for organized installation (optimized)
readonly CORE_PACKAGES=(
    hyprland waybar alacritty rofi sxhkd tmux neovim git zsh curl unzip wget
    grim slurp wl-clipboard xdg-desktop-portal-hyprland
)

readonly DEV_PACKAGES=(
    build-essential gcc g++ make cmake python3-pip nodejs npm
    python3-dev python3-venv lua5.3 luarocks ripgrep fd-find
)

readonly AUDIO_UX_PACKAGES=(
    pamixer brightnessctl mako swww playerctl
    pulseaudio pavucontrol
)

readonly OPTIONAL_PACKAGES=(
    lazygit thunar network-manager-gnome btop neofetch
    firefox-esr obs-studio
)
# Removed: flameshot (replaced by grim+slurp), code-oss (use official VSCode if needed)

readonly RUST_PACKAGES=(
    zoxide exa bat starship
)

# ═══════════════════════════════════════════════════════════════════════════════
# 🛠️ UTILITY FUNCTIONS
# ═══════════════════════════════════════════════════════════════════════════════

print_header() {
    echo -e "${BOLD}${MAGENTA}"
    echo "╔══════════════════════════════════════════════════════════════════════════════╗"
    echo "║ $1"
    echo "╚══════════════════════════════════════════════════════════════════════════════╝"
    echo -e "${NC}"
}

print_step() {
    echo -e "${BOLD}${CYAN}[STEP]${NC} $1"
}

print_success() {
    echo -e "${BOLD}${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${BOLD}${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${BOLD}${RED}[ERROR]${NC} $1"
}

log_message() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

check_root() {
    if [[ $EUID -eq 0 ]]; then
        print_error "This script should not be run as root!"
        print_warning "Please run as regular user. Sudo will be used when needed."
        exit 1
    fi
}

check_debian() {
    if ! command -v apt &> /dev/null; then
        print_error "This script requires a Debian-based system with apt package manager."
        exit 1
    fi
}

ask_confirmation() {
    local message="$1"
    local response
    echo -e "${BOLD}${YELLOW}$message${NC} (y/N): "
    read -r response
    [[ $response =~ ^[Yy]$ ]]
}

# ═══════════════════════════════════════════════════════════════════════════════
# 📦 PACKAGE INSTALLATION FUNCTIONS
# ═══════════════════════════════════════════════════════════════════════════════

update_system() {
    print_step "Updating system packages..."
    log_message "Starting system update"
    
    sudo apt update && sudo apt upgrade -y
    print_success "System updated successfully"
}

install_package_array() {
    local -n packages=$1
    local description="$2"
    
    print_step "Installing $description packages..."
    log_message "Installing $description: ${packages[*]}"
    
    # Build list of packages to install (only missing ones)
    local missing_packages=()
    for package in "${packages[@]}"; do
        if ! dpkg -l | grep -q "^ii  $package "; then
            missing_packages+=("$package")
        else
            print_warning "$package is already installed"
        fi
    done
    
    # Install all missing packages in one operation (more efficient)
    if [[ ${#missing_packages[@]} -gt 0 ]]; then
        echo -e "${BLUE}Installing packages: ${missing_packages[*]}${NC}"
        if sudo apt install -y "${missing_packages[@]}"; then
            print_success "All $description packages installed successfully"
        else
            print_error "Failed to install some $description packages"
            log_message "ERROR: Failed to install some packages: ${missing_packages[*]}"
        fi
    else
        print_success "All $description packages already installed"
    fi
}

install_rust_and_cargo_packages() {
    print_step "Installing Rust and Cargo packages..."
    
    if ! command -v rustc &> /dev/null; then
        print_step "Installing Rust via rustup..."
        curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
        source "$HOME/.cargo/env"
        print_success "Rust installed successfully"
    else
        print_warning "Rust is already installed"
    fi
    
    for package in "${RUST_PACKAGES[@]}"; do
        if command -v "$package" &> /dev/null; then
            print_warning "$package is already installed"
        else
            echo -e "${BLUE}Installing $package via cargo...${NC}"
            cargo install "$package" || print_error "Failed to install $package"
        fi
    done
}

install_nerd_fonts() {
    print_step "Installing JetBrainsMono Nerd Font..."
    
    mkdir -p "$FONTS_DIR"
    
    local font_url="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/JetBrainsMono.zip"
    local font_zip="/tmp/JetBrainsMono.zip"
    
    if [[ -f "$FONTS_DIR/JetBrainsMonoNerdFont-Regular.ttf" ]]; then
        print_warning "JetBrainsMono Nerd Font already installed"
        return
    fi
    
    print_step "Downloading JetBrainsMono Nerd Font..."
    wget -O "$font_zip" "$font_url"
    
    print_step "Extracting fonts..."
    unzip -o "$font_zip" -d "$FONTS_DIR"
    rm -f "$font_zip"
    
    print_step "Updating font cache..."
    fc-cache -fv
    
    print_success "JetBrainsMono Nerd Font installed successfully"
}

# ═══════════════════════════════════════════════════════════════════════════════
# 🔗 DOTFILES AND CONFIGURATION
# ═══════════════════════════════════════════════════════════════════════════════

setup_dotfiles() {
    print_step "Setting up dotfiles and configuration..."
    
    # Create config directory if it doesn't exist
    mkdir -p "$CONFIG_DIR"
    
    # Check if .config directory exists in dotfiles
    if [[ -d "$DOTFILES_DIR/.config" ]]; then
        print_step "Symlinking configuration files..."
        
        # Backup existing configs
        for config_item in "$DOTFILES_DIR/.config"/*; do
            if [[ -d "$config_item" ]]; then
                local config_name="$(basename "$config_item")"
                local target_path="$CONFIG_DIR/$config_name"
                
                if [[ -e "$target_path" && ! -L "$target_path" ]]; then
                    print_warning "Backing up existing $config_name to $config_name.backup"
                    mv "$target_path" "$target_path.backup"
                fi
                
                print_step "Linking $config_name..."
                ln -sf "$config_item" "$target_path"
                
                # Handle Alacritty TOML migration
                if [[ "$config_name" == "alacritty" ]]; then
                    if [[ -f "$target_path/alacritty.yml" ]]; then
                        print_warning "Removing deprecated alacritty.yml (using modern TOML format)"
                        rm -f "$target_path/alacritty.yml"
                    fi
                fi
            fi
        done
        
        # Handle .tmux.conf if it exists
        if [[ -f "$DOTFILES_DIR/.tmux.conf" ]]; then
            if [[ -f "$HOME/.tmux.conf" && ! -L "$HOME/.tmux.conf" ]]; then
                print_warning "Backing up existing .tmux.conf"
                mv "$HOME/.tmux.conf" "$HOME/.tmux.conf.backup"
            fi
            ln -sf "$DOTFILES_DIR/.tmux.conf" "$HOME/.tmux.conf"
            print_success ".tmux.conf linked successfully"
        fi
        
        # Ensure no conflicting tmux configs exist
        if [[ -d "$HOME/.config/tmux" ]]; then
            print_warning "Removing deprecated .config/tmux directory (using root-level .tmux.conf)"
            rm -rf "$HOME/.config/tmux"
            print_success "Cleaned up duplicate tmux configuration"
        fi
        
        print_success "Dotfiles setup completed"
    else
        print_warning "No .config directory found in dotfiles"
    fi
}

setup_shell() {
    print_step "Setting up Zsh as default shell..."
    
    if [[ "$SHELL" != *"zsh"* ]]; then
        print_step "Changing default shell to zsh..."
        chsh -s "$(which zsh)"
        print_success "Default shell changed to zsh"
    else
        print_warning "Zsh is already the default shell"
    fi
    
    # Install Oh My Zsh if not present
    if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
        print_step "Installing Oh My Zsh..."
        sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
        print_success "Oh My Zsh installed successfully"
    else
        print_warning "Oh My Zsh is already installed"
    fi
}

# ═══════════════════════════════════════════════════════════════════════════════
# 🧩 DEVELOPMENT TOOLS SETUP
# ═══════════════════════════════════════════════════════════════════════════════

setup_neovim() {
    print_step "Setting up Neovim with Lazy.nvim..."
    
    local nvim_config_dir="$CONFIG_DIR/nvim"
    
    # Install Lazy.nvim if not present
    local lazy_path="$HOME/.local/share/nvim/lazy/lazy.nvim"
    if [[ ! -d "$lazy_path" ]]; then
        print_step "Installing Lazy.nvim..."
        git clone --filter=blob:none https://github.com/folke/lazy.nvim.git --branch=stable "$lazy_path"
        print_success "Lazy.nvim installed successfully"
    else
        print_warning "Lazy.nvim is already installed"
    fi
    
    # Run nvim headlessly to install plugins if config exists
    if [[ -d "$nvim_config_dir" ]]; then
        print_step "Installing Neovim plugins..."
        nvim --headless -c "qall" 2>/dev/null || true
        print_success "Neovim plugins installation initiated"
    fi
}

setup_tmux() {
    print_step "Setting up Tmux..."
    
    # Install TPM (Tmux Plugin Manager) if not present
    local tpm_path="$HOME/.tmux/plugins/tpm"
    if [[ ! -d "$tpm_path" ]]; then
        print_step "Installing Tmux Plugin Manager..."
        git clone https://github.com/tmux-plugins/tpm "$tpm_path"
        print_success "TPM installed successfully"
    else
        print_warning "TPM is already installed"
    fi
    
    # Install tmux plugins if .tmux.conf exists
    if [[ -f "$HOME/.tmux.conf" ]]; then
        print_step "Installing Tmux plugins..."
        "$tpm_path/bin/install_plugins" || print_warning "Some tmux plugins might not have installed"
        print_success "Tmux plugins installation initiated"
    fi
}

setup_nodejs() {
    print_step "Setting up Node.js development environment..."
    
    # Install Node Version Manager (nvm) if not present
    if [[ ! -d "$HOME/.nvm" ]]; then
        print_step "Installing Node Version Manager (nvm)..."
        curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
        
        # Source nvm
        export NVM_DIR="$HOME/.nvm"
        [[ -s "$NVM_DIR/nvm.sh" ]] && \. "$NVM_DIR/nvm.sh"
        
        # Install latest LTS Node.js
        nvm install --lts
        nvm use --lts
        print_success "Node.js LTS installed via nvm"
    else
        print_warning "NVM is already installed"
    fi
}

# ═══════════════════════════════════════════════════════════════════════════════
# 🖥️ HYPRLAND SPECIFIC SETUP
# ═══════════════════════════════════════════════════════════════════════════════

setup_hyprland_services() {
    print_step "Setting up Hyprland services and autostart..."
    
    # Create autostart directory
    mkdir -p "$CONFIG_DIR/hypr"
    
    # Ensure Hyprland can access necessary groups
    local current_user="$(whoami)"
    sudo usermod -aG input "$current_user"
    sudo usermod -aG video "$current_user"
    
    print_success "Hyprland services configured"
}

setup_display_manager() {
    print_step "Setting up display manager for Hyprland..."
    
    # Install SDDM if not present
    if ! command -v sddm &> /dev/null; then
        print_step "Installing SDDM display manager..."
        sudo apt install -y sddm
        sudo systemctl enable sddm
        print_success "SDDM installed and enabled"
    else
        print_warning "SDDM is already installed"
    fi
    
    # Create Hyprland desktop entry
    local desktop_entry="/usr/share/wayland-sessions/hyprland.desktop"
    if [[ ! -f "$desktop_entry" ]]; then
        print_step "Creating Hyprland desktop entry..."
        sudo tee "$desktop_entry" > /dev/null <<EOF
[Desktop Entry]
Name=Hyprland
Comment=A dynamic tiling Wayland compositor
Exec=Hyprland
Type=Application
EOF
        print_success "Hyprland desktop entry created"
    else
        print_warning "Hyprland desktop entry already exists"
    fi
}

# ═══════════════════════════════════════════════════════════════════════════════
# 🎯 MAIN INSTALLATION FUNCTION
# ═══════════════════════════════════════════════════════════════════════════════

main() {
    print_header "VERTICAL CYBER INTELLIGENCE DEV TERMINAL INSTALLER"
    
    log_message "Starting Hyprland installation script"
    
    # Pre-flight checks
    check_root
    check_debian
    
    print_step "Starting installation process..."
    echo -e "${BOLD}${YELLOW}This script will install and configure:${NC}"
    echo "• Hyprland + Waybar + Alacritty + Rofi"
    echo "• Neovim with Lazy.nvim and Mason"
    echo "• Tmux with TPM (Tmux Plugin Manager)"
    echo "• Development tools (Node.js, Rust, Python)"
    echo "• JetBrainsMono Nerd Font"
    echo "• Audio/UX tools (pamixer, brightnessctl, etc.)"
    echo "• Optional packages (lazygit, btop, etc.)"
    echo ""
    
    if ! ask_confirmation "Do you want to continue with the installation?"; then
        print_warning "Installation cancelled by user"
        exit 0
    fi
    
    # Core installation steps
    update_system
    install_package_array CORE_PACKAGES "core system"
    install_package_array DEV_PACKAGES "development"
    install_package_array AUDIO_UX_PACKAGES "audio/UX"
    
    # Optional packages
    if ask_confirmation "Install optional packages (lazygit, btop, neofetch, etc.)?"; then
        install_package_array OPTIONAL_PACKAGES "optional"
    fi
    
    # Rust and cargo packages
    if ask_confirmation "Install Rust and modern CLI tools (zoxide, exa, bat, starship)?"; then
        install_rust_and_cargo_packages
    fi
    
    # Fonts
    install_nerd_fonts
    
    # Configuration setup
    setup_dotfiles
    setup_shell
    setup_neovim
    setup_tmux
    setup_nodejs
    
    # Hyprland specific setup
    setup_hyprland_services
    setup_display_manager
    
    # Final steps
    print_header "INSTALLATION COMPLETE!"
    
    echo -e "${BOLD}${GREEN}✅ Installation Summary:${NC}"
    echo "• System packages updated and installed"
    echo "• Hyprland window manager configured"
    echo "• Development environment set up"
    echo "• Dotfiles linked and configured"
    echo "• Fonts installed and cached"
    echo "• Services enabled and configured"
    echo ""
    
    echo -e "${BOLD}${YELLOW}🔄 Next Steps:${NC}"
    echo "1. Log out of your current session"
    echo "2. Select 'Hyprland' from the display manager"
    echo "3. Log in with your credentials"
    echo "4. Press Super+Enter to open Alacritty terminal"
    echo "5. Press Super+D to open Rofi application launcher"
    echo ""
    
    echo -e "${BOLD}${CYAN}📋 Key Shortcuts:${NC}"
    echo "• Super+Enter: Open terminal (Alacritty)"
    echo "• Super+D: Application launcher (Rofi)"
    echo "• Super+Q: Close window"
    echo "• Super+F: Toggle fullscreen"
    echo "• Super+[1-9]: Switch workspaces"
    echo ""
    
    echo -e "${BOLD}${MAGENTA}🔧 Configuration Files:${NC}"
    echo "• Hyprland: ~/.config/hypr/"
    echo "• Neovim: ~/.config/nvim/"
    echo "• Alacritty: ~/.config/alacritty/"
    echo "• Waybar: ~/.config/waybar/"
    echo "• Tmux: ~/.tmux.conf"
    echo ""
    
    log_message "Installation completed successfully"
    
    if ask_confirmation "Would you like to reboot now to start using Hyprland?"; then
        print_step "Rebooting system..."
        sudo reboot
    else
        print_success "Installation complete! Please reboot when ready."
    fi
}

# ═══════════════════════════════════════════════════════════════════════════════
# 🚀 SCRIPT EXECUTION
# ═══════════════════════════════════════════════════════════════════════════════

# Create log file
touch "$LOG_FILE"

# Handle script interruption
trap 'print_error "Installation interrupted"; exit 1' INT TERM

# Run main function
main "$@" 