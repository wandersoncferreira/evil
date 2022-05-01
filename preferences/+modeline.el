;;; $DOOMDIR/preferences/+modeline.el -*- lexical-binding: t; -*-

(after! doom-modeline
  ;; define new modeline
  (doom-modeline-def-modeline 'bartuka
    '(modals buffer-position buffer-info checker)
    '(debug repl lsp persp-name major-mode))

  ;; enable segments
  (setq doom-modeline-persp-name t
        doom-modeline-persp-icon nil
        doom-modeline-icon nil)

  (defun setup-custom-doom-modeline ()
    (doom-modeline-set-modeline 'bartuka 'default))

  (add-hook 'doom-modeline-mode-hook 'setup-custom-doom-modeline))
