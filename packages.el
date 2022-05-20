;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

;;; standard way to fix all lisp + evil + structural editing issues
(package! delight)
(package! gif-screencast)
(package! evil-motion-trainer :recipe
  (:host github :repo "martinbaillie/evil-motion-trainer"))

;;; disabling some packages
;; company
(package! company-dict :disable t)

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

;; markdown
(package! markdown-toc :disable t)

;; org
(package! avy :disable t)
(package! org-yt :disable t)

;; macos
(package! ns-auto-titlebar :disable t)

;; rss
(package! elfeed-goodies :disable t)

;; defaults
(package! drag-stuff :disable t)
(package! expand-region :disable t)
(package! paredit :disable t)

;; org roam
(unpin! org-roam)
(package! org-roam-ui)
