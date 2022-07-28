;;; custom/whatever/config.el -*- lexical-binding: t; -*-

;; timezones that I care about
(after! time
  ;; disable evil in world-clock mode
  (add-hook 'world-clock-mode-hook #'turn-off-evil-mode)

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

(map! :leader
      "bw" #'bk/bitwarden)
