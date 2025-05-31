function pnvim
    # Define root directories with max depth
    set roots_with_depths \
	"~/Documents/Programming/languages:2" \
	"~/Documents/Programming/projects:1" \
	"~/.dotfiles:1"

    # Collect directories
    set dirs
    for entry in $roots_with_depths
        set root (string split ':' $entry)[1]
        set depth (string split ':' $entry)[2]
        set expanded_root (eval echo $root)  # Expand ~ to full path
        if test -d $expanded_root
            set dirs $dirs (find $expanded_root -mindepth $depth -maxdepth $depth -type d 2>/dev/null)
        end
    end

    # Remove any empty or invalid entries, and launch fzf
    set choice (printf "%s\n" $dirs | grep -v '^$' | fzf  --style full --preview 'ls -la {}' --no-sort)

    # cd and open Neovim if selection was made
    if test -n "$choice"
        cd "$choice"
        nvim .
    end
end
