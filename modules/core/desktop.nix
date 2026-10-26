{ config, lib, pkgs, ... }:

{
  services.displayManager.plasma-login-manager.enable = true;
  services.desktopManager.plasma6.enable = true;

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    elisa
    gwenview
    okular
    kate
    khelpcenter
    baloo-widgets
    print-manager
  ];

  documentation.nixos.enable = false;

  security.pam.services.plasmalogin.kwallet.enable = true;
  security.pam.services.login.kwallet.enable = true;
}
