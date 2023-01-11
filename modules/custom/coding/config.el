;;; custom/coding/config.el -*- lexical-binding: t; -*-

(use-package! flycheck
  :init
  ;; uses `flycheck-buffer' manually to check syntax
  (setq flycheck-check-syntax-automatically nil)
  :config
  (setq flycheck-keymap-prefix nil)
  (map! :leader "!" flycheck-command-map))

(use-package! ws-butler
  :init
  (setq ws-butler-global-exempt-modes
        '(special-mode
          comint-mode
          diff-mode
          eshell-mode
          markdown-mode
          org-mode)))

;; center window on error
(add-hook! 'next-error-hook #'recenter)

(use-package! projectile
  :config
  ;; add project.clj file to projectile root
  (add-to-list 'projectile-project-root-files-bottom-up "project.clj"))

;; make evil start in emacs state for magit commit buffers
(add-hook 'git-commit-mode-hook 'evil-insert-state)

;;; * coding keymaps
(map! :leader
      :desc "Toggle list errors" "fe" #'bk/flycheck-list-errors
      :desc "Check buffer syntax" "fb" #'flycheck-buffer)
