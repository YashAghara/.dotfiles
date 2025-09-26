if status is-interactive
    # Commands to run in interactive sessions can go here

    # Set EDITOR, VISUAL, MANPAGER if nvim is available
    if command -sq nvim
        set -gx EDITOR nvim
        set -gx VISUAL nvim
        set -gx MANPAGER 'nvim +Man!'
    end

    # fzf key bindings
    fzf --fish | source

    # Starship prompt
    starship init fish | source
end

# Activate mise if available
if command -sq mise
    mise activate fish | source
end

# Vi Mode
# function fish_user_key_bindings
#     fish_vi_key_bindings
# end
