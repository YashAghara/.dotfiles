---
# Setting up Dotfiles on Linux
This guide demonstrates setting up essential tools and configurations for a customized Linux environment, including dotfiles management.
---

## Installing Required Packages
Install the following tools to enhance your terminal experience:

- git: Version control system
- stow: Symlink manager for dotfiles
- ghostty: Terminal theme manager
- alacritty: GPU-accelerated terminal emulator
- helix: Terminal-based text editor
- oh-my-posh: Prompt theming engine
- tmux: Terminal multiplexer
- zellij: Terminal workspace manager
- zsh: Shell replacement
- eza: Modern replacement for ls
- fzf: Fuzzy finder
- fastfetch: System info tool
- tealdeer: Simplified man pages
- bat: Syntax-highlighted cat replacement
- Neovim:
- Homebrew:


### Install homebrew
```Bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```
- add homebrew to your `.rc` file path
```Bash
# For Bash
echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> /home/aghara/.bashrc

# For Zsh
echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> /home/aghara/.bashrc
```

### Install oh-my-posh
```Bash
brew install oh-my-posh
```

### Command (Example for openSUSE Tumbleweed)
Replace zypper with your package manager command if you're using a different Linux distribution (e.g., apt, dnf, pacman).
```Bash
sudo zypper install git stow ghostty alacritty helix tmux zellij zsh eza fzf fastfetch tealdeer bat
```

## Installing the Required Font
Install a Nerd Font to ensure proper rendering of symbols and icons in your terminal and tools. Popular options include `0xProto Nerd Font`,`Fira Code Nerd Font` and `Hack Nerd Font`.

## Setting Up ZSH

### 1. Verify ZSH Installation
Run the following command to check if ZSH is installed:
```Bash
zsh --version
```
If it’s not installed, follow the installation instructions [here](https://www.nerdfonts.com/).
### 2. Set ZSH as the Default Shell
Make ZSH your default shell:
```Bash
chsh -s $(which zsh)
```
Restart your terminal for the changes to take effect.
### 3. Customize ZSH Prompt with Oh My Posh
Install and configure [Oh My Posh](https://ohmyposh.dev/docs/installation/linux) for a personalized and feature-rich shell prompt.
