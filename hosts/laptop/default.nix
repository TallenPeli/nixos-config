{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware.nix
      ../../modules/common.nix
    ];

  networking.hostName = "framework";

  services.upower.enable = true;
  services.fwupd.enable = true;
}
