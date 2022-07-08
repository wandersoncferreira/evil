;;; custom/encryption/config.el -*- lexical-binding: t; -*-

(setq epg-gpg-program "gpg"
      password-cache-expiry nil
      auth-sources (nreverse auth-sources)
      auth-source-cache-expiry nil
      epg-pinentry-mode nil
      epa-file-encrypt-to '("wand@hey.com"))
