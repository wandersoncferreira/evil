;;; custom/coding/config.el -*- lexical-binding: t; -*-

(map! :leader
      :desc "Toggle list errors" "fe" #'toggle/flycheck-list-errors
      :desc "Check buffer syntax" "fb" #'flycheck-buffer)

(after! flycheck
  ;; uses `flycheck-buffer' manually to check syntax
  (setq flycheck-check-syntax-automatically nil))

(after! ws-butler
  ;; include org mode too
  (setq ws-butler-global-exempt-modes
        '(special-mode
          comint-mode
          diff-mode
          eshell-mode
          markdown-mode
          org-mode)))

;;; enable lsp for coding
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

(after! better-jumper
  (setq ;; more than 20 jumps, starts to drop the oldest
        better-jumper-max-length 24
        ;; start new window with empty jumplist
        better-jumper-new-window-behavior 'empty
        ))

(after! dumb-jump
  (setq dumb-jump-default-project "~/code"))
