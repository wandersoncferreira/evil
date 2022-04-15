;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; loading extra functions
(load! "+doom")
(load! "+functions")
(load! "+encryption")
(load! "+parens")
(load! "+evil")
(load! "+lsp")
(load! "+clojure")
(load! "+elisp")
(load! "+bindings")

;; cisco configs
;; we need to postpone the loading of gpg files to make it work
(add-hook 'after-init-hook
          (lambda ()
            (load-file (expand-file-name "+cisco.el.gpg" doom-private-dir))
            (require '+cisco)))
