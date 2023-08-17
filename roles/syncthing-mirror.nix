{ config, lib, machineName, pkgs, secrets, ... }:

let
  cfg = config.my.roles.syncthing-mirror;
in {
  options.my.roles.syncthing-mirror = {
    enable = lib.mkEnableOption "Syncthing mirror";
  };

  config = lib.mkIf cfg.enable {
    services.syncthing = {
      enable = true;

      user = "dettorer";
      group = "users";
      dataDir = "/home/dettorer/.syncthing";  # TODO: not sure if this setting is used

      cert = "${pkgs.writeText "cert.pem" secrets.syncthing.devices."${machineName}".cert}";
      key = "${pkgs.writeText "key.pem" secrets.syncthing.devices."${machineName}".key}";

      overrideDevices = true;
      overrideFolders = true;

      guiAddress = "10.8.0.30:8384";  # TODO: this is the hardcoded rivamar's Magnet VPN IP
      openDefaultPorts = true;  # TODO: The gui interface is unreachable on the actual VPN, but reachable locally

      settings = {
        gui.theme = "black";

        devices = builtins.mapAttrs (name: info: {
          inherit name;
          id = info.id;
          introducer = info.introducer;
        }) secrets.syncthing.devices;

        folders = secrets.syncthing.folders;
      };
    };
  };
}
