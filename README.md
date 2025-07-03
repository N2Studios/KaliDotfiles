# 🔥 Cyber Ops Dotfiles

**Elite Hyprland setup for Kali Linux - Cybersecurity development environment**

<div align="center">

![Kali Linux](https://img.shields.io/badge/Kali_Linux-557C94?style=for-the-badge&logo=kali-linux&logoColor=white)
![Hyprland](https://img.shields.io/badge/Hyprland-00D4FF?style=for-the-badge&logo=wayland&logoColor=white)
![Neovim](https://img.shields.io/badge/NeoVim-57A143?style=for-the-badge&logo=neovim&logoColor=white)
![Terminal](https://img.shields.io/badge/Alacritty-F46800?style=for-the-badge&logo=alacritty&logoColor=white)

</div>

## 🎯 Overview

This repository contains a complete dotfiles setup designed for **cybersecurity professionals** and **elite developers** running **Kali Linux** with **Hyprland** as the window manager. The configuration creates a blazing-fast, keyboard-driven environment optimized for penetration testing, development, and operational security tasks.

### 🎨 Theme
- **Background**: Jet black (`#0A0A0A`)
- **Accent**: Electric orange (`#FF4F00`)
- **Opacity**: 85% for terminals and windows
- **Features**: Rounded corners, blur effects, neon-style borders

---

## ✨ Features

### 🪟 Window Management (Hyprland)
- **Wayland-native** tiling window manager
- **Smooth animations** with custom bezier curves
- **Blur effects** and transparency
- **Rounded corners** with orange accent borders
- **10 workspaces** with app-specific auto-assignment
- **Gesture support** for laptop users

### 🗂️ Status Bar (Waybar)
- **Transparent HUD** with orange accents
- **System monitoring** (CPU, memory, temperature)
- **Network status** and battery indicator
- **Custom Sierra AI operations module**
- **Weather integration**
- **Click-to-launch** functionality

### 💻 Terminal (Alacritty)
- **85% opacity** with blur effects
- **JetBrainsMono Nerd Font** for perfect glyphs
- **Orange cursor** and selection highlights
- **Optimized colors** for readability
- **Vim-like keybindings**

### 🛠️ Development Environment

#### 📝 Editor (Neovim)
- **LSP support** for 12+ languages
- **Telescope** fuzzy finder
- **Treesitter** syntax highlighting
- **Auto-completion** with nvim-cmp
- **Git integration** with gitsigns
- **File explorer** with nvim-tree
- **Custom cyber ops theme**

#### 🔧 Terminal Multiplexer (Tmux)
- **Orange & black theme** matching overall aesthetic
- **Vim-like navigation** (hjkl keys)
- **Session management** with fuzzy switching
- **Plugin ecosystem** with TPM
- **Custom layouts** for dev and ops workflows

#### 🚀 App Launcher (Rofi)
- **Transparent design** with orange highlights
- **Fuzzy searching** with icons
- **Custom cyber ops theme**
- **SSH and window switching** modes

### 🎯 Cyber Ops Integration
- **Pre-configured tools**: Burp Suite, Wireshark, Nmap, Metasploit
- **Sierra AI CLI** integration (Ctrl+Alt+T)
- **Custom hotkeys** for penetration testing workflows
- **Docker support** for isolated environments
- **Python security libraries** pre-installed

---

## 🚀 Installation

### Prerequisites
- **Kali Linux** (tested on 2024.x)
- **Git** installed
- **Internet connection** for package downloads
- **Regular user account** (not root)

### Quick Install

```bash
# Clone the repository
git clone https://github.com/yourusername/Kali_Dotfiles.git
cd Kali_Dotfiles

# Make installer executable
chmod +x install.sh

# Run the installation script
./install.sh
```

### What the installer does:
1. **Updates system** and installs required packages
2. **Installs Hyprland** and Wayland components
3. **Downloads Nerd Fonts** (JetBrainsMono, Iosevka, FiraCode)
4. **Installs development tools** (Node.js, Python, Rust, Go)
5. **Sets up Oh My Zsh** with plugins and themes
6. **Creates symlinks** for all configuration files
7. **Configures services** and environment variables
8. **Installs cybersecurity tools** and frameworks

### Post-Installation
1. **Logout and login** to apply shell changes
2. **Start Hyprland** from display manager
3. **Install Tmux plugins**: `tmux` → `Ctrl+a, I`
4. **Install Neovim plugins**: `nvim` → `:Lazy sync`

---

## ⌨️ Hotkeys

### Window Management
| Key | Action |
|-----|--------|
| `Super + Enter` | Open Alacritty terminal |
| `Super + Space` | App launcher (Rofi) |
| `Super + D` | File manager (Thunar) |
| `Super + Q` | Close window |
| `Super + F` | Toggle floating |
| `Super + M` | Toggle fullscreen |
| `Super + 1-9` | Switch to workspace |
| `Super + Shift + 1-9` | Move window to workspace |

### System Controls
| Key | Action |
|-----|--------|
| `Super + P` | Screenshot (area) |
| `Super + Shift + P` | Screenshot (full) |
| `Super + B` | Toggle Waybar |
| `Super + H/J/K/L` | Navigate windows (vim-like) |
| `Super + Shift + H/J/K/L` | Move windows |

### Development Shortcuts
| Key | Action |
|-----|--------|
| `Super + N` | Neovim in terminal |
| `Super + R` | Ranger file manager |
| `Super + G` | Lazygit |
| `Super + Z` | System monitor (btop) |
| `Super + W` | Firefox |
| `Super + E` | VSCode |

### Cyber Ops Specific
| Key | Action |
|-----|--------|
| `Ctrl + Alt + T` | Sierra AI CLI |
| `Super + Ctrl + B` | Burp Suite |
| `Super + Ctrl + W` | Wireshark |

---

## 📁 Structure

```
Kali_Dotfiles/
├── .config/
│   ├── hypr/           # Hyprland configuration
│   │   └── hyprland.conf
│   ├── waybar/         # Status bar
│   │   ├── config
│   │   └── style.css
│   ├── alacritty/      # Terminal emulator
│   │   └── alacritty.toml
│   ├── nvim/           # Neovim configuration
│   │   ├── init.lua
│   │   └── lua/plugins/
│   ├── rofi/           # App launcher
│   │   ├── config.rasi
│   │   └── cyber-ops.rasi
│   ├── sxhkd/          # Global hotkeys
│   │   └── sxhkdrc
│   ├── btop/           # System monitor
│   │   ├── btop.conf
│   │   └── themes/
│   └── colors/         # Theme colors
│       └── cyber-ops-theme.conf
├── scripts/            # Custom utilities
│   ├── cleanup-dotfiles
│   ├── project-launcher
│   └── system-info
├── .tmux.conf          # Tmux configuration
├── install.sh          # Installation script
└── README.md          # This file
```

---

## 🛠️ Customization

### Colors
The color scheme is defined in each configuration file:
- **Background**: `#0A0A0A` (jet black)
- **Accent**: `#FF4F00` (electric orange)
- **Secondary**: `#FF6B00` (orange variant)
- **Text**: `#FFFFFF` (white)
- **Dimmed**: `#CCCCCC` (light gray)

### Fonts
Primary font stack:
1. **JetBrainsMono Nerd Font** (main)
2. **Iosevka Nerd Font** (alternative)
3. **FiraCode Nerd Font** (coding)

### Opacity Settings
- **Alacritty**: 85%
- **Waybar**: 90%
- **Rofi**: 95%
- **Inactive windows**: 85%

---

## 🔧 Development Tools

### Languages & Runtimes
- **Python 3.x** with security libraries
- **Node.js** with modern tooling
- **Rust** with cargo
- **Go** latest stable
- **C/C++** with GCC/Clang

### Security Tools
- **Burp Suite Community**
- **Wireshark** with GUI
- **Nmap** with scripts
- **Metasploit Framework**
- **Aircrack-ng** suite
- **Hashcat** password cracking
- **John the Ripper**
- **Hydra** brute force
- **Gobuster** directory enumeration
- **SQLMap** SQL injection

### Development Utilities
- **Docker** & Docker Compose
- **Git** with GitHub CLI
- **Tmux** session management
- **Fzf** fuzzy finder
- **Ripgrep** fast search
- **Bat** enhanced cat
- **Exa** modern ls
- **Zoxide** smart cd

---

## 🔍 Troubleshooting

### Common Issues

#### Hyprland won't start
```bash
# Check if Hyprland is installed
hyprland --version

# Check logs
journalctl -u hyprland

# Verify Wayland support
echo $XDG_SESSION_TYPE
```

#### Fonts not displaying correctly
```bash
# Refresh font cache
fc-cache -fv

# List available fonts
fc-list | grep -i jetbrains
```

#### Waybar not showing
```bash
# Check if waybar is running
pgrep waybar

# Start waybar manually
waybar &

# Check configuration
waybar -c ~/.config/waybar/config -s ~/.config/waybar/style.css
```

### Performance Issues
- **Reduce animations**: Edit `hyprland.conf` animation settings
- **Disable blur**: Set `blur.enabled = false` in Hyprland config
- **Lower opacity**: Adjust transparency settings
- **Limit workspaces**: Use fewer virtual desktops

---

## 🤝 Contributing

1. **Fork** the repository
2. **Create** a feature branch
3. **Make** your changes
4. **Test** thoroughly on Kali Linux
5. **Submit** a pull request

### Development Guidelines
- Follow existing code style
- Test on fresh Kali installation
- Update documentation
- Add screenshots for visual changes

---

## 📜 License

This project is licensed under the **MIT License** - see the [LICENSE](LICENSE) file for details.

---

## 🙏 Credits

- **Hyprland** - Amazing Wayland compositor
- **Waybar** - Highly customizable status bar
- **Alacritty** - GPU-accelerated terminal
- **Neovim** - Hyperextensible editor
- **Tmux** - Terminal multiplexer
- **Rofi** - Window switcher and app launcher
- **Nerd Fonts** - Iconic font aggregator

---

## 📞 Support

- **Issues**: [GitHub Issues](https://github.com/yourusername/Kali_Dotfiles/issues)
- **Discussions**: [GitHub Discussions](https://github.com/yourusername/Kali_Dotfiles/discussions)
- **Wiki**: [Project Wiki](https://github.com/yourusername/Kali_Dotfiles/wiki)

---

<div align="center">

**Made with ❤️ for the cybersecurity community**

*Elite tools for elite operators*

</div>