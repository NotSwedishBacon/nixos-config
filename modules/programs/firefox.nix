{ config, lib, pkgs, inputs, ... }:

let
  cfg = config.mySystem.programs.firefox;
in {
  options.mySystem.programs.firefox = {
    enable = lib.mkEnableOption "Firefox web browser";
  };

  imports = [
    inputs.wrappers.nixosModules.default
  ];

  config = lib.mkIf cfg.enable {
    # Instead of raw environment.systemPackages = [ pkgs.firefox ];
    # Use nix-wrapper-modules to configure flags and environment for firefox
    wrappers.firefox = {
      basePackage = pkgs.firefox;
      flags = [
        "--enable-features=UseOzonePlatform"
        "--ozone-platform=wayland"
      ];
      env = {
        MOZ_ENABLE_WAYLAND = "1";
      };
    };

    environment.systemPackages = [ config.wrappers.firefox.wrappedPackage ];
  };
}
