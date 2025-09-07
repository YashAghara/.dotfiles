function ovim
    # Define your vault root folder
    set vault_root "~/Documents/Obsidian"

    # Expand ~ to full path
    set expanded_root (eval echo $vault_root)

    # Collect vaults (top-level folders only)
    set vaults (find $expanded_root -mindepth 1 -maxdepth 1 -type d 2>/dev/null)

    # Use fzf to pick
    set choice (printf "%s\n" $vaults | fzf --style full --preview 'ls -la {}' --no-sort)

    # cd and open Neovim
    if test -n "$choice"
        cd "$choice"
        nvim .
    end
end
