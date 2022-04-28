;;; $DOOMDIR/preferences/+completion.el -*- lexical-binding: t; -*-

;;; consult
;; disable the default preview when switching buffers
(setq consult-preview-key (kbd "M-."))

;;; embark
;; add functions to open new file in vertical or horizontal splits
(defun bk/vsplit-file-open (f)
  (let ((evil-vsplit-window-right t))
    (+evil/window-vsplit-and-follow)
    (find-file f)))

(defun bk/split-file-open (f)
  (let ((evil-split-window-below t))
    (+evil/window-split-and-follow)
    (find-file f)))

(map! :after embark
      :map embark-file-map
      "v" #'bk/vsplit-file-open
      "x" #'bk/split-file-open)

;; do not ask for confirmation to delete a bookmark
(setf embark-pre-action-hooks
      (assoc-delete-all
       'bookmark-delete
       embark-pre-action-hooks))

;;; vertico
;; restore some vim balance
;; if you want to type  [ or ] in the minibuffer use C-q [ or ]
(map! :n "[I" #'+vertico/search-symbol-at-point
      :map vertico-map
      "]" #'vertico-next-group
      "[" #'vertico-previous-group)

;;; company
;; disable automatic completion
(after! company
  (setq company-idle-delay nil))
