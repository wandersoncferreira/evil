;;; $DOOMDIR/preferences/+lsp.el -*- lexical-binding: t; -*-

(use-package! lsp-mode
  :commands lsp
  :config
  (setq lsp-idle-delay 0.3
        ;; use cider for indentation
        lsp-enable-indentation nil
        ;; use cider for completion
        lsp-completion-enable nil
        ;; disable lens
        lsp-lens-enable nil
        ;; try to work using this option
        ;; emacs is returning "Too many open pipes" error way too often
        ;; maybe this is the culprit
        lsp-enable-file-watchers nil))
