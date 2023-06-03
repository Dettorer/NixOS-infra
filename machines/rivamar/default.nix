# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

let
  my = import ../..;
in
{
  _module.args.machineName = "rivamar";

  imports = [
    ./hardware.nix
    my.modules
  ];

  hardware.acpilight.enable = true;

  networking = {
    hostName = "rivamar";
    useDHCP = false;
    interfaces.enp0s31f6.useDHCP = true;
    interfaces.wlp3s0.useDHCP = true;
  };
    
  hardware.pulseaudio.enable = true;

  # Bluetooth support
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  services.logind.lidSwitch = "ignore";

  my.roles = {
    gaming-client.enable = true;
    graphical.enable = true;
    printing.enable = true;
    syncthing-mirror.enable = true;
    magnet.enable = true;
  };

  nix.gc.options = "--delete-older-than 7d"; # default in common/nix.nix is higher

  services.xserver.videoDrivers = [ "modesetting" ];

  # Use the GRUB bootloader and auto-detect windows
  boot.loader.grub = {
      enable = true;
      device = "nodev";
      useOSProber = true;
      efiSupport = true;
  };
  boot.loader.efi.canTouchEfiVariables = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.05"; # Did you read the comment?
}
