{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;

    enableVteIntegration = true;
    defaultKeymap = "emacs";

    shellAliases = {
      ocaml="rlwrap ocaml";

      ls = "ls --color -hF";

      # one day I'll understand how to properly announce to any application if
      # my terminal supports truecolor, but not today.
      # if the current terminal is alacritty, announce alacritty-direct instead
      # to emacs, because that's the easiest way to convince it to use
      # truecolor. Why alacritty's terminfo isn't enough for emacs (and tmux for
      # that matter) remains a mistery to me.
      emacs = "if [[ $TERM == alacritty ]]; then TERM=alacritty-direct emacs -nw; else emacs -nw; fi";

      memfree = "killall firefox";

      up = "source ~/.zshrc";

      doublonville = "mosh doublonville.dettorer.net --";
      doublonvilles = "ssh -t doublonville.dettorer.net";
      pentapoulpe = "mosh -p 222 --ssh=\"ssh -p 222\" root@pentapoulpe.dettorer.net -- su dettorer";
      pentapoulpes = "ssh -p 222 -t pentapoulpe.dettorer.net";
      toundra = "mosh toundra.dettorer.net --";
      toundras = "ssh -t toundra.dettorer.net";

      rosa = "mosh rosa.prologin.org --";
      rosas = "ssh -t rosa.prologin.org";

      irc = "doublonville tmux -u attach -t irc";
      work = "doublonville tmux -u attach -t work";
      stuff = "doublonville tmux -u attach -t stuff";

      dusort = "du -hs * . | sort -h";
      dusort_dot = "du -hs * .* . | sort -h";

      powder = "powder && rm powder.pref";

      rscp = "rsync --partial --progress --archive";

      mv = "mv -i";
      cp = "cp -i";
      
      vis = "vim -S Session.vim";
    };

    history = {
      size = 200000;
      save = 200000;
      ignoreSpace = true;
      extended = true;
      share = true;
    };

    plugins = [
      {
        name = "powerlevel10k";
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
        src = pkgs.zsh-powerlevel10k;
      }
    ];

    initExtra =
      let
        completion_styles = ''
          zstyle ':completion:*' completer _complete _ignored _correct _approximate
          zstyle ':completion:*' group-name ''\'''\'
          zstyle ':completion:*' insert-unambiguous true
          zstyle ':completion:*' list-colors ''\'''\'
          zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
          zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}'
          zstyle ':completion:*' menu select=1
          zstyle ':completion:*' original true
          zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
          zstyle ':completion:*' use-compctl false
          zstyle ':completion:*' verbose true
        '';
        functions = ''
          function upload # This should be cleaned, but later... TODO
          {
            # Main variables
            SSH_USER="dettorer"
            SSH_HOST="dettorer.net"
            SSH="$SSH_USER@$SSH_HOST"
            HTTP_SERVER_PATH="/srv/http/dettorer.net"
            BASE_URL="https://dettorer.net"

            # Parse arguments
            if [ $# -lt 2 ]; then
                echo "At least two arguments are needed"
                return -1
            fi
            FILES=$*[0,-2]
            ADD_PATH=$*[-1]

            # Upload files
            echo "Uploading $FILES..."
            rscp $FILES $SSH:$HTTP_SERVER_PATH/$ADD_PATH
            err=$?
            if [ $err -ne 0 ]; then
                echo "Error while uploading, aborting!"
                return $err
            fi
            unset err

            # Correct file permission on the server
            echo "Fixing permissions..."
            for file in $FILES; do
                ssh -q -t $SSH chmod -R +r "$HTTP_SERVER_PATH/$ADD_PATH/`basename $file`"
            done

            # Prompt links to uploaded files
            for file in $FILES; do
                echo $BASE_URL/$ADD_PATH/`basename $file`
            done
          }

          function quicksave
          {
            rscp $* dettorer@dettorer.net:~/quicksave
          }
          function quickfetch
          {
            [ $# -gt 0 ] && dest=$1 || dest=.
            rscp --remove-source-files dettorer@dettorer.net:~/quickfetch/ "$dest"
          }
          function quickfetchi
          {
            [ $# -gt 0 ] && dest=$1 || dest=.
            rscp --remove-source-files --inplace dettorer@dettorer.net:~/quickfetch/ "$dest"
          }
          function quickfetchpeek
          {
            [ $# -gt 0 ] && dest=$1 || dest=.
            rscp dettorer@dettorer.net:~/quickfetch/ "$dest"
          }
          function quickfetchpeeki
          {
            [ $# -gt 0 ] && dest=$1 || dest=.
            rscp --inplace dettorer@dettorer.net:~/quickfetch/ "$dest"
          }
        '';
      in
      builtins.concatStringsSep "\n" [
        completion_styles
        functions
        (builtins.readFile ./p10k.zsh)
      ];
  };
}
