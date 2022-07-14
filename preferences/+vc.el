;;; $DOOMDIR/preferences/+vc.el -*- lexical-binding: t; -*-

(use-package! code-review
  :commands (code-review-start)
  :load-path "~/code/code-review"
  :init
  (setq code-review-auth-login-marker 'forge
        code-review-new-buffer-window-strategy #'switch-to-buffer)
  :config
  (require 'code-review))

(add-hook 'code-review-mode-hook
          (lambda ()
            ;; include *Code-Review* buffer into current workspace
            (persp-add-buffer (current-buffer))))

(add-hook 'code-review-mode-hook #'emojify-mode)

(after! git-gutter
  (setq git-gutter:update-interval 0.3))
