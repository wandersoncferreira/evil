;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

;; used to fix some inconsistencies with smartparens and evil mode..
;; specially related to the strict-mode
;; I don't like unbalanced s-expressions
(package! evil-smartparens)

;;; disabling some packages
;; company
(package! company-dict :disable t)

;; vertico
(package! marginalia :disable t)

;; doom
(package! solaire-mode :disable t)

;; magit
(package! magit-gitflow :disable t)

;; dired
(package! diff-hl :disable t)
(package! fd-dired :disable t)
(package! diredfl :disable t)
(package! dired-rsync :disable t)

;; modeline
(package! anzu :disable t)
(package! evil-anzu :disable t)
