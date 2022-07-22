;;; custom/whatever/config.el -*- lexical-binding: t; -*-

;; timezones that I care about
(after! time
  (setq world-clock-list
        '(("America/Chicago" "Central")
          ("Europe/Paris" "Paris")
          ("Europe/Berlin" "Berlin")
          ("Europe/Zurich" "Zurich")
          ("EST5EDT" "Durham")
          ("MST7MDT" "Calgary"))))

(when (featurep! "+screencast")
  (use-package! gif-screencast
    :defer t
    :commands gif-screencast
    :init
    (setq gif-screencast-args '("-x")
          gif-screencast-cropping-program ""
          gif-screencast-capture-format "ppm")))

(when (featurep! "+pocket-reader")
  (use-package! pocket-reader
    :defer t
    :commands pocket-reader
    :config
    ;; change face for archived items
    (set-face-attribute 'pocket-reader-archived nil :foreground "dim gray")
    :bind (:map pocket-reader-mode-map
           ("j" . evil-next-line)
           ("k" . evil-previous-line)))

  (after! evil
    (add-hook 'pocket-reader-mode-hook #'turn-off-evil-mode)))
