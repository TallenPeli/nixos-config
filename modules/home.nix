{ pkgs, inputs, config, ... }:

{
  home.username = "tallen";
  home.homeDirectory = "/home/tallen";

  wayland.windowManager.hyprland = {
    enable = true;
    package = null;
    portalPackage = null;
    systemd.variables = [ "--all" ];
  };

  programs.git = {
    enable = true;

    settings.user = {
      name = "TallenPeli";
      email = "mail@tallenpeli.dev";
    };
  };

  programs.quickshell = {
    enable = true;
    package = inputs.quickshell.packages.${pkgs.system}.default;
  };

  home.packages = with pkgs; [
    neovim
    ghostty

    obsidian

    ripgrep
    btop

    spotify
    discord
    steam

    # Icons and fonts
    papirus-icon-theme
    nerd-fonts.jetbrains-mono

    # Compilers and runtimes
    go
    nodejs
    python3
    gcc
    gnumake
    cargo
    rustc

    # Core
    ghostty
    nautilus
    ags

    # Desktop Utilities
    hyprpaper
    wl-clipboard
    cliphist
    dunst
    udiskie
    discover-overlay

    # Navigation & Controls
    fuzzel
    hyprlock
    hyprshot
    hyprpicker
    brightnessctl
    playerctl

    # Theming
    bibata-cursors
  ];

  home.stateVersion = "25.11";

  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 16;
  };

  gtk = {
    enable = true;

    iconTheme = {
      package = pkgs.papirus-icon-theme;
      name = "Papirus";
    };

    font = {
      name = "Sans";
      size = 11;
    };
    theme = {
      name = "adw-gtk3-dark";
      package = pkgs.adw-gtk3;
    };

    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };

    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

  xdg.configFile."nvim".source = "${inputs.tallenpeli-nvim}/nvim";
  xdg.configFile."hypr".source = ../configs/hypr;

  xdg.configFile."quickshell".source = ../configs/quickshell;

  # xdg.configFile."ags".source = ../configs/ags;
  xdg.userDirs = {
    enable = true;
    createDirectories = true;

    download = "${config.home.homeDirectory}/Downloads";
    documents = "${config.home.homeDirectory}/Documents";
    pictures = "${config.home.homeDirectory}/Pictures";
    videos = "${config.home.homeDirectory}/Videos";
    music = "${config.home.homeDirectory}/Music";
    desktop = "${config.home.homeDirectory}/Desktop";

    extraConfig = {
      XDG_CODE_DIR = "${config.home.homeDirectory}/Code";
    };
  };
}
