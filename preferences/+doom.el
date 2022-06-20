;;; $DOOMDIR/preferences/+doom.el -*- lexical-binding: t; -*-

(setq user-full-name "Wanderson Ferreira"
      user-mail-address "wand@hey.com"

      ;; font
      ;; doom-font (font-spec :family "IBM Plex Mono" :size 14)

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

;; change line spacing for all buffers
(setq-default line-spacing 6)

;; disable highliting of current line
(remove-hook 'doom-first-buffer-hook 'global-hl-line-mode)

;; disable aesthetic plugin for fancier bullets
(remove-hook 'org-mode-hook #'org-superstar-mode)

(map! :leader
      "fj" #'dired-jump
      "y" #'consult-yank-from-kill-ring
      "pt" #'projectile-toggle-between-implementation-and-test
      :desc "CamelCase" "tc" #'subword-mode
      :desc "Column Indicator" "ti" #'display-fill-column-indicator-mode)

(global-set-key (kbd "M-m") nil)
(global-set-key (kbd "M-m m") #'evil-multiedit-match-symbol-and-next)
(global-set-key (kbd "M-m p") #'evil-multiedit-match-symbol-and-prev)
(global-set-key (kbd "M-m a") #'evil-multiedit-match-all)
(global-set-key (kbd "M-m h") #'lsp-evil-multiedit-highlights)

;; set registers
(set-register ?l '(file . "~/org/ledger/ledger-2022.dat"))

;;;###autoload
(defun bk/bitwarden ()
  "Get bitwarden."
  (interactive)
  (kill-new (auth-source-pick-first-password
             :host "bitwarden.app"
             :user "bartuka")))

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

;; current theme
(enable-vim-colors)
