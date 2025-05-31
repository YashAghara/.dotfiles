if status is-interactive
    # Commands to run in interactive sessions can go here
end

fish_config theme choose "Rosé Pine"

set -gx PAGER moar
set -gx EDITOR nvim

# Set up fzf key bindings
fzf --fish | source
