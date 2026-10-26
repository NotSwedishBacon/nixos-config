{ config, lib, pkgs, inputs, ... }:

let
  cfg = config.mySystem.programs.htop;
in {
  options.mySystem.programs.htop = {
    enable = lib.mkEnableOption "htop system monitor";
  };

  imports = [
    inputs.wrappers.nixosModules.default
  ];

  config = lib.mkIf cfg.enable {
    wrappers.htop = {
      basePackage = pkgs.htop;
      # Add default flags if desired
      flags = [
        "--delay=10"
      ];
    };

    environment.systemPackages = [ config.wrappers.htop.wrappedPackage ];
  };
}
