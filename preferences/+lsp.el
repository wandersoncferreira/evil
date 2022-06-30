;;; ../code/evil/preferences/+lsp.el -*- lexical-binding: t; -*-

(use-package! lsp-mode
  :commands lsp
  :config
  (setq lsp-semantic-tokens-enable t
        lsp-completion-no-cache t
        lsp-completion-use-last-result nil)

  (add-hook 'lsp-after-apply-edits-hook
            (lambda (&rest _)
              (save-buffer))))
