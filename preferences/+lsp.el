;;; $DOOMDIR/preferences/+lsp.el -*- lexical-binding: t; -*-

(use-package! lsp-mode
  :commands lsp
  :config
  (setq lsp-idle-delay 0.3
        lsp-completion-no-cache t
        lsp-completion-use-last-result nil))
