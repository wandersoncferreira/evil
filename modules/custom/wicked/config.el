;;; custom/wicked/config.el -*- lexical-binding: t; -*-

;; fix issue with ] and [ markers in Evil
;; more details https://discourse.doomemacs.org/t/how-to-fix-marker-is-not-set-in-this-buffer/2603/2
(defun bk/bring-marker-back-on-yank (&rest _)
  (evil-set-marker ?\[ (point))
  (evil-set-marker ?\] (1- (point))))

(after! evil

  (setq evil-mode-line-format 'before)

  ;; defaults like Vim, c-i jumps forward in the jump list
  (setq evil-want-C-i-jump t)

  ;; defaults like Vim, yank to whole line
  (setq evil-want-Y-yank-to-eol nil)

  ;; make evil start in emacs state for magit commit buffers
  (add-hook 'git-commit-mode-hook 'evil-insert-state)

  ;; fix issue with ] and [ markers
  (advice-add #'evil-yank :before #'bk/bring-marker-back-on-yank))

;; keep the underscore as a word character like in Vim
(after! clojure-mode
  (add-hook 'clojure-mode-hook (lambda () (modify-syntax-entry ?_ "w"))))

;; enable evil in the minibuffer
(after! evil-collection
  (setq evil-collection-setup-minibuffer t))
