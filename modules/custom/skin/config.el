;;; custom/skin/config.el -*- lexical-binding: t; -*-

;; change line spacing for all buffers
(setq-default line-spacing 6)

(setq initial-scratch-message "\
;; Here be evil dragons...
")

;; DO NOT display fixed line numbers in the left fringe
(setq display-line-numbers-type nil)

;; make doom increase font in smaller steps
(setq doom-font-increment 2)

;; enable default theme
(setq doom-theme 'doom-moonlight)

;; enable default font
(setq doom-font
      (font-spec :family "Consolas"
                 :size 14
                 :weight 'regular))

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

(defun enable-some-modus-theme ()
  (setq modus-themes-mode-line '(accented padded borderless)
        modus-themes-region '(bg-only no-extend)
        modus-themes-completions 'opinionated
        modus-themes-fringes 'intense
        modus-themes-completions '(moderate)
        modus-themes-bold-constructs t
        modus-themes-italic-constructs t
        modus-themes-subtle-line-numbers t
        modus-themes-lang-checkers '(background)))

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

;; prevents some cases of emacs flickering
(add-to-list 'default-frame-alist '(inhibit-double-buffering . t))

;;; * skin keybindings
(map! :leader
      :desc "Delete other windows" "wo" #'delete-other-windows
      :desc "Toggle Transparency" "tt" #'bk/toggle-transparency
      :desc "Fullscreen (maximized)" "wf" #'toggle-frame-maximized
      :desc "Set window to 80 columns" "w8" #'bk/set-80-columns)
