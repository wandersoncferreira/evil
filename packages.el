;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

;;; standard way to fix all lisp + evil + structural editing issues
(package! delight)
(package! gif-screencast)
(package! company-quickhelp)
(package! windresize)
(package! evil-cleverparens)
(package! evil-smartparens)
(package! evil-motion-trainer :recipe
  (:host github :repo "martinbaillie/evil-motion-trainer"))

;;; disabling some packages
;; company
(package! company-dict :disable t)

;; doom
(package! solaire-mode :disable t)
(package! doom-themes :disable t)

;; magit
(package! magit-gitflow :disable t)

;; eshell
(package! eshell-z :disable t)
(package! eshell-did-you-mean :disable t)
(package! esh-help :disable t)
(package! shrink-path :disable t)
(package! eshell-up :disable t)

;; dired
(package! diff-hl :disable t)
(package! fd-dired :disable t)
(package! diredfl :disable t)
(package! dired-rsync :disable t)

;; lsp
(package! consult-lsp :disable t)

;; elisp
(package! macrostep :disable t)
(package! overseer :disable t)
(package! elisp-def :disable t)
(package! elisp-demos :disable t)

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
(package! osx-trash :disable t)

;; latex
(package! company-reftex :disable t)
(package! company-math :disable t)

;; java
(package! android-mode :disable t)
(package! groovy-mode :disable t)

;; rss
(package! elfeed-goodies :disable t)

;; defaults - core
(package! drag-stuff :disable t)
(package! expand-region :disable t)
(package! paredit :disable t)
(package! highlight-numbers :disable t)
(package! all-the-icons :disable t)
(package! helpful :disable t)
(package! restart-emacs :disable t)

;; vertico
(package! marginalia :disable t)
(package! consult-dir :disable t)

;; org roam
(unpin! org-roam)
(package! org-roam-ui)

;; evil
(package! evil-args :disable t)
(package! evil-easymotion :disable t)
(package! evil-embrace :disable t)
(package! evil-exchange :disable t)
(package! evil-indent-plus :disable t)
(package! evil-lion :disable t)
(package! evil-nerd-commenter :disable t)
(package! evil-numbers :disable t)
(package! evil-snipe :disable t)
(package! evil-surround :disable t)
(package! evil-textobj-anyblock :disable t)
(package! evil-traces :disable t)
(package! evil-visualstar :disable t)
(package! exato :disable t)
(package! evil-quick-diff :disable t)

;; packages removed that I'm uncertain if I need them
;; I need to understand their value proposition first
(package! consult-flycheck :disable t)
(package! embark :disable t)
(package! embark-consult :disable t)
(package! wgrep :disable t)
(package! better-jumper :disable t)
