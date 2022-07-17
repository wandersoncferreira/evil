;;; custom/work/config.el -*- lexical-binding: t; -*-

;; load work related configurations

(when (featurep! +cisco)
  (load-file (expand-file-name "landlord/emacs-at-work/cisco.el" doom-private-dir)))
