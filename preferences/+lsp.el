;;; $DOOMDIR/preferences/+lsp.el -*- lexical-binding: t; -*-

(use-package! lsp-mode
  :config
  (setq lsp-enable-symbol-highlighting nil
        lsp-lens-enable nil
        lsp-file-watch-threshold 300))
