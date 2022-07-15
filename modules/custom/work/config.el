;;; custom/work/config.el -*- lexical-binding: t; -*-

;; load work related configurations

(when load-cisco?
  (load-file (expand-file-name "emacs-at-work/cisco.el" doom-private-dir)))
