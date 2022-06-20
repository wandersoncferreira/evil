;;; $DOOMDIR/preferences/+modeline.el -*- lexical-binding: t; -*-

(use-package delight
  :config
  (delight
   '((company-mode nil company)
     (eldoc-mode nil eldoc)

     (dired-omit-mode nil dired-x)
     (better-jumper-local-mode nil better-jumper)
     (which-key-mode nil which-key)
     (ws-butler-mode nil ws-butler)
     (yas-minor-mode nil yasnippet)
     (outline-minor-mode nil outline)
     (git-gutter-mode nil git-gutter)
     (smartparens-mode nil smartparens)
     (lsp-lens-mode nil lsp-lens)
     (clj-refactor-mode nil clj-refactor)
     (visual-line-mode nil simple)
     (vi-tilde-fringe-mode nil vi-tilde-fringe)
     (dtrt-indent-mode nil dtrt-indent)

     (evil-snipe-local-mode nil evil-snipe)
     (evil-escape-mode nil evil-escape)
     (evil-traces-mode nil evil-traces)
     (evil-org-mode nil evil-org)
     (evil-smartparens-mode nil evil-smartparens)
     (evil-cleverparens-mode nil evil-cleverparens)
     (evil-goggles-mode nil evil-goggles)

     (org-indent-mode nil org-indent)
     (projectile-mode nil projectile)
     (gcmh-mode nil gcmh)
     (whitespace-mode nil whitespace))))

(setq-default mode-line-format
              '("%e"
                mode-line-front-space
                (:propertize
                 ("" mode-line-modified mode-line-remote)
                 display
                 (min-width
                  (5.0)))
                " "
                mode-line-buffer-identification
                "   "
                mode-line-position
                "  "
                mode-line-modes
                mode-line-misc-info
                mode-line-end-spaces))
