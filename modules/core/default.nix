{ config, lib, pkgs, ... }:

{
  imports = [
    ./boot.nix
    ./disko.nix
    ./locale.nix
    ./audio.nix
    ./desktop.nix
    ./sops.nix
    ./nix-settings.nix
    ./plasma-dotfiles.nix
  ];
}
