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

;; add lookup definition to jump list
(evil-add-command-properties #'+lookup/definition :jump t)

;; fix split and follow functions to press RET automatically
(defun org/window-split-and-follow ()
  "Split current window horizontally, then focus new window.
If `evil-split-window-below' is non-nil, the new window isn't focused."
  (interactive)
  (let ((evil-split-window-below (not evil-split-window-below)))
    (call-interactively #'evil-window-split)
    (call-interactively #'+org/dwim-at-point)))

(defun org/window-vsplit-and-follow ()
  "Split current window vertically, then focus new window.
If `evil-vsplit-window-right' is non-nil, the new window isn't focused."
  (interactive)
  (let ((evil-vsplit-window-right (not evil-vsplit-window-right)))
    (call-interactively #'evil-window-vsplit)
    (call-interactively #'+org/dwim-at-point)))

(map! (:map org-mode-map
            :n "wS" #'org/window-split-and-follow
            :n "wV" #'org/window-vsplit-and-follow))
