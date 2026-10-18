{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware.nix
      ../../modules/common.nix
    ];

  networking.hostName = "desktop";

  services.upower.enable = true; 
}
