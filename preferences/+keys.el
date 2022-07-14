;;; $DOOMDIR/preferences/+doom.el -*- lexical-binding: t; -*-

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
