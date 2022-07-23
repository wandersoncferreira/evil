;;; custom/corfu/config.el -*- lexical-binding: t; -*-

(use-package! corfu
  :init
  (setq corfu-separator ?&
        ;; stop the madness of completion *all the time*
        corfu-auto nil
        corfu-quit-no-match 'separator)
  :config
  (global-corfu-mode)

  (map! :map corfu-map
        "SPC" 'corfu-insert-separator))

;; fix corfu for evil users
(evil-make-overriding-map corfu-map)
(advice-add 'corfu--setup :after 'evil-normalize-keymaps)
(advice-add 'corfu--teardown :after 'evil-normalize-keymaps)

;; docs on M-h
(when (featurep! "+docs")
  (use-package! corfu-doc
    :after corfu
    :init
    (setq corfu-doc-auto nil)
    :config
    (add-hook 'corfu-mode-hook #'corfu-doc-mode))

  (map! :map corfu-map
        "C-h" 'corfu-doc-toggle))

(when (featurep! "+icons")
  (use-package! kind-icon
    :after corfu
    :init
    (setq kind-icon-default-face 'corfu-default
          kind-icon-use-icons nil)
    :config
    (add-to-list 'corfu-margin-formatters #'kind-icon-margin-formatter)))

(when (featurep! "+cape")
  (use-package! cape
    :bind (("M-p f" . cape-file)
           ("M-p l" . cape-line)
           ("M-p k" . cape-keyword))))
