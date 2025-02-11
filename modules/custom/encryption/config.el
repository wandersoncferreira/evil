;;; custom/encryption/config.el -*- lexical-binding: t; -*-

(setq password-cache-expiry nil
      epg-gpg-program "gpg"
      epg-pinentry-mode nil
      auth-sources '("~/.authinfo")
      auth-source-cache-expiry nil)

;; always use this gpg key to encrypt files by default
(setq epa-file-encrypt-to '("wand@hey.com")
      epa-file-select-keys 1)
