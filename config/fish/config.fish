if status is-interactive
    # Commands to run in interactive sessions can go here
end
if command -q nix-your-shell
    nix-your-shell fish | source
end
set -g fish_greeting

alias clean-nixos 'sudo nix-collect-garbage && sudo nix-env -p /nix/var/nix/profiles/system --delete-generations +2'
