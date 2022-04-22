;;; $DOOMDIR/preferences/+encryption.el -*- lexical-binding: t; -*-

(require 'epa)
(require 'auth-source)

(setq epg-gpg-program "gpg"
      password-cache-expiry nil
      auth-sources (nreverse auth-sources)
      auth-source-cache-expiry nil
      epa-file-encrypt-to '("wand@hey.com"))

(set 'epg-pinentry-mode nil)

;;;###autoload
(defun bk/bitwarden ()
  "Get bitwarden."
  (interactive)
  (kill-new (auth-source-pick-first-password
             :host "bitwarden.app"
             :user "bartuka")))
