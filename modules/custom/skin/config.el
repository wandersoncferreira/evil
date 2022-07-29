;;; custom/skin/config.el -*- lexical-binding: t; -*-

(use-package! delight
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
                " "
                mode-line-position
                " "
                mode-line-modes
                mode-line-misc-info
                mode-line-end-spaces))

;; disable highliting of current line
(remove-hook 'doom-first-buffer-hook 'global-hl-line-mode)

;; disable aesthetic plugin for fancier bullets
(remove-hook 'org-mode-hook #'org-superstar-mode)

(defun highlight-todos ()
  "highlight common words to indicate work in progress for dev projects"
  (font-lock-add-keywords
   nil
   '(("\\<\\(FIXME\\|TODO\\|BUG\\):" 1 font-lock-warning-face t))))

(after! clojure-mode
  (add-hook 'clojure-mode-hook #'highlight-todos))

;; change frige width
(fringe-mode '(10 . 0))

;; do not truncate lines in the minibuffer
(add-hook 'minibuffer-setup-hook
          (lambda ()
            (setq truncate-lines nil)))

;; start emacs with specific size and position
(setq initial-frame-alist
      '((top . 0)
        (left . -1)
        (width . 82)
        (height . 65)))

;; enable column indicator
(global-display-fill-column-indicator-mode)

(map! :leader
      :desc "Set window to 80 columns" "w8" #'bk/set-80-columns)

(defun enable-some-modus-theme ()
  (setq modus-themes-mode-line '(accented padded borderless)
        modus-themes-region '(bg-only no-extend)
        modus-themes-completions 'opinionated
        modus-themes-fringes 'intense
        modus-themes-completions '(moderate)
        modus-themes-bold-constructs t
        modus-themes-italic-constructs t
        modus-themes-paren-match 'intense-bold
        modus-themes-subtle-line-numbers t
        modus-themes-lang-checkers '(background)))

;; change default font
(setq doom-font (font-spec :family "Consolas"
                           :size 14
                           :weight 'regular))

(defun enable-modus-vivendi ()
  (enable-some-modus-theme)
  (setq doom-theme 'modus-vivendi))

(defun enable-modus-operandi ()
  (enable-some-modus-theme)
  (setq doom-theme 'modus-operandi))

(defun enable-default-black-theme ()
  "customizing the faces for default-black theme."
  (setq doom-theme 'default-black)
  (add-hook 'after-init-hook
            (lambda ()
              (custom-set-faces
               '(success ((t (:foreground "ForestGreen" :weight bold))))
               '(vertico-current ((t (:background "DarkSlateGray"))))))))

(defun enable-vim-colors ()
  "enable the vim-colors theme."
  (setq doom-theme 'vim-colors))

;; current theme
(enable-modus-vivendi)

(map! :leader
      "wo" #'delete-other-windows
      "wt" #'bk/toggle-window-split
      :desc "Fullscreen (maximized)" "wf" #'toggle-frame-maximized)

;; prevents some cases of emacs flickering
(add-to-list 'default-frame-alist '(inhibit-double-buffering . t))
