;;; $DOOMDIR/preferences/+modeline.el -*- lexical-binding: t; -*-

(use-package delight
  :config
  (delight
   '((company-mode nil company)
     (eldoc-mode nil eldoc)
     (evil-snipe-local-mode nil evil-snipe)
     (better-jumper-local-mode nil better-jumper)
     (which-key-mode nil which-key)
     (ws-butler-mode nil ws-butler)
     (yas-minor-mode nil yasnippet)
     (outline-minor-mode nil outline)
     (git-gutter-mode nil git-gutter)
     (smartparens-mode nil smartparens)
     (lsp-lens-mode nil lsp-lens)
     (clj-refactor-mode nil clj-refactor)
     (dtrt-indent-mode nil dtrt-indent)
     (evil-escape-mode nil evil-escape)
     (projectile-mode (:eval (concat " Prj[" (projectile-project-name) "]")) projectile)
     (gcmh-mode nil gcmh)
     (whitespace-mode nil whitespace))))
