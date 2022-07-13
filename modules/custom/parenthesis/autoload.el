;;; custom/parenthesis/autoload.el -*- lexical-binding: t; -*-

;;;###autoload
(defun bk/improve-last-parens ()
  (interactive)
  (evil-normal-state)
  (evil-append-line 1))
