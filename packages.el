;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

;; used to fix some inconsistencies with smartparens and evil mode..
;; specially related to the strict-mode
;; I don't like unbalanced s-expressions
(package! evil-smartparens)

;; disabling some packages
(package! magit-gitflow :disable t)
(package! marginalia :disable t)
