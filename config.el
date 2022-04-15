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
    "bindings"
    "cisco.el.gpg"))

(dolist (cfg list-of-preferences)
  (let ((path (format "preferences/+%s" cfg)))
    (if (s-ends-with? ".gpg" path)
        (add-hook 'after-init-hook
                  (lambda ()
                    (load-file (expand-file-name path doom-private-dir))))
      (load! path))))
