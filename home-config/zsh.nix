{ pkgs, ... }:

{
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.zsh = rec {
    enable = true;

    enableVteIntegration = true;
    defaultKeymap = "emacs";

    shellAliases = {
      ocaml="rlwrap ocaml";

      ls = "ls --color -hF";
      emacs = "emacs-fix-alacritty-truecolor -nw";

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
          function emacs-fix-alacritty-truecolor
          {
            # one day I'll understand how to properly announce to any application if
            # my terminal supports truecolor, but not today.
            # if the current terminal is alacritty, announce alacritty-direct instead
            # to emacs, because that's the easiest way to convince it to use
            # truecolor. Why alacritty's terminfo isn't enough for emacs (and tmux for
            # that matter) remains a mistery to me.
            if [[ $TERM == alacritty ]]; then
              TERM=alacritty-direct emacs $*
            else
              emacs $*
            fi
          }

          function upload # This should be cleaned, but later... TODO
          {
            # Main variables
            REMOTE="dettorer@doublonville.dettorer.net"
            UPLOAD_PATH="/srv/http/dettorer.net"
            BASE_URL="https://dettorer.net"

            # Parse arguments
            if [[ $# -lt 1 ]]; then
                echo "No file given to upload"
                return -1
            elif [[ "$1" == "-p" ]]; then
                # add some parts to the upload path
                EXTRA_PATH="/$2"
                UPLOAD_PATH="$UPLOAD_PATH/$2"
                shift 2
            fi

            # Upload files
            echo "Uploading" "$@"
            ${shellAliases.rscp} "$@" "$REMOTE:$UPLOAD_PATH"
            err=$?
            if [ $err -ne 0 ]; then
                echo "Error while uploading, aborting!"
                return $err
            fi
            unset err

            # Correct file permission on the server
            echo "Fixing permissions..."
            for file in "$@"; do
                ssh -q -t "$SSH" chmod -R +r "$UPLOAD_PATH/$(basename $file)"
            done

            # Prompt links to uploaded files
            URLS=$(
                for file in "$@"; do
                    echo "$BASE_URL$EXTRA_PATH/$(basename $file)"
                done
            )
            echo $URLS
            echo $URLS | xclip -selection clipboard
          }

          function screenshot
          {
              # Help
              if [[ "$1" == "-h" ]]; then
                  cat <<-EOF
          Usage: $0 [-u] [ESCROTUM OPTIONS...]

              -u: instead of copying the image itself to the clipboard, upload
                  it and copy the url instead.
          EOF
                  return 0
              fi

              # Prepare the shot's file path
              date="$( date +%Y-%m-%d-%H%M%S )"
              rand="$( head -n256 /dev/urandom | base64 | tr -d '/+' | head -c10 )"
              SHOTNAME="screen-''${date}-''${rand}.png"
              SHOTSDIR="$HOME/images/screenshots"
              [ -d "$SHOTSDIR" ] || mkdir -p "$SHOTSDIR"
              SHOTPATH="$SHOTSDIR/$SHOTNAME"

              echo "Using escrotum and saving to $SHOTPATH"
              if [[ "$1" == "-u" ]]; then
                  shift
                  # Save and upload the image, then copy its url to the clipboard
                  escrotum "$@" "$SHOTPATH"
                  upload -p screenshots "$SHOTPATH"
              else
                  # Just save the image and copy it in the clipboard
                  escrotum -C "$@" "$SHOTPATH"
                  echo "The image was saved to the clipboard"
              fi
          }

          function meow
          {
              cat <<-"EOF"
            |\      _,,,--,,_  ,)
            /,`.-'`'   -,  ;-;;'       purr
           |,4-  ) )-,_ ) /\                  purr
          '---'''(_/--' (_/-'
          EOF
              screenshot "$@"
          }

          function quicksave
          {
            ${shellAliases.rscp} $* dettorer@dettorer.net:~/quicksave
          }
          function quickfetch
          {
            [ $# -gt 0 ] && dest=$1 || dest=.
            ${shellAliases.rscp} --remove-source-files dettorer@dettorer.net:~/quickfetch/ "$dest"
          }
          function quickfetchi
          {
            [ $# -gt 0 ] && dest=$1 || dest=.
            ${shellAliases.rscp} --remove-source-files --inplace dettorer@dettorer.net:~/quickfetch/ "$dest"
          }
          function quickfetchpeek
          {
            [ $# -gt 0 ] && dest=$1 || dest=.
            ${shellAliases.rscp} dettorer@dettorer.net:~/quickfetch/ "$dest"
          }
          function quickfetchpeeki
          {
            [ $# -gt 0 ] && dest=$1 || dest=.
            ${shellAliases.rscp} --inplace dettorer@dettorer.net:~/quickfetch/ "$dest"
          }
        '';
        keybinds = ''
          autoload edit-command-line
          zle -N edit-command-line
          bindkey "^[[3~" delete-char
          bindkey "^[e" edit-command-line
        ''; # TODO: not sure why this part is needed, I didn't have in archlinux, different defaults?
      in
      builtins.concatStringsSep "\n" [
        completion_styles
        functions
        keybinds
        (builtins.readFile ./p10k.zsh)
      ];
  };
}
