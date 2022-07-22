;;; custom/wicked/config.el -*- lexical-binding: t; -*-

;; fix issue with ] and [ markers in Evil
;; more details https://discourse.doomemacs.org/t/how-to-fix-marker-is-not-set-in-this-buffer/2603/2
(defun bk/bring-marker-back-on-yank (&rest _)
  (evil-set-marker ?\[ (point))
  (evil-set-marker ?\] (1- (point))))

(after! evil

  ;; remove mode indicator from the modeline
  (setq evil-mode-line-format nil)

  ;; defaults like Vim, c-i jumps forward in the jump list
  (setq evil-want-C-i-jump t)

  ;; defaults like Vim, yank to whole line
  (setq evil-want-Y-yank-to-eol nil)

  ;; make evil start in emacs state for magit commit buffers
  (add-hook 'git-commit-mode-hook 'evil-insert-state)

  ;; fix issue with ] and [ markers
  (advice-add #'evil-yank :before #'bk/bring-marker-back-on-yank)

  ;; disable evil in world-clock mode
  (add-hook 'world-clock-mode-hook #'turn-off-evil-mode)

  )

;; keep the underscore as a word character like in Vim
(after! clojure-mode
  (add-hook 'clojure-mode-hook (lambda () (modify-syntax-entry ?_ "w"))))

;; enable evil in the minibuffer
(after! evil-collection
  (setq evil-collection-setup-minibuffer t))

(defun add-line-below-on-normal-mode ()
  (interactive)
  (save-excursion
    (evil-open-below 1)
    (evil-normal-state)))

(defun add-line-above-on-normal-mode ()
  (interactive)
  (save-excursion
    (evil-open-above 1)
    (evil-normal-state)))

(map!
 :n "go" #'add-line-below-on-normal-mode
 :n "gO" #'add-line-above-on-normal-mode
 )
