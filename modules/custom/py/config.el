;;; custom/py/config.el -*- lexical-binding: t; -*-

(setq python-interpreter "~/base/bin/python"
      python-shell-interpreter "~/base/bin/python")

(use-package! pyvenv
  :ensure t
  :config
  (pyvenv-mode t))

;; Then open emacs M-x pyvenv-activate RET dir_to_the_environment
