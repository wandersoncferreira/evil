;;; $DOOMDIR/preferences/+appearance.el -*- lexical-binding: t; -*-

;; highlight common words to indicate work in dev projects
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

(defun enable-some-modus-theme ()
  (setq modus-themes-mode-line '(accented padded borderless)
        modus-themes-region '(bg-only no-extend)
        modus-themes-completions '(moderate)
        modus-themes-bold-constructs t
        modus-themes-italic-constructs t
        modus-themes-paren-match '(bold intense)
        modus-themes-subtle-line-numbers t
        modus-themes-lang-checkers '(background)))

(defun enable-modus-vivendi ()
  (enable-some-modus-theme)
  (setq doom-theme 'modus-vivendi))

(defun enable-modus-operandi ()
  (enable-some-modus-theme)
  (setq doom-theme 'modus-operandi))

;; current theme
(enable-modus-vivendi)

;; start emacs with specific size and position
(setq initial-frame-alist
      '((top . 0)
        (left . -1)
        (width . 82)
        (height . 65)))

;; enable column indicator
(global-display-fill-column-indicator-mode)

;; set window width in 80 chars
(defun set-window-width (n)
  "Set the selected window's width."
  (adjust-window-trailing-edge
   (selected-window)
   (- n (window-width)) t))

(defun set-80-columns ()
  "Set the selected window to 80 columns."
  (interactive)
  (set-window-width 80))

(map! :leader
      :desc "Set window to 80 columns" "w8" #'set-80-columns)

(defun set-font-for-laptop-usage ()
  "Set the font to a smaller value when working from the laptop.
Fit more in the screen!"
  (interactive)
  (setq doom-font (font-spec :size 11))
  (doom/reload-font))

(defun set-font-dual-monitor ()
  "Set the font to a higher value when working from external monitor."
  (interactive)
  (setq doom-font (font-spec :size 13))
  (doom/reload-font))

;; do not truncate lines in the minibuffer
(add-hook 'minibuffer-setup-hook
          (lambda ()
            (setq-local truncate-lines nil)))
