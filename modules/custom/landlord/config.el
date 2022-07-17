;;; custom/landlord/config.el -*- lexical-binding: t; -*-

;; code review!

(use-package! code-review
  :commands (code-review-start)
  :load-path "~/code/code-review"
  :init
  (setq code-review-auth-login-marker 'forge
        code-review-new-buffer-window-strategy #'switch-to-buffer)
  :config
  (require 'code-review)

  (add-hook 'code-review-mode-hook
            (lambda ()
              ;; include *Code-Review* buffer into current workspace
              (persp-add-buffer (current-buffer))
              ;; emojify!
              (emojify-mode)
              )))

(after! git-gutter
  (setq git-gutter:update-interval 0.3))
