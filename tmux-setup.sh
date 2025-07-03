#!/bin/bash
# Legacy tmux setup script - Pre-2025 Archive
# This script was used for initial tmux configuration before the GitOps hardening
# Archived on 2025-01-22 as part of the security audit and cleanup process

# Archive metadata
# Original purpose: Initial tmux setup and configuration
# Backup created: 2025-01-22
# Reason: Replaced by comprehensive install.sh script
# Migration path: See current install.sh for modern setup approach

set -e

echo "Legacy tmux setup script - ARCHIVED"
echo "This script is no longer active and has been replaced by install.sh"
echo "See the main branch for the current installation and setup procedures"

# Legacy function examples (preserved for reference)
setup_tmux_legacy() {
    echo "Setting up tmux with legacy configuration..."
    
    # Install tmux if not present
    if ! command -v tmux &> /dev/null; then
        echo "Installing tmux..."
        sudo apt-get update
        sudo apt-get install -y tmux
    fi
    
    # Copy legacy configuration
    if [ -f "$HOME/.tmux.conf" ]; then
        echo "Backing up existing tmux configuration..."
        cp "$HOME/.tmux.conf" "$HOME/.tmux.conf.backup"
    fi
    
    # Install legacy tmux configuration
    echo "Installing legacy tmux configuration..."
    cp ".tmux.conf.bak" "$HOME/.tmux.conf"
    
    echo "Legacy tmux setup complete!"
    echo "Note: This is the old setup method. Use install.sh for current setup."
}

# Legacy configuration validation
validate_legacy_config() {
    echo "Validating legacy tmux configuration..."
    
    if tmux list-sessions &> /dev/null; then
        echo "Tmux is running, checking configuration..."
        tmux show-options -g | grep -E "(prefix|mouse|default-terminal)"
    else
        echo "No active tmux sessions found"
    fi
}

# Main execution (disabled in archive)
main() {
    echo "=========================================="
    echo "LEGACY TMUX SETUP SCRIPT - ARCHIVED"
    echo "=========================================="
    echo ""
    echo "This script has been archived and is no longer functional."
    echo "Please use the current install.sh script for modern setup."
    echo ""
    echo "To see the current setup process:"
    echo "  git checkout main"
    echo "  ./install.sh"
    echo ""
    echo "This archive is preserved for historical reference only."
    echo "=========================================="
}

# Execute main function
main "$@" 