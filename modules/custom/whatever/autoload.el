;;; custom/whatever/autoload.el -*- lexical-binding: t; -*-

;;;###autoload
(defun bk/bitwarden ()
  "Get bitwarden."
  (interactive)
  (kill-new (auth-source-pick-first-password
             :host "bitwarden.app"
             :user "bartuka"))
  (message "Bitwarden copied!"))
