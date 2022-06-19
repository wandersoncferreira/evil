;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(require 's)

;;;###autoload
(defun bk/load-gpg-file (filename)
  (let ((file (expand-file-name (format "preferences/+%s.el.gpg" filename) doom-private-dir))
        (file-name-handler-alist '(("\\.gpg\\(~\\|\\.~[0-9]+~\\)?\\'" . epa-file-handler))))
    (load-file file)))

(defvar list-of-preferences
  '("blog"
    "cisco.gpg"
    "clojure"
    "coding"
    "completion"
    "doom"
    "elisp"
    "encryption"
    "evil"
    "finance"
    "gifs"
    "java"
    "lsp"
    "modeline"
    "parens"
    "persp"
    "projectile"
    "vc"))

(dolist (cfg list-of-preferences)
  (if (s-ends-with? ".gpg" cfg)
      (bk/load-gpg-file (car (s-split ".gpg" cfg)))
    (let ((path (format "preferences/+%s" cfg)))
      (load! path))))
