{ pkgs, ... }:

{
  home.packages = with pkgs; [ git-crypt ];
  programs.git = {
    enable = true;

    aliases = {
      st = "status";
      ci = "commit";
      co = "checkout";
      sw = "switch";
      b = "branch";
      all = "log --graph --pretty=oneline --all --decorate=full";
    };

    includes = [
      {
        condition = "gitdir:~/work/cours_epita/";
        contents.user = {
          name = "Paul Hervot";
          address = "paul.hervot@epita.fr";
          email = "paul.hervot@epita.fr";
        };
      }
      {
        condition = "gitdir:~/work/cours_unistra/";
        contents.user = {
          name = "Paul Hervot";
          address = "phervot@unistra.fr";
          email = "phervot@unistra.fr";
        };
      }
    ];

    userEmail = "dettorer@dettorer.net";
    userName = ''Paul "Dettorer" Hervot'';

    extraConfig = {
      color.ui = true;

      core.editor = "${pkgs.neovim}/bin/nvim";

      merge.tool = "vimdiff";
      mergetool.vimdiff.cmd = "${pkgs.neovim}/bin/nvim -d $LOCAL $REMOTE $MERGED";

      pager.status = false;
      pager.commit = false;

      push.default = "simple";
      pull.ff = "only";
    };
  };
}
