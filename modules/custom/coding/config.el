;;; custom/coding/config.el -*- lexical-binding: t; -*-

(map! :leader
      :desc "Toggle list errors" "fe" #'bk/flycheck-list-errors
      :desc "Check buffer syntax" "fb" #'flycheck-buffer)

(after! flycheck
  ;; uses `flycheck-buffer' manually to check syntax
  (setq flycheck-check-syntax-automatically nil))

(after! ws-butler
  (setq ws-butler-global-exempt-modes
        '(special-mode
          comint-mode
          diff-mode
          eshell-mode
          markdown-mode
          org-mode)))

;; center window on error
(add-hook! 'next-error-hook #'recenter)

;; add project.clj file to projectile root
(after! projectile
  (add-to-list 'projectile-project-root-files-bottom-up "project.clj"))

;; make evil start in emacs state for magit commit buffers
(add-hook 'git-commit-mode-hook 'evil-insert-state)

(use-package! lsp-ui
  :after lsp-mode
  :commands lsp-ui-mode
  :config
  (setq lsp-ui-doc-enable nil
        lsp-ui-peek-enable nil))

(after! flycheck
  (setq flycheck-keymap-prefix nil)
  (map! :leader "!" flycheck-command-map))
