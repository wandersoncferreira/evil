;;; $DOOMDIR/preferences/+doom.el -*- lexical-binding: t; -*-

(setq user-full-name "Wanderson Ferreira"
      user-mail-address "wand@hey.com"

      ;; theme - I'm a huge fan of the default theme
      ;; let's stay really close to Vim for a while =)
      doom-theme 'vim-colors

      ;; font
      doom-font (font-spec :size 14)

      ;; DO NOT display fixed line numbers in the left fringe
      display-line-numbers-type nil

      ;; where to find/add my org files?
      org-directory "~/org/"

      ;; do not ask me if I want to leave Emacs
      confirm-kill-emacs nil

      ;; dired tries to guess the default target directory
      dired-dwim-target t

      ;; prefer to use newer files always
      load-prefer-newer t

      ;; tab key is very useful in insert molde to fix identation or completion imho
      tab-always-indent 'complete)

;; DO NOT group directories first
(after! dired
  (setq dired-listing-switches "-alh"))

;; change line spacing for all bufferd
(setq-default line-spacing 6)

;; disable highliting of current line
(remove-hook 'doom-first-buffer-hook 'global-hl-line-mode)

;; disable aesthetic plugin for fancier bullets
(remove-hook 'org-mode-hook #'org-superstar-mode)

(map! :leader
      "fj" #'dired-jump
      "y" #'consult-yank-from-kill-ring
      "pt" #'projectile-toggle-between-implementation-and-test
      "wo" #'delete-other-windows
      :desc "Fullscreen (maximized)" "wf" #'toggle-frame-maximized
      :desc "CamelCase" "tc" #'subword-mode
      :desc "Column Indicator" "ti" #'display-fill-column-indicator-mode)

;;;###autoload
(defun bk/toggle-transparency ()
  (interactive)
  (let ((alpha (frame-parameter nil 'alpha)))
    (set-frame-parameter
     nil 'alpha
     (if (or (eql (cond ((numberp alpha) alpha)
                        ((numberp (cdr alpha)) (cdr alpha))
                        ((numberp (cadr alpha)) (cadr alpha)))
                  100)
             (not alpha))
         85
       100))))

;;;###autoload
(defun bk/bitwarden ()
  "Get bitwarden."
  (interactive)
  (kill-new (auth-source-pick-first-password
             :host "bitwarden.app"
             :user "bartuka")))
