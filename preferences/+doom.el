;;; $DOOMDIR/preferences/+doom.el -*- lexical-binding: t; -*-

(setq user-full-name "Wanderson Ferreira"
      user-mail-address "wand@hey.com"

      ;; font
      ;; systemfontstack.com
      doom-font (font-spec :size 13)

      ;; DO NOT display fixed line numbers in the left fringe
      display-line-numbers-type 'relative

      ;; where to find/add my org files?
      org-directory "~/org/"

      ;; change fringe width
      ;; remove default style of git-gutter-fringe to use thin fringe width
      +vc-gutter-default-style nil

      ;; do not ask me if I want to leave Emacs
      confirm-kill-emacs nil

      ;; dired tries to guess the default target directory
      dired-dwim-target t

      ;; prefer to use newer files always
      load-prefer-newer t

      ;; org return follow links
      org-return-follows-link t

      ;; tab key is very useful in insert molde to fix identation or completion imho
      tab-always-indent 'complete

      ;; bring undo-* defaults back
      undo-limit 160000
      undo-strong-limit 240000
      undo-outer-limit 24000000
      )

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

;;;###autoload
(defun insert-file-name ()
  "Insert the file name without extension."
  (interactive)
  (let ((path (or buffer-file-name default-directory)))
    (file-name-base buffer-file-name)))

(after! git-gutter
  (setq git-gutter:update-interval 0.3))

;; change frige width
(fringe-mode '(10 . 0))
