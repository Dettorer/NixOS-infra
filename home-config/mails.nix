{ pkgs, ... }:

rec {
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
      Enseignant Archi/C-UNIX/ASM
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
