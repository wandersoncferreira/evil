;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

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
    "uniquify"
    "folds"
    "modeline"
    "completion"
    "rss"))

(defvar list-of-gpg-preferences
  '("cisco"))

(dolist (cfg list-of-preferences)
  (let ((path (format "preferences/+%s" cfg)))
    (load! path)))

(dolist (cfg list-of-gpg-preferences)
  (bk/load-gpg-file cfg))
