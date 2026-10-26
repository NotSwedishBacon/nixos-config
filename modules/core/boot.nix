{ config, lib, pkgs, ... }:

{
  boot.loader.systemd-boot = {
    enable = true;
    configurationLimit = 10;
  };
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.systemd.enable = true;

  security.tpm2.enable = true;
  security.tpm2.pkcs11.enable = true;
}
