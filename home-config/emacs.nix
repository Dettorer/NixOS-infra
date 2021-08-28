{ pkgs, ... }:
{
  programs.emacs = {
    enable = true;
    extraPackages = epkgs: with epkgs; [
      bind-key
      caml
      doom-themes
      evil
      evil-nerd-commenter
      goto-chg
      tuareg
      undo-tree
      use-package
    ];
  };
  home.file.".emacs.d/init.el".text = ''
      ;; Colorscheme configuration {{{
      (use-package doom-themes
                   :config
                   ;; Global settings (defaults)
                   (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
                         doom-themes-enable-italic t) ; if nil, italics is universally disabled
                   (load-theme 'doom-one-light t)

                   ;; Enable flashing mode-line on errors
                   (doom-themes-visual-bell-config)

                   ;; Enable custom neotree theme (all-the-icons must be installed!)
                   (doom-themes-neotree-config)
                   ;; or for treemacs users
                   (setq doom-themes-treemacs-theme "doom-colors") ; use the colorful treemacs theme
                   (doom-themes-treemacs-config)

                   ;; Corrects (and improves) org-mode's native fontification.
                   (doom-themes-org-config))
      ; }}}

      ; Persistent undo
      (global-undo-tree-mode)
      (setq undo-tree-auto-save-history t)
      (setq undo-tree-history-directory-alist '(("." . "~/.emacs.d/undo")))

      ;; Tuareg mode configuration {{{
      (setq tuareg-highlight-all-operators t)
      (add-hook 'tuareg-mode-hook #'(lambda() (setq mode-name "🐫Tuareg")))
      ; }}}

      ;;;;; Evil configuration {{{
      (evil-mode 1)

      ;;;;; Evil remapping to bepo {{{
      ;;;; First unbind everything we want to redifine
      ;;; Normal state
      (define-key evil-normal-state-map "a" ' nil)
      (define-key evil-normal-state-map "A" ' nil)
      (define-key evil-normal-state-map "c" ' nil)
      (define-key evil-normal-state-map "C" ' nil)
      (define-key evil-normal-state-map "d" ' nil)
      (define-key evil-normal-state-map "D" ' nil)
      (define-key evil-normal-state-map "i" ' nil)
      (define-key evil-normal-state-map "I" ' nil)
      (define-key evil-normal-state-map "J" ' nil)
      (define-key evil-normal-state-map "m" ' nil)
      (define-key evil-normal-state-map "o" ' nil)
      (define-key evil-normal-state-map "O" ' nil)
      (define-key evil-normal-state-map "p" ' nil)
      (define-key evil-normal-state-map "P" ' nil)
      (define-key evil-normal-state-map "q" ' nil)
      (define-key evil-normal-state-map "r" ' nil)
      (define-key evil-normal-state-map "R" ' nil)
      (define-key evil-normal-state-map "s" ' nil)
      (define-key evil-normal-state-map "S" ' nil)
      (define-key evil-normal-state-map "x" ' nil)
      (define-key evil-normal-state-map "X" ' nil)
      (define-key evil-normal-state-map "y" ' nil)
      (define-key evil-normal-state-map "Y" ' nil)
      (define-key evil-normal-state-map "&" ' nil)
      (define-key evil-normal-state-map "g&" ' nil)
      (define-key evil-normal-state-map "g8" ' nil)
      (define-key evil-normal-state-map "ga" ' nil)
      (define-key evil-normal-state-map "gi" ' nil)
      (define-key evil-normal-state-map "gJ" ' nil)
      (define-key evil-normal-state-map "gq" ' nil)
      (define-key evil-normal-state-map "gw" ' nil)
      (define-key evil-normal-state-map "gu" ' nil)
      (define-key evil-normal-state-map "gU" ' nil)
      (define-key evil-normal-state-map "gf" ' nil)
      (define-key evil-normal-state-map "gF" ' nil)
      (define-key evil-normal-state-map "gx" ' nil)
      (define-key evil-normal-state-map "g?" ' nil)
      (define-key evil-normal-state-map "g~" ' nil)
      (define-key evil-normal-state-map "zo" ' nil)
      (define-key evil-normal-state-map "zO" ' nil)
      (define-key evil-normal-state-map "zc" ' nil)
      (define-key evil-normal-state-map "za" ' nil)
      (define-key evil-normal-state-map "zr" ' nil)
      (define-key evil-normal-state-map "zm" ' nil)
      (define-key evil-normal-state-map "z=" ' nil)
      (define-key evil-normal-state-map "." ' nil)
      (define-key evil-normal-state-map "@" ' nil)
      (define-key evil-normal-state-map "\"" ' nil)
      (define-key evil-normal-state-map "~" ' nil)
      (define-key evil-normal-state-map "=" ' nil)
      (define-key evil-normal-state-map "<" ' nil)
      (define-key evil-normal-state-map ">" ' nil)
      (define-key evil-normal-state-map "ZZ" ' nil)
      (define-key evil-normal-state-map "ZQ" ' nil)

      ;; go to last change
      (define-key evil-normal-state-map "g;" ' nil)
      (define-key evil-normal-state-map "g," ' nil)

      ;; undo
      (define-key evil-normal-state-map "u" ' nil)

      ;; window commands
      (define-key evil-window-map "b" ' nil)
      (define-key evil-window-map "c" ' nil)
      (define-key evil-window-map "h" ' nil)
      (define-key evil-window-map "H" ' nil)
      (define-key evil-window-map "j" ' nil)
      (define-key evil-window-map "J" ' nil)
      (define-key evil-window-map "k" ' nil)
      (define-key evil-window-map "K" ' nil)
      (define-key evil-window-map "l" ' nil)
      (define-key evil-window-map "L" ' nil)
      (define-key evil-window-map "n" ' nil)
      (define-key evil-window-map "o" ' nil)
      (define-key evil-window-map "p" ' nil)
      (define-key evil-window-map "q" ' nil)
      (define-key evil-window-map "r" ' nil)
      (define-key evil-window-map "R" ' nil)
      (define-key evil-window-map "s" ' nil)
      (define-key evil-window-map "S" ' nil)
      (define-key evil-window-map "t" ' nil)
      (define-key evil-window-map "v" ' nil)
      (define-key evil-window-map "w" ' nil)
      (define-key evil-window-map "W" ' nil)
      (define-key evil-window-map "+" ' nil)
      (define-key evil-window-map "-" ' nil)
      (define-key evil-window-map "_" ' nil)
      (define-key evil-window-map "<" ' nil)
      (define-key evil-window-map ">" ' nil)
      (define-key evil-window-map "=" ' nil)
      (define-key evil-window-map "|" ' nil)

      ;;; Motion state
      ;; "0" is a special command when called first
      (evil-redirect-digit-argument evil-motion-state-map "0" ' nil)
      (define-key evil-motion-state-map "1" ' nil)
      (define-key evil-motion-state-map "2" ' nil)
      (define-key evil-motion-state-map "3" ' nil)
      (define-key evil-motion-state-map "4" ' nil)
      (define-key evil-motion-state-map "5" ' nil)
      (define-key evil-motion-state-map "6" ' nil)
      (define-key evil-motion-state-map "7" ' nil)
      (define-key evil-motion-state-map "8" ' nil)
      (define-key evil-motion-state-map "9" ' nil)
      (define-key evil-motion-state-map "b" ' nil)
      (define-key evil-motion-state-map "B" ' nil)
      (define-key evil-motion-state-map "e" ' nil)
      (define-key evil-motion-state-map "E" ' nil)
      (define-key evil-motion-state-map "f" ' nil)
      (define-key evil-motion-state-map "F" ' nil)
      (define-key evil-motion-state-map "G" ' nil)
      (define-key evil-motion-state-map "h" ' nil)
      (define-key evil-motion-state-map "H" ' nil)
      (define-key evil-motion-state-map "j" ' nil)
      (define-key evil-motion-state-map "k" ' nil)
      (define-key evil-motion-state-map "l" ' nil)
      (define-key evil-motion-state-map " " ' nil)
      (define-key evil-motion-state-map "K" ' nil)
      (define-key evil-motion-state-map "L" ' nil)
      (define-key evil-motion-state-map "M" ' nil)
      (define-key evil-motion-state-map "n" ' nil)
      (define-key evil-motion-state-map "N" ' nil)
      (define-key evil-motion-state-map "t" ' nil)
      (define-key evil-motion-state-map "T" ' nil)
      (define-key evil-motion-state-map "w" ' nil)
      (define-key evil-motion-state-map "W" ' nil)
      (define-key evil-motion-state-map "y" ' nil)
      (define-key evil-motion-state-map "Y" ' nil)
      (define-key evil-motion-state-map "gd" ' nil)
      (define-key evil-motion-state-map "ge" ' nil)
      (define-key evil-motion-state-map "gE" ' nil)
      (define-key evil-motion-state-map "gg" ' nil)
      (define-key evil-motion-state-map "gj" ' nil)
      (define-key evil-motion-state-map "gk" ' nil)
      (define-key evil-motion-state-map "g0" ' nil)
      (define-key evil-motion-state-map "g_" ' nil)
      (define-key evil-motion-state-map "g^" ' nil)
      (define-key evil-motion-state-map "gm" ' nil)
      (define-key evil-motion-state-map "g$" ' nil)
      (define-key evil-motion-state-map "g\C-]" ' nil)
      (define-key evil-motion-state-map "{" ' nil)
      (define-key evil-motion-state-map "}" ' nil)
      (define-key evil-motion-state-map "#" ' nil)
      (define-key evil-motion-state-map "g#" ' nil)
      (define-key evil-motion-state-map "$" ' nil)
      (define-key evil-motion-state-map "%" ' nil)
      (define-key evil-motion-state-map "`" ' nil)
      (define-key evil-motion-state-map "'" ' nil)
      (define-key evil-motion-state-map "(" ' nil)
      (define-key evil-motion-state-map ")" ' nil)
      (define-key evil-motion-state-map "]]" ' nil)
      (define-key evil-motion-state-map "][" ' nil)
      (define-key evil-motion-state-map "[[" ' nil)
      (define-key evil-motion-state-map "[]" ' nil)
      (define-key evil-motion-state-map "[(" ' nil)
      (define-key evil-motion-state-map "])" ' nil)
      (define-key evil-motion-state-map "[{" ' nil)
      (define-key evil-motion-state-map "]}" ' nil)
      (define-key evil-motion-state-map "]s" ' nil)
      (define-key evil-motion-state-map "[s" ' nil)
      (define-key evil-motion-state-map "*" ' nil)
      (define-key evil-motion-state-map "g*" ' nil)
      (define-key evil-motion-state-map "," ' nil)
      (define-key evil-motion-state-map "/" ' nil)
      (define-key evil-motion-state-map ";" ' nil)
      (define-key evil-motion-state-map "?" ' nil)
      (define-key evil-motion-state-map "|" ' nil)
      (define-key evil-motion-state-map "^" ' nil)
      (define-key evil-motion-state-map "+" ' nil)
      (define-key evil-motion-state-map "_" ' nil)
      (define-key evil-motion-state-map "-" ' nil)
      (define-key evil-motion-state-map "\\" ' nil)
      (define-key evil-motion-state-map "z^" ' nil)
      (define-key evil-motion-state-map "z+" ' nil)
      (define-key evil-motion-state-map "zt" ' nil)
      ;; TODO: z RET has an advanced form taking an count before the RET
      ;; but this requires again a special state with a single command
      ;; bound to RET
      (define-key evil-motion-state-map (vconcat "z" [return]) "zt^")
      (define-key evil-motion-state-map (kbd "z RET") (vconcat "z" [return]))
      (define-key evil-motion-state-map "zz" ' nil)
      (define-key evil-motion-state-map "z." "zz^")
      (define-key evil-motion-state-map "zb" ' nil)
      (define-key evil-motion-state-map "z-" "zb^")
      (define-key evil-motion-state-map "v" ' nil)
      (define-key evil-motion-state-map "V" ' nil)
      (define-key evil-motion-state-map "gv" ' nil)
      (define-key evil-motion-state-map "zl" ' nil)
      (define-key evil-motion-state-map [?z right] "zl")
      (define-key evil-motion-state-map "zh" ' nil)
      (define-key evil-motion-state-map [?z left] "zh")
      (define-key evil-motion-state-map "zL" ' nil)
      (define-key evil-motion-state-map "zH" ' nil)

      ;; text objects
      (define-key evil-outer-text-objects-map "w" ' nil)
      (define-key evil-outer-text-objects-map "W" ' nil)
      (define-key evil-outer-text-objects-map "s" ' nil)
      (define-key evil-outer-text-objects-map "p" ' nil)
      (define-key evil-outer-text-objects-map "b" ' nil)
      (define-key evil-outer-text-objects-map "(" ' nil)
      (define-key evil-outer-text-objects-map ")" ' nil)
      (define-key evil-outer-text-objects-map "[" ' nil)
      (define-key evil-outer-text-objects-map "]" ' nil)
      (define-key evil-outer-text-objects-map "B" ' nil)
      (define-key evil-outer-text-objects-map "{" ' nil)
      (define-key evil-outer-text-objects-map "}" ' nil)
      (define-key evil-outer-text-objects-map "<" ' nil)
      (define-key evil-outer-text-objects-map ">" ' nil)
      (define-key evil-outer-text-objects-map "'" ' nil)
      (define-key evil-outer-text-objects-map "\"" ' nil)
      (define-key evil-outer-text-objects-map "`" ' nil)
      (define-key evil-outer-text-objects-map "t" ' nil)
      (define-key evil-outer-text-objects-map "o" ' nil)
      (define-key evil-inner-text-objects-map "w" ' nil)
      (define-key evil-inner-text-objects-map "W" ' nil)
      (define-key evil-inner-text-objects-map "s" ' nil)
      (define-key evil-inner-text-objects-map "p" ' nil)
      (define-key evil-inner-text-objects-map "b" ' nil)
      (define-key evil-inner-text-objects-map "(" ' nil)
      (define-key evil-inner-text-objects-map ")" ' nil)
      (define-key evil-inner-text-objects-map "[" ' nil)
      (define-key evil-inner-text-objects-map "]" ' nil)
      (define-key evil-inner-text-objects-map "B" ' nil)
      (define-key evil-inner-text-objects-map "{" ' nil)
      (define-key evil-inner-text-objects-map "}" ' nil)
      (define-key evil-inner-text-objects-map "<" ' nil)
      (define-key evil-inner-text-objects-map ">" ' nil)
      (define-key evil-inner-text-objects-map "'" ' nil)
      (define-key evil-inner-text-objects-map "\"" ' nil)
      (define-key evil-inner-text-objects-map "`" ' nil)
      (define-key evil-inner-text-objects-map "t" ' nil)
      (define-key evil-inner-text-objects-map "o" ' nil)
      (define-key evil-motion-state-map "gn" ' nil)
      (define-key evil-motion-state-map "gN" ' nil)

      ;;; Visual state
      (define-key evil-visual-state-map "A" ' nil)
      (define-key evil-visual-state-map "I" ' nil)
      (define-key evil-visual-state-map "o" ' nil)
      (define-key evil-visual-state-map "O" ' nil)
      (define-key evil-visual-state-map "R" ' nil)
      (define-key evil-visual-state-map "u" ' nil)
      (define-key evil-visual-state-map "U" ' nil)
      (define-key evil-visual-state-map "z=" ' nil)
      (define-key evil-visual-state-map "a" nil)
      (define-key evil-visual-state-map "i" nil)

      ;;; Operator-Pending state
      (define-key evil-operator-state-map "a" nil)
      (define-key evil-operator-state-map "i" nil)

      ;;;;; Evil remapping to bepo
      ;;;; First unbind everything we want to redifine
      ;;; Normal state
      (define-key evil-normal-state-map "a" 'evil-append)
      (define-key evil-normal-state-map "A" 'evil-append-line)
      (define-key evil-normal-state-map "x" 'evil-change)
      (define-key evil-normal-state-map "X" 'evil-change-line)
      (define-key evil-normal-state-map "i" 'evil-delete)
      (define-key evil-normal-state-map "I" 'evil-delete-line)
      (define-key evil-normal-state-map "d" 'evil-insert)
      (define-key evil-normal-state-map "D" 'evil-insert-line)
      (define-key evil-normal-state-map "T" 'evil-join)
      (define-key evil-normal-state-map "q" 'evil-set-marker)
      (define-key evil-normal-state-map "l" 'evil-open-below)
      (define-key evil-normal-state-map "L" 'evil-open-above)
      (define-key evil-normal-state-map "j" 'evil-paste-after)
      (define-key evil-normal-state-map "J" 'evil-paste-before)
      (define-key evil-normal-state-map "b" 'evil-record-macro)
      (define-key evil-normal-state-map "o" 'evil-replace)
      (define-key evil-normal-state-map "O" 'evil-replace-state)
      (define-key evil-normal-state-map "u" 'evil-substitute)
      (define-key evil-normal-state-map "U" 'evil-change-whole-line)
      (define-key evil-normal-state-map "y" 'evil-delete-char)
      (define-key evil-normal-state-map "Y" 'evil-delete-backward-char)
      (define-key evil-normal-state-map "^" 'evil-yank)
      (define-key evil-normal-state-map "!" 'evil-yank-line)
      (define-key evil-normal-state-map "7" 'evil-ex-repeat-substitute)
      (define-key evil-normal-state-map ",7" 'evil-ex-repeat-global-substitute)
      (define-key evil-normal-state-map ",-" 'what-cursor-position)
      (define-key evil-normal-state-map ",a" 'what-cursor-position)
      (define-key evil-normal-state-map ",d" 'evil-insert-resume)
      (define-key evil-normal-state-map ",T" 'evil-join-whitespace)
      (define-key evil-normal-state-map ",b" 'evil-fill-and-move)
      (define-key evil-normal-state-map ",é" 'evil-fill)
      (define-key evil-normal-state-map ",v" 'evil-downcase)
      (define-key evil-normal-state-map ",V" 'evil-upcase)
      (define-key evil-normal-state-map ",e" 'find-file-at-point)
      (define-key evil-normal-state-map ",E" 'evil-find-file-at-point-with-line)
      (define-key evil-normal-state-map ",y" 'browse-url-at-point)
      (define-key evil-normal-state-map ",F" 'evil-rot13)
      (define-key evil-normal-state-map ",#" 'evil-invert-case)
      (define-key evil-normal-state-map "àl" 'evil-open-fold)
      (define-key evil-normal-state-map "àL" 'evil-open-fold-rec)
      (define-key evil-normal-state-map "àx" 'evil-close-fold)
      (define-key evil-normal-state-map "àa" 'evil-toggle-fold)
      (define-key evil-normal-state-map "ào" 'evil-open-folds)
      (define-key evil-normal-state-map "àq" 'evil-close-folds)
      (define-key evil-normal-state-map "à%" 'ispell-word)
      (define-key evil-normal-state-map "h" 'evil-repeat)
      (define-key evil-normal-state-map "2" 'evil-execute-macro)
      (define-key evil-normal-state-map "M" 'evil-use-register)
      (define-key evil-normal-state-map "#" 'evil-invert-char)
      (define-key evil-normal-state-map "%" 'evil-indent)
      (define-key evil-normal-state-map "<" 'evil-shift-left)
      (define-key evil-normal-state-map ">" 'evil-shift-right)
      (define-key evil-normal-state-map "ÀÀ" 'evil-save-modified-and-close)
      (define-key evil-normal-state-map "ÀB" 'evil-quit)

      ;; go to last change
      (define-key evil-normal-state-map ",n" 'goto-last-change)
      (define-key evil-normal-state-map ",g" 'goto-last-change-reverse)

      ;; undo
      (define-key evil-normal-state-map "v" 'undo)

      ;; window commands
      (define-key evil-window-map "k" 'evil-window-bottom-right)
      (define-key evil-window-map "x" 'evil-window-delete)
      (define-key evil-window-map "c" 'evil-window-left)
      (define-key evil-window-map "C" 'evil-window-move-far-left)
      (define-key evil-window-map "t" 'evil-window-down)
      (define-key evil-window-map "T" 'evil-window-move-very-bottom)
      (define-key evil-window-map "s" 'evil-window-up)
      (define-key evil-window-map "S" 'evil-window-move-very-top)
      (define-key evil-window-map "r" 'evil-window-right)
      (define-key evil-window-map "R" 'evil-window-move-far-right)
      (define-key evil-window-map "'" 'evil-window-new)
      (define-key evil-window-map "l" 'delete-other-windows)
      (define-key evil-window-map "j" 'evil-window-mru)
      (define-key evil-window-map "b" 'evil-quit)
      (define-key evil-window-map "o" 'evil-window-rotate-downwards)
      (define-key evil-window-map "O" 'evil-window-rotate-upwards)
      (define-key evil-window-map "u" 'evil-window-split)
      (define-key evil-window-map "U" 'evil-window-split)
      (define-key evil-window-map "è" 'evil-window-top-left)
      (define-key evil-window-map "." 'evil-window-vsplit)
      (define-key evil-window-map "é" 'evil-window-next)
      (define-key evil-window-map "É" 'evil-window-prev)
      (define-key evil-window-map "`" 'evil-window-increase-height)
      (define-key evil-window-map "=" 'evil-window-decrease-height)
      (define-key evil-window-map "°" 'evil-window-set-height)
      (define-key evil-window-map "<" 'evil-window-decrease-width)
      (define-key evil-window-map ">" 'evil-window-increase-width)
      (define-key evil-window-map "%" 'balance-windows)
      (define-key evil-window-map "Ç" 'evil-window-set-width)

      ;;; Motion state
      ;; "0" is a special command when called first
      (evil-redirect-digit-argument evil-motion-state-map "*" 'evil-beginning-of-line)
      (define-key evil-motion-state-map "\"" 'digit-argument)
      (define-key evil-motion-state-map "«" 'digit-argument)
      (define-key evil-motion-state-map "»" 'digit-argument)
      (define-key evil-motion-state-map "(" 'digit-argument)
      (define-key evil-motion-state-map ")" 'digit-argument)
      (define-key evil-motion-state-map "@" 'digit-argument)
      (define-key evil-motion-state-map "+" 'digit-argument)
      (define-key evil-motion-state-map "-" 'digit-argument)
      (define-key evil-motion-state-map "/" 'digit-argument)
      (define-key evil-motion-state-map "k" 'evil-backward-word-begin)
      (define-key evil-motion-state-map "K" 'evil-backward-WORD-begin)
      (define-key evil-motion-state-map "p" 'evil-forward-word-end)
      (define-key evil-motion-state-map "P" 'evil-forward-WORD-end)
      (define-key evil-motion-state-map "e" 'evil-find-char)
      (define-key evil-motion-state-map "E" 'evil-find-char-backward)
      (define-key evil-motion-state-map ";" 'evil-goto-line)
      (define-key evil-motion-state-map "c" 'evil-backward-char)
      (define-key evil-motion-state-map "C" 'evil-window-top)
      (define-key evil-motion-state-map "t" 'evil-next-line)
      (define-key evil-motion-state-map "s" 'evil-previous-line)
      (define-key evil-motion-state-map "r" 'evil-forward-char)
      (define-key evil-motion-state-map " " 'evil-forward-char)
      (define-key evil-motion-state-map "S" 'evil-lookup)
      (define-key evil-motion-state-map "R" 'evil-window-bottom)
      (define-key evil-motion-state-map "Q" 'evil-window-middle)
      (define-key evil-motion-state-map "'" 'evil-search-next)
      (define-key evil-motion-state-map "?" 'evil-search-previous)
      (define-key evil-motion-state-map "è" 'evil-find-char-to)
      (define-key evil-motion-state-map "È" 'evil-find-char-to-backward)
      (define-key evil-motion-state-map "é" 'evil-forward-word-begin)
      (define-key evil-motion-state-map "É" 'evil-forward-WORD-begin)
      (define-key evil-motion-state-map "^" 'evil-yank)
      (define-key evil-motion-state-map "!" 'evil-yank-line)
      (define-key evil-motion-state-map ",i" 'evil-goto-definition)
      (define-key evil-motion-state-map ",p" 'evil-backward-word-end)
      (define-key evil-motion-state-map ",P" 'evil-backward-WORD-end)
      (define-key evil-motion-state-map ",," 'evil-goto-first-line)
      (define-key evil-motion-state-map ",t" 'evil-next-visual-line)
      (define-key evil-motion-state-map ",s" 'evil-previous-visual-line)
      (define-key evil-motion-state-map ",*" 'evil-beginning-of-visual-line)
      (define-key evil-motion-state-map ",°" 'evil-last-non-blank)
      (define-key evil-motion-state-map ",6" 'evil-first-non-blank-of-visual-line)
      (define-key evil-motion-state-map ",q" 'evil-middle-of-visual-line)
      (define-key evil-motion-state-map ",4" 'evil-end-of-visual-line)
      (define-key evil-motion-state-map ",\C-]" 'evil-jump-to-tag)
      (define-key evil-motion-state-map "{" 'evil-backward-paragraph)
      (define-key evil-motion-state-map "}" 'evil-forward-paragraph)
      (define-key evil-motion-state-map "3" 'evil-search-word-backward)
      (define-key evil-motion-state-map ",3" 'evil-search-unbounded-word-backward)
      (define-key evil-motion-state-map "4" 'evil-end-of-line)
      (define-key evil-motion-state-map "5" 'evil-jump-item)
      (define-key evil-motion-state-map "$" 'evil-goto-mark)
      (define-key evil-motion-state-map "m" 'evil-goto-mark-line)
      (define-key evil-motion-state-map "9" 'evil-backward-sentence-begin)
      (define-key evil-motion-state-map "0" 'evil-forward-sentence-begin)
      (define-key evil-motion-state-map "]]" 'evil-forward-section-begin)
      (define-key evil-motion-state-map "][" 'evil-forward-section-end)
      (define-key evil-motion-state-map "[[" 'evil-backward-section-begin)
      (define-key evil-motion-state-map "[]" 'evil-backward-section-end)
      (define-key evil-motion-state-map "[9" 'evil-previous-open-paren)
      (define-key evil-motion-state-map "]0" 'evil-next-close-paren)
      (define-key evil-motion-state-map "[{" 'evil-previous-open-brace)
      (define-key evil-motion-state-map "]}" 'evil-next-close-brace)
      (define-key evil-motion-state-map "]u" 'evil-next-flyspell-error)
      (define-key evil-motion-state-map "[u" 'evil-prev-flyspell-error)
      (define-key evil-motion-state-map "8" 'evil-search-word-forward)
      (define-key evil-motion-state-map ",8" 'evil-search-unbounded-word-forward)
      (define-key evil-motion-state-map "g" 'evil-repeat-find-char-reverse)
      (define-key evil-motion-state-map "f" 'evil-search-forward)
      (define-key evil-motion-state-map "n" 'evil-repeat-find-char)
      (define-key evil-motion-state-map "F" 'evil-search-backward)
      (define-key evil-motion-state-map "Ç" 'evil-goto-column)
      (define-key evil-motion-state-map "6" 'evil-first-non-blank)
      (define-key evil-motion-state-map "`" 'evil-next-line-first-non-blank)
      (define-key evil-motion-state-map "°" 'evil-next-line-1-first-non-blank)
      (define-key evil-motion-state-map "=" 'evil-previous-line-first-non-blank)
      (define-key evil-motion-state-map "ç" 'evil-execute-in-emacs-state)
      (define-key evil-motion-state-map "à6" 'evil-scroll-top-line-to-bottom)
      (define-key evil-motion-state-map "à`" 'evil-scroll-bottom-line-to-top)
      (define-key evil-motion-state-map "àè" 'evil-scroll-line-to-top)
      ;; TODO: z RET has an advanced form taking an count before the RET
      ;; but this requires again a special state with a single command
      ;; bound to RET
      (define-key evil-motion-state-map (vconcat "à" [return]) "àè6")
      (define-key evil-motion-state-map (kbd "à RET") (vconcat "à" [return]))
      (define-key evil-motion-state-map "àà" 'evil-scroll-line-to-center)
      (define-key evil-motion-state-map "à." "àà6")
      (define-key evil-motion-state-map "àk" 'evil-scroll-line-to-bottom)
      (define-key evil-motion-state-map "à=" "àk6")
      (define-key evil-motion-state-map "." 'evil-visual-char)
      (define-key evil-motion-state-map ":" 'evil-visual-line)
      (define-key evil-motion-state-map ",." 'evil-visual-restore)
      (define-key evil-motion-state-map "àr" 'evil-scroll-column-right)
      (define-key evil-motion-state-map [?à right] "àr")
      (define-key evil-motion-state-map "àc" 'evil-scroll-column-left)
      (define-key evil-motion-state-map [?à left] "àc")
      (define-key evil-motion-state-map "àR" 'evil-scroll-right)
      (define-key evil-motion-state-map "àC" 'evil-scroll-left)

      ;; text objects
      (define-key evil-outer-text-objects-map "é" 'evil-a-word)
      (define-key evil-outer-text-objects-map "É" 'evil-a-WORD)
      (define-key evil-outer-text-objects-map "u" 'evil-a-sentence)
      (define-key evil-outer-text-objects-map "j" 'evil-a-paragraph)
      (define-key evil-outer-text-objects-map "k" 'evil-a-paren)
      (define-key evil-outer-text-objects-map "9" 'evil-a-paren)
      (define-key evil-outer-text-objects-map "0" 'evil-a-paren)
      (define-key evil-outer-text-objects-map "[" 'evil-a-bracket)
      (define-key evil-outer-text-objects-map "]" 'evil-a-bracket)
      (define-key evil-outer-text-objects-map "K" 'evil-a-curly)
      (define-key evil-outer-text-objects-map "{" 'evil-a-curly)
      (define-key evil-outer-text-objects-map "}" 'evil-a-curly)
      (define-key evil-outer-text-objects-map "<" 'evil-an-angle)
      (define-key evil-outer-text-objects-map ">" 'evil-an-angle)
      (define-key evil-outer-text-objects-map "m" 'evil-a-single-quote)
      (define-key evil-outer-text-objects-map "M" 'evil-a-double-quote)
      (define-key evil-outer-text-objects-map "$" 'evil-a-back-quote)
      (define-key evil-outer-text-objects-map "è" 'evil-a-tag)
      (define-key evil-outer-text-objects-map "l" 'evil-a-symbol)
      (define-key evil-inner-text-objects-map "é" 'evil-inner-word)
      (define-key evil-inner-text-objects-map "É" 'evil-inner-WORD)
      (define-key evil-inner-text-objects-map "u" 'evil-inner-sentence)
      (define-key evil-inner-text-objects-map "j" 'evil-inner-paragraph)
      (define-key evil-inner-text-objects-map "k" 'evil-inner-paren)
      (define-key evil-inner-text-objects-map "9" 'evil-inner-paren)
      (define-key evil-inner-text-objects-map "0" 'evil-inner-paren)
      (define-key evil-inner-text-objects-map "[" 'evil-inner-bracket)
      (define-key evil-inner-text-objects-map "]" 'evil-inner-bracket)
      (define-key evil-inner-text-objects-map "K" 'evil-inner-curly)
      (define-key evil-inner-text-objects-map "{" 'evil-inner-curly)
      (define-key evil-inner-text-objects-map "}" 'evil-inner-curly)
      (define-key evil-inner-text-objects-map "<" 'evil-inner-angle)
      (define-key evil-inner-text-objects-map ">" 'evil-inner-angle)
      (define-key evil-inner-text-objects-map "m" 'evil-inner-single-quote)
      (define-key evil-inner-text-objects-map "M" 'evil-inner-double-quote)
      (define-key evil-inner-text-objects-map "$" 'evil-inner-back-quote)
      (define-key evil-inner-text-objects-map "è" 'evil-inner-tag)
      (define-key evil-inner-text-objects-map "l" 'evil-inner-symbol)
      (define-key evil-motion-state-map ",'" 'evil-next-match)
      (define-key evil-motion-state-map ",?" 'evil-previous-match)

      ;;; Visual state
      (define-key evil-visual-state-map "A" 'evil-append)
      (define-key evil-visual-state-map "D" 'evil-insert)
      (define-key evil-visual-state-map "l" 'exchange-point-and-mark)
      (define-key evil-visual-state-map "L" 'evil-visual-exchange-corners)
      (define-key evil-visual-state-map "O" 'evil-change)
      (define-key evil-visual-state-map "v" 'evil-downcase)
      (define-key evil-visual-state-map "V" 'evil-upcase)
      (define-key evil-visual-state-map "à%" 'ispell-word)
      (define-key evil-visual-state-map "a" evil-outer-text-objects-map)
      (define-key evil-visual-state-map "d" evil-inner-text-objects-map)

      ;;; Operator-Pending state
      (define-key evil-operator-state-map "a" evil-outer-text-objects-map)
      (define-key evil-operator-state-map "d" evil-inner-text-objects-map)

      ;;; Ex mode
      (define-key evil-normal-state-map "n" 'evil-ex)
      (define-key evil-normal-state-map "N" 'evil-ex)

      ;;; Quick window switch
      (define-key evil-normal-state-map " " 'evil-window-map)
      (define-key evil-window-map " " 'evil-window-next)

      ;;; Quick write (trick is, starting with SPC sends us to window mappings)
      (define-key evil-window-map (kbd "RET") 'evil-write)
      (define-key evil-window-map (kbd "DEL") 'evil-save-modified-and-close)
      ;;; }}}
      ;;; }}}

      (custom-set-variables
      ;; custom-set-variables was added by Custom.
      ;; If you edit it by hand, you could mess it up, so be careful.
      ;; Your init file should contain only one such instance.
      ;; If there is more than one, they won't work right.
      '(custom-safe-themes
      '("99ea831ca79a916f1bd789de366b639d09811501e8c092c85b2cb7d697777f93" "2f1518e906a8b60fac943d02ad415f1d8b3933a5a7f75e307e6e9a26ef5bf570" default))
      '(package-selected-packages
      '(rust-mode tuareg doom-themes evil evil-nerd-commenter goto-chg caml undo-tree use-package bind-key)))
      (custom-set-faces
      ;; custom-set-faces was added by Custom.
      ;; If you edit it by hand, you could mess it up, so be careful.
      ;; Your init file should contain only one such instance.
      ;; If there is more than one, they won't work right.
      )
  '';
}