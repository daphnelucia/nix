{ config, pkgs, lib, ... }:
let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-26.05.tar.gz";
  sharedConfig = {
    programs.git = {
      enable = true;
      settings = {
        user = {
          name = "Daphne Lucia";
          email = "38116582+daphnelucia@users.noreply.github.com";
        };
        init.defaultBranch = "main";
      };
    };
    programs.gh = {
      enable = true;
      gitCredentialHelper = {
        enable = true;
      };
    };
    
    programs.nix-your-shell = {
      enable = true;
      enableFishIntegration = true;
    };

    home.file.".config/fish".source = ./config/fish;
    
    home.stateVersion = "26.05";
  }; 
in
{
  imports = [
    (import "${home-manager}/nixos")
  ];

  home-manager.users.root = { ... }: sharedConfig;

  home-manager.users.lapochka = { pkgs, ... }: lib.recursiveUpdate {
    home.packages = with pkgs; [
      qpwgraph
      pwvucontrol
      keepassxc
      mumble
      hyprpaper
    ];
    
    programs.librewolf = {
      enable = true;
      # Enable WebGL, cookies and history
      settings = {
        "webgl.disabled" = false;
        "privacy.resistFingerprinting" = false;
        "privacy.clearOnShutdown.history" = false;
        "privacy.clearOnShutdown.cookies" = false;
        "network.cookie.lifetimePolicy" = 0;
      };
    };

    programs.fuzzel = {
      enable = true;
    };

    services.hyprpaper = {
      enable = true;
      settings = {
        splash = false;
        preload = [
          "/etc/nixos/wallpapers/flower2.jxl"
        ];
        wallpaper = [
          {
            monitor = "";
            path = "/etc/nixos/wallpapers/flower2.jxl";      
          }
        ];
      };
    };

    programs.alacritty = {
      enable = true;
      settings = {
        font = {
          size = 13;
        };
      };
    };
    
    programs.vesktop = {
      enable = true;
      settings = {
        arRPC = true;
        checkUpdates = false;
        disableMinSize = true;
        minimizeToTray = false;
        tray = false;
        staticTitle = true;
        hardwareAcceleration = true;
        discordBranch = "stable";
      };
      vencord = {
        settings = {
          autoUpdate = false;
          autoUpdateNotification = false;
          disableMinSize = true;
          notifyAboutUpdates = false;
          plugins = {};
        };
      };
    };

    # dark modei
    dconf.enable = true;
    dconf.settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
    dconf.settings."org/gnome/desktop/interface".gtk-theme = "Adwaita-dark";
    qt = {
      enable = true;
      platformTheme.name = "kde";
      style.name = "breeze";
    };
    home.file.".config/kdeglobals" = {
      text = ''
        ${builtins.readFile "${pkgs.kdePackages.breeze}/share/color-schemes/BreezeDark.colors"}
      '';
    };

    # other links
    home.file.".config/hypr/hyprland.lua".source = ./config/hypr/hyprland.lua;
    home.file.".config/waybar".source = ./config/waybar;
  } sharedConfig;
}
