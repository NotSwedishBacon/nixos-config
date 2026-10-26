{ config, lib, pkgs, ... }:

{
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
    raopOpenFirewall = false;

    wireplumber.extraConfig = {
      "10-disable-raop" = {
        "wireplumber.profiles" = {
          main = {
            "monitor.libcamera" = "disabled";
            "monitor.raop" = "disabled";
          };
        };
      };
    };
  };
}
