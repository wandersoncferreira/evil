;;; custom/landlord/config.el -*- lexical-binding: t; -*-

;; code review!
(when (modulep! +code-review)
  (use-package! code-review
    :commands (code-review-start)
    :init
    (setq code-review-auth-login-marker 'forge
          code-review-new-buffer-window-strategy #'switch-to-buffer)
    :config
    (require 'code-review)

    (add-hook 'code-review-mode-hook
              (lambda ()
                ;; emojify!
                (emojify-mode)))))

(when (modulep! +spotify)
  (use-package! helm-spotify-plus
    :commands (helm-spotify-plus)
    :config
    (set-popup-rule! "*helm-spotify*" :side 'bottom :size 0.5)))

(when (modulep! +oblique)
  (use-package! oblique-strategies
    :commands (oblique-strategies)))
