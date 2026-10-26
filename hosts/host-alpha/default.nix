{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  networking.hostName = "host-alpha";

  # Override default disk device for this specific host
  disko.devices.disk.main.device = lib.mkForce "/dev/nvme0n1";

  # Enable sample programs
  mySystem.programs.firefox.enable = true;
  mySystem.programs.htop.enable = true;
  mySystem.programs.ripgrep.enable = true;

  # Additional host-specific configuration goes here
  system.stateVersion = "24.05";
}
