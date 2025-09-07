function nvid
    # Define root directories with max depth
    set roots_with_depths \
        "~/Documents/Programming/languages:2" \
        "~/Documents/Programming/projects:1" \
        "~/.dotfiles:3"
	# "~/.config:1"

    # Collect directories
    set dirs
    for entry in $roots_with_depths
        set root (string split ':' $entry)[1]
        set depth (string split ':' $entry)[2]
        set expanded_root (eval echo $root)  # Expand ~ to full path
        if test -d $expanded_root
            set found_dirs (find $expanded_root \
                -mindepth $depth -maxdepth $depth -type d \
                ! -name '.git' ! -path '*/.git/*' 2>/dev/null)
            set dirs $dirs $found_dirs
        end
    end

    # Remove any empty or invalid entries, and launch fzf
    set choice (printf "%s\n" $dirs | grep -v '^$' | fzf --style full --preview 'ls -la {}' --no-sort)

    # cd and open Neovim if selection was made
    if test -n "$choice"
        cd "$choice"
        nvim .
    end
end
