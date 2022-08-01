;;; custom/landlord/config.el -*- lexical-binding: t; -*-

;; code review!

(when (featurep! +code-review)
  (use-package! code-review
    :commands (code-review-start)
    ;; :load-path "~/code/code-review"
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
                (emojify-mode)))))

(when (featurep! +spotify)
  (use-package! helm-spotify-plus
    :commands (helm-spotify-plus)
    :config
    (set-popup-rule! "*helm-spotify*" :side 'bottom :size 0.5)))

(when (featurep! +oblique)
  (use-package! oblique-strategies
    :commands (oblique-strategies)))
