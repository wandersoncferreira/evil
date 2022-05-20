;;; $DOOMDIR/preferences/+evil.el -*- lexical-binding: t; -*-
;;; I want to keep Evil-mode as close to Vim as possible

;; defaults like Vim, c-i jumps forward in the jump list
(setq evil-want-C-i-jump t)

;; defaults like Vim, yank to whole line
(setq evil-want-Y-yank-to-eol nil)

;; keep the underscore as a word character like in Vim
(add-hook 'clojure-mode-hook (lambda () (modify-syntax-entry ?_ "w")))

;; fix issue with ] and [ markers in Evil
;; more details https://discourse.doomemacs.org/t/how-to-fix-marker-is-not-set-in-this-buffer/2603/2
(defun bk/bring-marker-back-on-yank (&rest _)
  (evil-set-marker ?\[ (point))
  (evil-set-marker ?\] (1- (point))))

(advice-add #'evil-yank :before #'bk/bring-marker-back-on-yank)
