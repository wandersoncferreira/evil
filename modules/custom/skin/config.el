;;; custom/skin/config.el -*- lexical-binding: t; -*-

;; change line spacing for all buffers
(setq-default line-spacing 2)

(setq initial-scratch-message "\
;; Here be evil dragons...
")

;; DO NOT display fixed line numbers in the left fringe
(setq display-line-numbers-type nil)

;; enable default font
(setq wsl? (not
            (booleanp
             (string-search "microsoft" (shell-command-to-string "uname -a")))))
(setq macos? (not
              (booleanp
               (string-search "Darwin" (shell-command-to-string "uname -a")))))

;; am i in vinhedo?
(setq vinhedo-computer? nil)

(setq doom-font (font-spec :family "Consolas"
                           :size (cond
                                  ((eq wsl? 't) 22)
                                  ((eq macos? 't) 12)
                                  ((eq vinhedo-computer? 't) 12)
                                  (20))))

;; disable highliting of current line
(remove-hook 'doom-first-buffer-hook 'global-hl-line-mode)

;; disable aesthetic plugin for fancier bullets
;; (remove-hook 'org-mode-hook #'org-superstar-mode)

(defun highlight-todos ()
  "highlight common words to indicate work in progress for dev projects"
  (font-lock-add-keywords
   nil
   '(("\\<\\(FIXME\\|TODO\\|BUG\\):" 1 font-lock-warning-face t))))

(after! clojure-mode
  (add-hook 'clojure-mode-hook #'highlight-todos))

;; do not truncate lines in the minibuffer
(add-hook 'minibuffer-setup-hook
          (lambda ()
            (setq truncate-lines nil)))

;; start emacs with specific size and position
(setq initial-frame-alist
      '((top . 300)
        (left . 2500)
        (width . 82)
        (height . 70)
        (vertical-scroll-bars . nil)
        (horizontal-scroll-bars . nil)
        (tool-bar-lines . 0)))

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


;; best theme is dark default theme
;; (setq doom-theme nil)
;; (when (display-graphic-p)
;;   (invert-face 'default))
;; (set-variable 'frame-background-mode 'dark)

(enable-vim-colors)

;;; * skin keybindings
(map! :leader
      :desc "Delete other windows" "wo" #'delete-other-windows
      :desc "Toggle Transparency" "tt" #'bk/toggle-transparency
      :desc "Fullscreen (maximized)" "wf" #'toggle-frame-maximized
      :desc "Set window to 80 columns" "w8" #'bk/set-80-columns)
