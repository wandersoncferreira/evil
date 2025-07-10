;;; custom/folders/config.el -*- lexical-binding: t; -*-

(use-package! dired
  :defer t
  :config
  ;; dired tries to guess the default target directory
  (setq dired-dwim-target t)

  ;; DO NOT group directories first
  (setq dired-listing-switches "-alFh"))

(map! :leader "fj" #'dired-jump)

(use-package! dired-subtree
  :after dired
  :config
  (progn
    (set-face-foreground 'dired-subtree-depth-1-face "black")
    (set-face-background 'dired-subtree-depth-1-face "light gray"))
  (bind-key "<tab>" #'dired-subtree-toggle dired-mode-map)
  (bind-key "<backtab>" #'dired-subtree-cycle dired-mode-map))

(use-package! dired-quick-sort
  :after dired
  :config
  (dired-quick-sort-setup))
