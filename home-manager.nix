{ config, pkgs, ... }:
let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-26.05.tar.gz";
in
{
  imports = [ (import "${home-manager}/nixos") ];
  home-manager.users.lapochka = { pkgs, ... }: {
    home.packages = [ ];
    home.stateVersion = "26.05";
#    wayland.windowManager.hyprland.systemd.enable = false;
  };
}
