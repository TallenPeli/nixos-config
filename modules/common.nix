{ inputs, pkgs, ... }:

{
  time.timeZone = "America/Toronto";
  i18n.defaultLocale = "en_US.UTF-8";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.networkmanager.enable = true;

  programs.fish.enable = true;
  programs.hyprland.enable = true;

  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    btop
    gparted
    wget
    curl
    fastfetch
    tree
    tmux

    # Zen browser
    inputs.zen-browser.packages.${pkgs.system}.default

    # QuickShell
    inputs.quickshell.packages.${pkgs.system}.default
  ];

  # Libraries
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    stdenv.cc.cc
    zlib
    fuse3
    icu
    nss
    openssl
    curl
    expat
  ];

  users.users.tallen = {
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = [ "networkmanager" ];
  };

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    auto-optimise-store = true;

    substituters = [
      "https://cache.nixos.org"
      "https://pebble.cachix.org"
    ];


    trusted-public-keys = [
      "pebble.cachix.org-1:aTqwT2hR6lGggw/rPISRcHZctDv2iF7ewsVxf3Hq6ow="
    ];
  };

  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "25.11";

  services = {
    # User services
    flatpak.enable = true;
    tailscale.enable = true;
    xserver.enable = true;

    # Power scaling services
    tlp.enable = false;
    power-profiles-daemon.enable = true;
    auto-cpufreq.enable = false;

    # Display Manager
    desktopManager.gnome.enable = false;
    displayManager.gdm.enable = true;

    gnome.gnome-keyring.enable = true;

    blueman.enable = true;
    gvfs.enable = true;
    avahi.enable = true;

    openssh = {
      enable = true;
      settings = {
        PermitRootLogin = "yes";
      };
    };

    keyd = {
      enable = true;
      keyboards = {
        default = {
          ids = [ "*" ];
          settings = {
            main = {
              capslock = "esc";
            };
          };
        };
      };
    };
  };

  security.pam.services.gdm.enableGnomeKeyring = true;

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config.common.default = "*";
  };

  environment.gnome.excludePackages = [
    pkgs.gnome-tour
  ];

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Experimental = true;
        FastConnectable = true;
      };
      Policy = {
        AutoEnable = true;
      };
    };
  };
}
