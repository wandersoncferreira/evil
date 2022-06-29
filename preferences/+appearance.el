;;; $DOOMDIR/preferences/+appearance.el -*- lexical-binding: t; -*-

(defun highlight-todos ()
  (font-lock-add-keywords
   nil
   '(("\\<\\(FIXME\\|TODO\\|BUG\\):" 1 font-lock-warning-face t))))

(after! clojure-mode
  (add-hook 'clojure-mode-hook #'highlight-todos))

;; change frige width
(fringe-mode '(10 . 0))

(defun enable-default-black-theme ()
  "customizing the faces for default-black theme."
  (setq doom-theme 'default-black)
  (add-hook 'after-init-hook
            (lambda ()
              (custom-set-faces
               '(success ((t (:foreground "ForestGreen" :weight bold))))
               '(vertico-current ((t (:background "DarkSlateGray")))))
              )))

(defun enable-vim-colors ()
  "enable the vim-colors theme."
  (setq doom-theme 'vim-colors))

(defun enable-modus-vivendi ()
  (setq modus-themes-mode-line '(accented padded borderless)
        modus-themes-region '(bg-only no-extend)
        modus-themes-completions '(moderate)
        modus-themes-bold-constructs t
        modus-themes-italic-constructs t
        modus-themes-paren-match '(bold intense)
        modus-themes-subtle-line-numbers t
        modus-themes-lang-checkers '(background)
        doom-theme 'modus-vivendi))

;; current theme
(enable-modus-vivendi)
