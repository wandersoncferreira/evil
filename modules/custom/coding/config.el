;;; custom/coding/config.el -*- lexical-binding: t; -*-

(map! :leader
      :desc "Toggle list errors" "fe" #'bk/flycheck-list-errors
      :desc "Check buffer syntax" "fb" #'flycheck-buffer)

(after! flycheck
  ;; uses `flycheck-buffer' manually to check syntax
  (setq flycheck-check-syntax-automatically nil
        ;; allow flycheck to find executables of checkers that would be only
        ;; accessible via nix-shell
        flycheck-command-wrapper-function
        (lambda (command)
          (apply 'nix-shell-command (nix-current-sandbox) command))
        flycheck-executable-find
        (lambda (cmd)
          (nix-executable-find (nix-current-sandbox) cmd))) )

(after! ws-butler
  (setq ws-butler-global-exempt-modes
        '(special-mode
          comint-mode
          diff-mode
          eshell-mode
          markdown-mode
          org-mode)))

;; allow haskell-mode to look for ghc in the current sandbox
(after! haskell-customize
  (setq haskell-process-wrapper-function
        (lambda (args)
          (apply 'nix-shell-command (nix-current-sandbox) args))))

;; center window on error
(add-hook! 'next-error-hook #'recenter)

;; add project.clj file to projectile root
(after! projectile
  (add-to-list 'projectile-project-root-files-bottom-up "project.clj"))

;; make evil start in emacs state for magit commit buffers
(add-hook 'git-commit-mode-hook 'evil-insert-state)

(use-package! lsp-treemacs
  :config
  (setq lsp-treemacs-error-list-current-project-only t))

(use-package! lsp-ui
  :after lsp-mode
  :commands lsp-ui-mode
  :config
  (setq lsp-ui-doc-enable nil
        lsp-ui-peek-enable nil))
