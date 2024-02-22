;;; custom/orgmode/autoload.el -*- lexical-binding: t; -*-

(require 'org-journal)

;;;###autoload
(defun bk/org-add-today-as-entry ()
  "Insert the current date as a org header"
  (interactive)
  (let* ((time (current-time)))
        (org-insert-heading-respect-content)
        (insert
         (format-time-string org-journal-date-format time))))
