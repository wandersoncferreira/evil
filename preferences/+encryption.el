;;; ../code/evil/+encryption.el -*- lexical-binding: t; -*-

(require 'epa)
(require 'auth-source)

(setq epg-gpg-program "gpg"
      password-cache-expiry nil
      auth-sources (nreverse auth-sources)
      auth-source-cache-expiry nil
      epa-file-encrypt-to '("wand@hey.com"))

(set 'epg-pinentry-mode nil)
