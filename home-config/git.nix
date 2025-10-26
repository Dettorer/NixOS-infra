{ pkgs, ... }:

{
  home.packages = with pkgs; [ git-crypt ];
  programs.git = {
    enable = true;

    settings = {
      alias = {
        st = "status";
        ci = "commit";
        co = "checkout";
        sw = "switch";
        b = "branch";
        all = "log --graph --pretty=oneline --all --decorate=full";
      };

      user = {
        email = "dettorer@dettorer.net";
        name = ''Paul "Dettorer" Hervot'';
      };

      color.ui = true;

      core.editor = "nvim";

      merge.tool = "nvim";
      mergetool.nvim.cmd = "nvim -d $LOCAL $REMOTE $MERGED";

      pager.status = false;
      pager.commit = false;

      push.default = "simple";
      pull.ff = "only";

      init.defaultBranch = "main";
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
  };
}
