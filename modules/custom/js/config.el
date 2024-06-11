;;; custom/js/config.el -*- lexical-binding: t; -*-

(defadvice! bk:javascript-init-lsp ()
  "Start LSP for the current buffer."
  :override #'+javascript-init-lsp-or-tide-maybe-h
  (lsp!))

(after! typescript-mode
  (setq typescript-indent-level 2)

  (setq-local company-idle-delay .2))
