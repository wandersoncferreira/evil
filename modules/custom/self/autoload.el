;;; custom/self/autoload.el -*- lexical-binding: t; -*-

;;;###autoload
(defun bk/bitwarden ()
  "Get bitwarden."
  (interactive)
  (kill-new (auth-source-pick-first-password
             :host "bitwarden.app"
             :user "bartuka")))

;;;###autoload
(defun insert-file-name ()
  "Insert the file name without extension."
  (interactive)
  (let ((path (or buffer-file-name default-directory)))
    (file-name-base buffer-file-name)))
