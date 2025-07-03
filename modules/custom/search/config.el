;;; custom/search/config.el -*- lexical-binding: t; -*-

(after! consult
  (defun consult-line-symbol-at-point ()
    (interactive)
    (consult-line (thing-at-point 'symbol))))

(defun bk/find-file-in-current-directory ()
  (interactive)
  (projectile-find-file-in-directory default-directory))

(map! :leader
      :desc "search line with symbol at point" "s." #'consult-line-symbol-at-point
      :desc "Find file here!" "sd" #'bk/find-file-in-current-directory)
