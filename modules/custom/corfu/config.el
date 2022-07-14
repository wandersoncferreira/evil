;;; custom/corfu/config.el -*- lexical-binding: t; -*-

(use-package! corfu
  :init
  (setq corfu-auto t
        corfu-separator ?&
        corfu-quit-no-match 'separator)
  :config
  (global-corfu-mode))

;; docs on M-h
(use-package! corfu-doc
  :after corfu
  :init
  (setq corfu-doc-auto nil)
  :config
  (add-hook 'corfu-mode-hook #'corfu-doc-mode))

(map! :map corfu-map
      "C-h" 'corfu-doc-toggle
      "M-SPC" 'corfu-insert-separator)

(use-package! kind-icon
  :after corfu
  :init
  (setq kind-icon-default-face 'corfu-default
        kind-icon-use-icons nil)
  :config
  (add-to-list 'corfu-margin-formatters #'kind-icon-margin-formatter))

;; fix corfu for evil users
(evil-make-overriding-map corfu-map)
(advice-add 'corfu--setup :after 'evil-normalize-keymaps)
(advice-add 'corfu--teardown :after 'evil-normalize-keymaps)
