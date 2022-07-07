;;; custom/miscellaneous/config.el -*- lexical-binding: t; -*-

(use-package! gif-screencast
  :defer t
  :commands gif-screencast
  :init
  (setq gif-screencast-args '("-x")
        gif-screencast-cropping-program ""
        gif-screencast-capture-format "ppm"))

(use-package! pocket-reader
  :defer t
  :commands pocket-reader
  :config
  ;; change face for archived items
  (set-face-attribute 'pocket-reader-archived nil :foreground "dim gray"))
