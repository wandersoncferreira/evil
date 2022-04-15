;;; ../code/evil/+evil.el -*- lexical-binding: t; -*-

;; I want to keep Evil-mode as close to Vim as possible

(setq
 ;; defaults like Vim, c-i jumps forward in the jump list
 evil-want-C-i-jump t
 ;; defaults like Vim, yank to whole line
 evil-want-Y-yank-to-eol nil)

;; keep the underscore as a word character like in Vim
(add-hook 'clojure-mode-hook
          (lambda ()
            (modify-syntax-entry ?_ "w")))
