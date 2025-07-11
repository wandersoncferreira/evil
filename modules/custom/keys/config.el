;;; custom/keys/config.el -*- lexical-binding: t; -*-

;; let's try embark instead of which-key
(setq prefix-help-command #'embark-prefix-help-command)

(after! vertico-multiform
  (add-to-list 'vertico-multiform-categories
               '(embark-keybinding grid)))

(map! :leader
      "y" #'consult-yank-from-kill-ring
      :desc "CamelCase" "tc" #'subword-mode
      :desc "Column Indicator" "ti" #'display-fill-column-indicator-mode
      :desc "jump to register" "rr" #'jump-to-register)

;; set registers
(set-register ?c '(file . "~/.doom.d/docs/doom-cheatsheet.org"))

(defun bk/insert-cedilha ()
  (interactive)
  (evil-append 1)
  (insert "ç")
  (evil-append 1))

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
      "C-n" nil "C-c" nil)

;; add cedilha in insert mode
(evil-define-key 'insert global-map (kbd "C-,") #'bk/insert-cedilha)
