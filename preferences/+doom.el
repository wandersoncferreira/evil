;;; $DOOMDIR/preferences/+doom.el -*- lexical-binding: t; -*-

(setq user-full-name "Wanderson Ferreira"
      user-mail-address "wand@hey.com"

      ;; font
      ;; systemfontstack.com
      doom-font (font-spec :size 12)

      ;; DO NOT display fixed line numbers in the left fringe
      display-line-numbers-type nil

      ;; when at the beginning of a line, make `ctrl-k' remove the whole
      ;; line, instead of just emptying it
      kill-whole-line t

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

;;;###autoload
(defun insert-file-name ()
  "Insert the file name without extension."
  (interactive)
  (let ((path (or buffer-file-name default-directory)))
    (file-name-base buffer-file-name)))

(after! git-gutter
  (setq git-gutter:update-interval 0.3))

;; do not show which-key if not explicitly asked
(setq which-key-show-early-on-C-h t
      which-key-idle-delay 10000
      which-key-idle-secondary-delay 0.05)

;; disabling bindings
(map! :leader
      "." nil ;; find file -- i'm always in projects `spc spc'
      "<" nil ;; switch buffer also `spc b b'
      "`" nil ;; switch to last buffer also `spc b l'
      "x" nil ;; popup to scratch buffer
      "X" nil ;; org capture .. TODO: config my org mode settings
      ":" nil ;; remapped below to `x' - avoid one extra key press
      "," nil ;; seems that by default switch buffer filters per workspace
      :desc "M-x" "x" #'execute-extended-command
      "w+" nil ;; I'll never increase the height of a window like this
      "w-" nil ;; I'll never decrease the height of a window like this
      "w<" nil ;; I'll never decrease the width of a window like this
      "w>" nil ;; I'll never increase the width of a window like this
      "w_" nil ;; set-height such a weird function
      "wc" nil ;; `spc w d' is enough to delete the window
      "wn" nil ;; evil-window-new .. useless?
      "wq" nil ;; what? evil-quit close emacs for good :/
      "w|" nil ;; evil-set-window .. :/
      )

;; disable keys using ctrl in the window cluster
(map! :map evil-window-map
      "C-h" nil "C-u" nil
      "C-j" nil "C-v" nil
      "C-k" nil "C-s" nil
      "C-l" nil "C-p" nil
      "C-w" nil "C-S-s" nil
      "C-_" nil "C-S-r" nil
      "C-o" nil "C-b" nil
      "C-n" nil "C-c" nil
      )
