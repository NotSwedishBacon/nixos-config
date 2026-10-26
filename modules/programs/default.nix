{ config, lib, pkgs, ... }:

{
  imports = [
    ./firefox.nix
    ./htop.nix
    ./ripgrep.nix
  ];
}
