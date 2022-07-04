;;; ../code/evil/preferences/+lsp.el -*- lexical-binding: t; -*-

(use-package! lsp-mode
  :commands lsp
  :config
  (setq lsp-semantic-tokens-enable t
        lsp-completion-no-cache t
        lsp-file-watch-threshold 2000
        lsp-completion-use-last-result nil)

  (add-hook 'lsp-after-apply-edits-hook
            (lambda (&rest _)
              (save-buffer)))

  (add-hook 'lsp-completion-mode-hook
            (lambda ()
              (setq-local completion-styles '(orderless)
                          completion-category-defaults nil))))
