{ pkgs, ... }:

rec {
  programs.ssh = {
    enable = true;

    matchBlocks = {
      # EPITA
      "git.cri.epita.fr" = {
        user = "paul.hervot";
        extraOptions."GSSAPIAuthentication" = "yes";
      };
      "ssh.cri.epita.fr" = {
        user = "paul.hervot";
        extraOptions = {
          "GSSAPIAuthentication" = "yes";
          "GSSAPIDelegateCredentials" = "yes";
        };
      };
      "exam.pie.cri.epita.fr" = {
        user = "paul.hervot";
        proxyJump = "ssh.cri.epita.fr";
      };
      "exam-git-pie.cri.epita.fr" = programs.ssh.matchBlocks."exam.pie.cri.epita.fr"; # TODO: deprecated?

      # Unistra
      "turing" = {
        host = "turing turing.unistra.fr";
        user = "phervot";
      };
    };

    extraConfig = ''
      AddKeysToAgent yes
      IdentityFile ~/.ssh/id_ed25519
      IdentityFile ~/.ssh/id_rsa
      IdentitiesOnly yes
    '';
  };

  home.file = {
    ".ssh/id_rsa".source = ../secrets/ssh/dettorer/id_rsa;
    ".ssh/id_ed25519".source = ../secrets/ssh/dettorer/id_ed25519;
  };
}
