;;; custom/rst/config.el -*- lexical-binding: t; -*-

(after! lsp-rust
  (setq lsp-rust-analyzer-server-display-inlay-hints t
        lsp-rust-analyzer-display-chaining-hints t
        lsp-rust-analyzer-display-closure-return-type-hints t)
  (lsp-rust-analyzer-inlay-hints-mode t))
