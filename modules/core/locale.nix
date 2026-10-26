{ config, lib, pkgs, ... }:

{
  time.timeZone = "Europe/Stockholm";

  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_TIME = "sv_SE.UTF-8";
    LC_MONETARY = "sv_SE.UTF-8";
    LC_MEASUREMENT = "sv_SE.UTF-8";
    LC_NUMERIC = "sv_SE.UTF-8";
    LC_PAPER = "sv_SE.UTF-8";
  };

  services.xserver.xkb.layout = "se";
  console.useXkbConfig = true;
}
