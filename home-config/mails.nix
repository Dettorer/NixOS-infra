{ pkgs, ... }:

rec {
  home.packages = with pkgs; [ thunderbird protonmail-bridge ];

  # Thunderbird
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

    # signatures
    ".signature" = home.file.".signature.paulhervot";
    ".signature.dettorer".text = ''
      Dettorer
    '';
    ".signature.paulhervot".text = ''
      Paul Hervot
    '';
    ".signature.epita".text = ''
      Paul Hervot
      Enseignant archi/HI/IP/ASM/CMP/TYLA
      Responsable MyPC (HI)
      EPITA Strasbourg
    '';
    ".signature.unistra".text = ''
      Paul Hervot
      Étudiant en M2 Sciences de l'Éducation, parcours SYNVA
    '';
    ".signature.genepistras".text = ''
      Paul Hervot
      pour le Genepi Strasbourg
    '';
    ".signature.soniak".text = ''
      Paul Hervot
      pour l'association Sonia K
    '';
  };

  # Protonmail Bridge
  # The service is tied to the graphical user session because it will try to
  # unlock the gnome-keyring default key store when starting, which needs a
  # graphical environment to prompt for the keystore's password
  systemd.user.services."protonmail-bridge" = {
    Unit = {
      Description = "Protonmail Bridge - ProtonMail IMAP and SMTP Bridge";
      PartOf = "graphical-session.target";
    };
    Service = {
      Type = "simple";
      ExecStart = "${pkgs.protonmail-bridge}/bin/protonmail-bridge --noninteractive";
      Restart = "always";
      KillMode = "process";
    };
    Install.WantedBy = [ "graphical-session.target" ];
  };
}
