# 🔥 Vertical Cyber Intelligence Terminal System

**Elite Hyprland + AI-Augmented Development Environment for Kali Linux**

<div align="center">

![Kali Linux](https://img.shields.io/badge/Kali_Linux-557C94?style=for-the-badge&logo=kali-linux&logoColor=white)
![Hyprland](https://img.shields.io/badge/Hyprland-00D4FF?style=for-the-badge&logo=wayland&logoColor=white)
![Neovim](https://img.shields.io/badge/NeoVim-57A143?style=for-the-badge&logo=neovim&logoColor=white)
![Security](https://img.shields.io/badge/Security-Hardened-FF4F00?style=for-the-badge&logo=security&logoColor=white)
![GitOps](https://img.shields.io/badge/GitOps-Enabled-00D4FF?style=for-the-badge&logo=gitpod&logoColor=white)
![AI](https://img.shields.io/badge/AI-Augmented-FF6B00?style=for-the-badge&logo=artificial-intelligence&logoColor=white)

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Maintenance](https://img.shields.io/badge/Maintained%3F-yes-green.svg)](https://github.com/N2Studios/KaliDotfiles/graphs/commit-activity)
[![Security](https://img.shields.io/badge/Security-Audit%20Complete-success.svg)](https://github.com/N2Studios/KaliDotfiles/blob/main/CHANGELOG.md)

</div>

---

## 🎯 Mission Objective

**Vertical** is a production-hardened, AI-augmented terminal system designed for **elite cybersecurity professionals** and **advanced developers** who demand maximum performance, security, and operational efficiency. Built on **Kali Linux** with **Hyprland** as the foundation, this system provides a keyboard-first, blazing-fast environment optimized for:

- **Penetration Testing** & Red Team Operations
- **AI-Assisted Development** with Sierra CLI integration
- **Operational Security** (OpSec) workflows
- **Advanced System Administration**
- **Threat Intelligence** gathering and analysis

**Security Level**: 🔐 **Production-Hardened** (2025 GitOps Standards)

---

## 🧱 Core Technology Stack

### 🪟 **Compositor & Window Management**
- **Hyprland** - Wayland-native tiling with GPU acceleration
- **Waybar** - Intelligent HUD with system monitoring
- **sxhkd** - Global hotkey daemon for rapid operations

### 💻 **Terminal & Development**
- **Alacritty** - GPU-accelerated terminal emulator
- **Tmux** - Advanced session management with custom layouts
- **Neovim** - Hyperextensible editor with LSP + Mason + Lazy
- **ToggleTerm** - Integrated terminal management within Neovim

### 🔐 **Security & Monitoring**
- **Watchdog System** - Real-time filesystem monitoring
- **Git Pre-commit Hooks** - Automated security validation
- **Audit Logging** - Comprehensive change tracking
- **Backup Strategy** - Automated configuration versioning

### 🤖 **AI Integration**
- **Sierra CLI** - AI assistant for development and operations
- **Intelligent Autocomplete** - Context-aware suggestions
- **Code Analysis** - AI-powered security scanning

### 🎨 **Theming & Aesthetics**
- **Cyber Ops Theme** - Professional orange/black color scheme
- **Nerd Font Integration** - Perfect glyph rendering
- **Opacity & Blur** - Modern transparency effects
- **Modular Colors** - Centralized theme management

---

## 🛠️ Installation

### 📋 Prerequisites
- **Kali Linux** 2024.x (minimal or full installation)
- **GPU with Wayland support** (Intel/AMD/NVIDIA)
- **4GB+ RAM** recommended
- **Regular user account** (not root)
- **Internet connection** for package downloads

### 🚀 Quick Installation

```bash
# Clone the repository
git clone https://github.com/N2Studios/KaliDotfiles.git
cd KaliDotfiles

# Make installer executable and run
chmod +x install.sh && ./install.sh
```

### 🔄 Post-Installation Steps

1. **System Reboot** - Apply all system changes
2. **Login to Hyprland** - Select from display manager
3. **Initialize Tmux Plugins** - `tmux` → `Ctrl+a, I`
4. **Setup Neovim** - `nvim` → `:Lazy sync` → `:Mason`
5. **Verify Installation** - Run `./scripts/system-info`

---

## ⌨️ Keybindings Cheat Sheet

### 🪟 **Hyprland (Window Management)**
| Keybind | Action |
|---------|--------|
| `Super + Enter` | Launch Alacritty terminal |
| `Super + Space` | App launcher (Rofi) |
| `Super + Q` | Close active window |
| `Super + F` | Toggle floating mode |
| `Super + M` | Toggle fullscreen |
| `Super + 1-9` | Switch to workspace |
| `Super + Shift + 1-9` | Move window to workspace |
| `Super + H/J/K/L` | Navigate windows (vim-style) |
| `Super + Shift + H/J/K/L` | Move windows |

### 🖥️ **Tmux (Session Management)**
| Keybind | Action |
|---------|--------|
| `Ctrl + A` | Prefix key |
| `Prefix + C` | Create new window |
| `Prefix + \|` | Split vertically |
| `Prefix + -` | Split horizontally |
| `Prefix + H/J/K/L` | Navigate panes |
| `Prefix + R` | Reload configuration |
| `Prefix + I` | Install plugins |

### 📝 **Neovim (Editor)**
| Keybind | Action |
|---------|--------|
| `<Leader>ff` | Find files (Telescope) |
| `<Leader>fg` | Live grep |
| `<Leader>fb` | Browse buffers |
| `<Leader>e` | Toggle file explorer |
| `<Leader>gs` | Git status |
| `<Leader>ca` | Code actions |
| `<Leader>rn` | Rename symbol |
| `gd` | Go to definition |

### 🔧 **System & Operations**
| Keybind | Action |
|---------|--------|
| `Ctrl + Alt + T` | Sierra AI Terminal |
| `Super + Ctrl + B` | System monitor (btop) |
| `Super + P` | Screenshot (area) |
| `Super + Shift + P` | Screenshot (full) |
| `Super + B` | Toggle Waybar |
| `Super + R` | Ranger file manager |

---

## 🔐 Security & Maintenance

### 🛡️ **Security Features**
- **Pre-commit Hooks** - Prevent accidental commit of sensitive files
- **Watchdog Monitoring** - Real-time filesystem change detection
- **Audit Logging** - Complete change tracking and accountability
- **Configuration Validation** - Automated security checks
- **Backup Strategy** - Automated rollback capabilities

### 🔧 **Maintenance Tools**
```bash
# Run system health check
./scripts/system-info

# Clean up dotfiles and temporary files
./scripts/cleanup-dotfiles

# Launch AI-assisted project management
./scripts/project-launcher

# Monitor filesystem for unauthorized changes
./scripts/watchdog.sh --daemon
```

### 📊 **Health Checks**
- **Neovim**: `:checkhealth` - Validate LSP and plugin status
- **System**: `./scripts/system-info` - Comprehensive system overview
- **Tmux**: `tmux list-sessions` - Session management status
- **Hyprland**: `hyprctl monitors` - Display configuration

---

## 🗂️ Directory Structure

```
KaliDotfiles/
├── 📁 .config/                    # Application configurations
│   ├── 📂 alacritty/              # Terminal emulator config
│   │   └── alacritty.toml
│   ├── 📂 btop/                   # System monitor
│   │   ├── btop.conf
│   │   └── themes/cyber-ops.theme
│   ├── 📂 colors/                 # Centralized color schemes
│   │   └── cyber-ops-theme.conf
│   ├── 📂 hypr/                   # Hyprland compositor
│   │   └── hyprland.conf
│   ├── 📂 nvim/                   # Neovim editor
│   │   ├── init.lua
│   │   └── lua/plugins/lsp.lua
│   ├── 📂 rofi/                   # Application launcher
│   │   ├── config.rasi
│   │   └── cyber-ops.rasi
│   ├── 📂 sxhkd/                  # Global hotkeys
│   │   └── sxhkdrc
│   └── 📂 waybar/                 # Status bar
│       ├── config
│       └── style.css
├── 📁 scripts/                    # System utilities
│   ├── 🔧 cleanup-dotfiles        # Automated maintenance
│   ├── 🚀 project-launcher        # AI-assisted project management
│   ├── 📊 system-info            # System health diagnostics
│   └── 👁️ watchdog.sh             # Security monitoring
├── 📁 .git/hooks/                 # Git security hooks
│   └── pre-commit                 # Security validation
├── 📄 .tmux.conf                  # Tmux configuration
├── 📄 install.sh                  # Installation script
├── 📄 CHANGELOG.md               # Change documentation
└── 📄 README.md                  # This file
```

---

## 📊 Changelog

For detailed information about recent changes, security audits, and system improvements, see our comprehensive [CHANGELOG.md](CHANGELOG.md).

### 🔥 **Recent Major Updates (2025-01-22)**
- ✅ **GitOps Hardening Complete** - Full security audit and hardening
- ✅ **Pre-commit Hooks** - Automated security validation
- ✅ **Watchdog System** - Real-time filesystem monitoring
- ✅ **Backup Strategy** - Configuration versioning with `backup/legacy-v1`
- ✅ **Documentation Overhaul** - Complete system documentation
- ✅ **Performance Optimization** - Streamlined configurations
- ✅ **Security Consolidation** - Removed redundant and vulnerable configs

---

## 🧪 System Validation

### 🔍 **Health Check Commands**
```bash
# Comprehensive system information
./scripts/system-info

# Check Neovim health
nvim +checkhealth

# Validate Hyprland configuration
hyprctl reload

# Test tmux setup
tmux new-session -d -s test-session && tmux kill-session -t test-session

# Verify watchdog functionality
./scripts/watchdog.sh --status
```

### 🚨 **Troubleshooting**
Common issues and solutions:

```bash
# Hyprland won't start
journalctl -u hyprland --since "10 minutes ago"

# Fonts not rendering
fc-cache -fv && fc-list | grep -i nerd

# Waybar not displaying
killall waybar && waybar &

# Neovim LSP issues
nvim +checkhealth +q
```

---

## 🤝 Contributing

We welcome contributions that maintain our security and quality standards:

1. **Fork** the repository
2. **Create** a feature branch: `git checkout -b feature/amazing-feature`
3. **Test** thoroughly on fresh Kali installation
4. **Commit** with conventional commits: `git commit -m "feat: add amazing feature"`
5. **Push** to branch: `git push origin feature/amazing-feature`
6. **Submit** a Pull Request

### 📋 **Development Guidelines**
- Follow existing code style and security practices
- Test all changes on clean Kali Linux installation
- Update documentation for user-facing changes
- Include security considerations in PR description
- All commits must pass pre-commit hooks

---

## 📜 License

This project is licensed under the **MIT License** - see the [LICENSE](LICENSE) file for details.

---

## 🙏 Acknowledgments

### 🏆 **Core Technologies**
- **[Hyprland](https://hyprland.org/)** - Next-gen Wayland compositor
- **[Neovim](https://neovim.io/)** - Hyperextensible text editor
- **[Alacritty](https://alacritty.org/)** - GPU-accelerated terminal
- **[Tmux](https://tmux.github.io/)** - Terminal multiplexer
- **[Waybar](https://github.com/Alexays/Waybar)** - Customizable status bar

### 🎨 **Design & Fonts**
- **[Nerd Fonts](https://nerdfonts.com/)** - Icon-enhanced fonts
- **[JetBrains Mono](https://jetbrains.com/mono/)** - Developer typography

---

## 📞 Support & Community

- **🐛 Issues**: [GitHub Issues](https://github.com/N2Studios/KaliDotfiles/issues)
- **💬 Discussions**: [GitHub Discussions](https://github.com/N2Studios/KaliDotfiles/discussions)
- **📚 Documentation**: [Project Wiki](https://github.com/N2Studios/KaliDotfiles/wiki)
- **🔐 Security**: [Security Policy](https://github.com/N2Studios/KaliDotfiles/security)

---

<div align="center">

**🔥 Built for Elite Cyber Operations**

*Where Security Meets Performance*

**[⭐ Star this repo](https://github.com/N2Studios/KaliDotfiles) if it powers your operations!**

</div>