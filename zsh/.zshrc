# zmodload zsh/zprof
# Load zsh's profiling module to measure performance of shell initialization.

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"


# Download zinit, if it's not there yet
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
# Source zinit for managing plugins.

source "${ZINIT_HOME}/zinit.zsh"

# Initialize Homebrew environment.
# This is necessary to ensure Homebrew commands work in the shell.`
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# Load the Oh-My-Posh prompt configuration.
eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/omp.toml)"

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Load additional functionality from Oh-My-Zsh snippets.
zinit snippet OMZP::command-not-found

# Initialize completion system.
autoload -Uz compinit && compinit

# Prevent duplicate directory replay from zinit.
zinit cdreplay -q


# History configuration.
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Enable arrow key-based history search.
bindkey '^[[A' history-search-backward # Up arrow key to search backward.
bindkey '^[[B' history-search-forward  # Down arrow key to search forward.

# Configure completion behavior and styling.
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'  # Case-insensitive completion.
zstyle ':completion:*' menu no                          # Disable menu-based completion.
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza --color=always --icons --oneline $realpath'
# Use eza for directory preview during fuzzy tab completion.


# Aliases for convenience and improved visuals.
alias ls='eza --color=always --icons'        # Use eza (modern replacement for ls) with color and icons.
alias ll='eza --color=always --icons --long' # Detailed listing.
alias la='eza --color=always --icons --all'  # Show hidden files.

# Enable fzf integration for zsh.
eval "$(fzf --zsh)"

# Update PATH to include custom binaries.
export PATH=$HOME/.local/bin:$PATH

# Use Neovim as the man page viewer.
export MANPAGER='nvim +Man!'

export PAGER="bat"


if [ -z "$TMUX" ] && [ ${UID} != 0 ]
then
    tmux new-session -A -s main
fi

# Display system information on startup using fastfetch.
# fastfetch

# zprof
# End of file. Profile and measure zsh initialization performance if needed.
