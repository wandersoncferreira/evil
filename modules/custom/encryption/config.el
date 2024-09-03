;;; custom/encryption/config.el -*- lexical-binding: t; -*-

(setq password-cache-expiry nil
      epg-gpg-program "gpg"
      epg-pinentry-mode nil
      auth-sources '("/home/bartuka/.authinfo.gpg")
      auth-source-cache-expiry nil
      epa-file-encrypt-to '("wand@hey.com"))

(plist-get (car (auth-source-search :max 1 :host "openai.com")) :secret)
