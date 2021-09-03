{ pkgs, ... }:

{
  home.packages = with pkgs; [ thunderbird protonmail-bridge ];

  # Thunderbird
  # TODO: password popups seem to missing a font or a gtk theme
  home.file = {
    ".thunderbird/profiles.ini".text = ''
      [Profile0]
      Name=default
      IsRelative=1
      Path=dettorer.default
      Default=1

      [General]
      StartWithLastProfile=1
      Version=2
    '';

    ".thunderbird/dettorer.default" = {
      source = ../secrets/thunderbird/profile;
      recursive = true;
    };
  };

  # Protonmail
  systemd.user.services."protonmail-bridge" = {
    Unit.Description = "Protonmail Bridge - ProtonMail IMAP and SMTP Bridge";
    Service = {
      Type = "simple";
      ExecStart = "${pkgs.protonmail-bridge}/bin/protonmail-bridge --noninteractive";
      Environment = "PATH=${pkgs.gnome.gnome-keyring}/bin";
      Restart = "always";
      KillMode = "process";
    };
    Install.WantedBy = [ "default.target" ];
  };
}
