;;; ../code/evil/preferences/+functions.el -*- lexical-binding: t; -*-

(defun sp-reindent ()
  (interactive)
  (save-excursion
    (er/expand-region 2)
    (evil-indent
     (region-beginning)
     (region-end))))
