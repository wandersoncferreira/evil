;;; custom/encryption/config.el -*- lexical-binding: t; -*-

(after! password-cache
  (setq password-cache-expiry nil))

(after! epg-config
  (setq epg-gpg-program "gpg"
        epg-pinentry-mode nil))

(after! auth-source
  (setq auth-sources (nreverse auth-sources)
        auth-source-cache-expiry nil))

(after! epa-hook
  (setq epa-file-encrypt-to '("wand@hey.com")))
