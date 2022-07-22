;;; custom/coding/config.el -*- lexical-binding: t; -*-

(map! :leader
      :desc "Toggle list errors" "fe" #'toggle/flycheck-list-errors
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

(when (featurep! +lsp)
  (after! lsp-mode
    (add-hook 'lsp-after-apply-edits-hook
              (lambda (&rest _)
                (save-buffer)))

    (add-hook 'lsp-completion-mode-hook
              (lambda ()
                (setq-local completion-styles '(orderless)
                            completion-category-defaults nil)))))

(after! better-jumper
  (setq ;; more than 20 jumps, starts to drop the oldest
        better-jumper-max-length 24
        ;; start new window with empty jumplist
        better-jumper-new-window-behavior 'empty
        ))

(after! dumb-jump
  (setq dumb-jump-default-project "~/code"))

;; allow haskell-mode to look for ghc in the current sandbox
(after! haskell-customize
  (setq haskell-process-wrapper-function
        (lambda (args)
          (apply 'nix-shell-command (nix-current-sandbox) args))))

;; allow flycheck to find executables of checkers that would be only
;; accessible via nix-shell
(after! flycheck
  (setq flycheck-command-wrapper-function
        (lambda (command)
          (apply 'nix-shell-command (nix-current-sandbox) command))
        flycheck-executable-find
        (lambda (cmd)
          (nix-executable-find (nix-current-sandbox) cmd))))

;; center window on error
(add-hook! 'next-error-hook #'recenter)

(after! projectile
  (add-to-list 'projectile-project-root-files-bottom-up "project.clj"))
