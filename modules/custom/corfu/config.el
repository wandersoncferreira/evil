;;; custom/corfu/config.el -*- lexical-binding: t; -*-

(use-package! corfu
  :init
  (setq corfu-auto t
        corfu-auto-delay 0.1
        corfu-separator ?&)
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
      "C-h" 'corfu-doc-toggle)
