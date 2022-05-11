;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(require 's)

(defvar list-of-preferences
  '("doom"
    "functions"
    "encryption"
    "parens"
    "evil"
    "lsp"
    "clojure"
    "elisp"
    "projectile"
    "modeline"
    "completion"
    "cisco.gpg"
    "vc"
    "gifs"
    "evil-gym"
    "blog"
    "rss"))

(dolist (cfg list-of-preferences)
  (if (s-ends-with? ".gpg" cfg)
      (bk/load-gpg-file (car (s-split ".gpg" cfg)))
    (let ((path (format "preferences/+%s" cfg)))
      (load! path))))
