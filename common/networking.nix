{ machineName, ... }:

{
  services.resolved.enable = true;

  networking = {
    hostName = machineName;
    networkmanager.enable = true;
    networkmanager.dns = "systemd-resolved";
  };

  # TODO: factorize the IP adress as nix expressions to avoid repeating them as
  # magic numbers
  networking.extraHosts = ''
    # Extra names for localhost
    127.0.0.1	${machineName}.dettorer.net ${machineName}
    ::1		${machineName}.dettorer.net ${machineName}

    # Magnet VPN
    10.8.0.1	doublonville.magnet	doublonville
    10.8.0.42	frimapic.magnet		frimapic
    10.8.0.30	rivamar.magnet		rivamar

    # Local home network
    192.168.1.14	frimapic.home	frimapic.home
    192.168.1.10	loceane.home	loceane.home
    192.168.1.12	rivamar.home	rivamar.home
  '';
}
