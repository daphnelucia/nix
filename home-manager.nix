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
      rmpc
      yams

      kdePackages.dolphin
      kdePackages.qtsvg

      wl-clipboard
      cliphist
      wl-clip-persist
    ];

    # programs
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

    programs.obs-studio = {
      enable = true;

      # optional Nvidia hardware acceleration
      package = (
        pkgs.obs-studio.override {
          cudaSupport = true;
        }
      );

      plugins = with pkgs.obs-studio-plugins; [
        wlrobs
        obs-backgroundremoval
        obs-pipewire-audio-capture
        obs-gstreamer
        obs-vkcapture
      ];
    };

    programs.fuzzel = {
      enable = true;
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

    # services
    services.gammastep = {
      enable = true;
      provider = "geoclue2";
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

    services.mpd = {
      enable = true;
      musicDirectory = "/mnt/hdd/awa";
      extraConfig = ''
        audio_output {
          type            "pipewire"
          name            "Pipewire"
          mixer_type      "software"
        }    
      '';
      network.startWhenNeeded = true;
    };
    
    # dark mode
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

    # firewall
    services.opensnitch-ui.enable = true;

    # cursor
    home.pointerCursor =
    let
      getFrom = path: name: {
        gtk.enable = true;
        x11.enable = true;
        name = name;
        size = 64;
        package = pkgs.runCommand "moveUp" { } ''
          mkdir -p $out/share/icons
          ln -s ${path} $out/share/icons/${name}
        '';
      };
    in
      getFrom ./cursors/Imouto
        "Imouto";

    # other links
    home.file.".config/hypr/hyprland.lua".source = ./config/hypr/hyprland.lua;
    home.file.".config/waybar".source = ./config/waybar;
  } sharedConfig;
}
