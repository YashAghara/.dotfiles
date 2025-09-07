if status is-interactive
    # Commands to run in interactive sessions can go here
end

fish_config theme choose "rose-pine"

if command -sq nvim
    set -gx EDITOR nvim
    set -gx VISUAL nvim
    set -gx MANPAGER 'nvim +Man!'
end

# Set up fzf key bindings
fzf --fish | source

starship init fish | source
