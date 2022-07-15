;;; custom/wicked/config.el -*- lexical-binding: t; -*-

(setq evil-mode-line-format 'before)

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

;; enable evil in the minibuffer
(after! evil-collection
  (setq evil-collection-setup-minibuffer t))