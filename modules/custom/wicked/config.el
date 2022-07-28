;;; custom/wicked/config.el -*- lexical-binding: t; -*-

;; fix issue with ] and [ markers in Evil
;; https://discourse.doomemacs.org/t/how-to-fix-marker-is-not-set-in-this-buffer/2603/2
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

  ;; fix issue with ] and [ markers
  (advice-add #'evil-yank :before #'bk/bring-marker-back-on-yank))

;; enable evil in the minibuffer
(after! evil-collection
  (setq evil-collection-setup-minibuffer t))

;; TIL:
;; [ SPC -- insert newline above
;; ] SPC -- insert newline below
;; this is provided by unimpared.vim plugin if you were in Vim land
