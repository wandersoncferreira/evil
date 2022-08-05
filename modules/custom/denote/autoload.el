;;; custom/denote/autoload.el -*- lexical-binding: t; -*-

;;;###autoload
(defun bk/denote-find-file (filename)
  "Open FILENAME, a denote file."
  (interactive (list (denote--retrieve-read-file-prompt)))
  (find-file filename))
