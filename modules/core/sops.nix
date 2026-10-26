{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  sops.defaultSopsFile = ../../secrets/secrets.enc.yaml;
  sops.age.keyFile = "/var/lib/sops-nix/key.txt";

  # Example of declaring a user password
  # sops.secrets."user-password".neededForUsers = true;
  # users.users.admin.hashedPasswordFile = config.sops.secrets."user-password".path;
}
