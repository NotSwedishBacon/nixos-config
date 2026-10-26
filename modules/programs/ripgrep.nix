{ config, lib, pkgs, inputs, ... }:

let
  cfg = config.mySystem.programs.ripgrep;
in {
  options.mySystem.programs.ripgrep = {
    enable = lib.mkEnableOption "ripgrep search tool";
  };

  imports = [
    inputs.wrappers.nixosModules.default
  ];

  config = lib.mkIf cfg.enable {
    wrappers.rg = {
      basePackage = pkgs.ripgrep;
      flags = [
        "--smart-case"
        "--hidden"
      ];
    };

    environment.systemPackages = [ config.wrappers.rg.wrappedPackage ];
  };
}
