;;; $DOOMDIR/preferences/+lsp.el -*- lexical-binding: t; -*-

(use-package! lsp-mode
  :commands lsp
  :config
  (setq lsp-idle-delay 0.3
        lsp-completion-no-cache t

        ;; try to work using this option
        ;; emacs is returning "Too many open pipes" error way too often
        ;; maybe this is the culprit
        lsp-enable-file-watchers nil
        lsp-completion-use-last-result nil))
