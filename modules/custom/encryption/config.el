;;; custom/encryption/config.el -*- lexical-binding: t; -*-

(setq password-cache-expiry nil
      epg-gpg-program "gpg"
      epg-pinentry-mode nil
      auth-sources '("~/.authinfo")
      auth-source-cache-expiry nil
      epa-file-encrypt-to '("wand@hey.com"))
