;;; $DOOMDIR/preferences/+vc.el -*- lexical-binding: t; -*-

(use-package! code-review
  :load-path "~/code/code-review"
  :init
  (setq code-review-auth-login-marker 'forge
        code-review-new-buffer-window-strategy #'switch-to-buffer)
  :config
  (require 'code-review))
