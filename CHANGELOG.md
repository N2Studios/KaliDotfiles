# CHANGELOG

All notable changes to this Kali Linux Dotfiles project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [2025-01-22] - GitOps Hardening & Security Audit

### Added
- **Pre-commit Hook**: Comprehensive security hook at `.git/hooks/pre-commit`
  - Prevents committing backup files (`*~`, `*.bak`, `*.backup`)
  - Blocks editor swap/temp files (`*.swp`, `*.swo`, `*.tmp`)
  - Filters system files (`.DS_Store`, `.Trash*`, `*.log`)
  - Includes threat detection for sensitive file patterns
  - POSIX-compliant shell script with colored output
- **Watchdog Script**: New monitoring script at `scripts/watchdog.sh`
  - Real-time file system monitoring for unauthorized changes
  - Alerts on config modifications outside approved directories
  - Prevents configuration drift and unauthorized access
- **Backup Branch**: Created `.backup/legacy-v1` branch for archived configurations
  - Stores pre-2025 configuration files
  - Maintains audit trail of previous setups
  - Enables rollback capabilities if needed

### Enhanced
- **Configuration Structure**: Organized `.config/` directory with:
  - `alacritty/` - Terminal emulator configuration
  - `hypr/` - Hyprland compositor settings  
  - `nvim/` - Neovim editor configuration
  - `waybar/` - Status bar configuration
  - `rofi/` - Application launcher settings
  - `btop/` - System monitor configuration
  - `sxhkd/` - Hotkey daemon configuration
  - `colors/` - Color scheme definitions
- **Install Script**: Comprehensive `install.sh` with:
  - Automated dependency installation
  - System-specific configuration detection
  - Error handling and rollback mechanisms
  - Security-focused setup procedures
- **Scripts Collection**: Enhanced utility scripts:
  - `cleanup-dotfiles` - Automated cleanup and maintenance
  - `project-launcher` - Intelligent project discovery and launch
  - `system-info` - Comprehensive system information gathering

### Security
- **Hardened Git Operations**: 
  - Pre-commit hooks prevent accidental sensitive file commits
  - Backup branch strategy for configuration versioning
  - Watchdog monitoring for unauthorized file changes
- **Configuration Audit**: 
  - Removed redundant configuration files
  - Consolidated overlapping settings
  - Eliminated potential security vulnerabilities
- **Access Control**: 
  - Proper file permissions on scripts and configurations
  - Secure defaults for all configuration files
  - Monitoring for unauthorized modifications

### Performance
- **Optimized Configurations**:
  - Streamlined Neovim setup with LSP integration
  - Efficient tmux configuration with custom key bindings
  - Lightweight Alacritty terminal settings
  - Optimized Waybar modules for minimal resource usage
- **Script Efficiency**:
  - Reduced redundant operations in utility scripts
  - Improved error handling and recovery
  - Better resource management in monitoring scripts

### Maintenance
- **Automated Cleanup**: 
  - Removed obsolete configuration files
  - Consolidated duplicate settings
  - Cleaned up temporary and backup files
- **Documentation**: 
  - Enhanced README with current setup instructions
  - Added inline comments to configuration files
  - Improved script documentation and usage examples

### Breaking Changes
- **File Relocations**: 
  - Moved individual config files to `.config/` directory structure
  - Updated symlink targets in install script
  - Legacy configurations archived in backup branch

### Migration Notes
- Users upgrading from pre-2025 versions should:
  1. Review the new `.config/` directory structure
  2. Run the updated `install.sh` script
  3. Check the `.backup/legacy-v1` branch for previous configurations
  4. Validate all symbolic links point to correct targets

---

## [Previous Versions]
Previous changelog entries will be maintained in the `.backup/legacy-v1` branch for historical reference.

---

**Note**: This changelog follows the GitOps principles of transparent, auditable, and versioned infrastructure management. All changes are tracked, tested, and documented for security and reliability purposes. 