{ config, pkgs, lib, ... }:
let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-26.05.tar.gz";
  symlinkRoot = "./home";
in
{
  imports = [ (import "${home-manager}/nixos") ];
  home-manager.users.lapochka = { pkgs, ... }: {
    home.packages = [ pkgs.helix pkgs.kitty ];
    home.stateVersion = "26.05";
    home.file.".config/hypr".source = ./config/hypr;
#    wayland.windowManager.hyprland.systemd.enable = false;
   # symlink = import ./home-symlink.nix {
   #   inherit config lib;
   #   symlinkRoot = "./home"; 
   # };
  };
}
