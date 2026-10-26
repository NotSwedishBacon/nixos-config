{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.backupFileExtension = "backup";
  home-manager.sharedModules = [
    inputs.plasma-manager.homeManagerModules.plasma-manager
  ];

  # Using a generic admin user for modularity and demonstration
  home-manager.users.admin = {
    programs.plasma = {
      enable = true;

      # Keyboard Layout inside Plasma Wayland
      input.keyboard.layouts = [ { layout = "se"; } ];

      # Workspace look-and-feel / theme settings
      workspace = {
        lookAndFeel = "org.kde.breezedark.desktop";
        theme = "breeze-dark";
        colorScheme = "BreezeDark";
      };

      # Basic KWin settings
      kwin = {
        titlebarButtons.left = [ "close" "minimize" "maximize" ];
        effects = {
          wobblyWindows.enable = true;
          blur.enable = true;
        };
      };

      # Sample panel configuration
      panels = [
        {
          location = "bottom";
          widgets = [
            "org.kde.plasma.kickoff"
            "org.kde.plasma.icontasks"
            "org.kde.plasma.marginsseparator"
            "org.kde.plasma.systemtray"
            "org.kde.plasma.digitalclock"
          ];
        }
      ];
    };
  };
}
