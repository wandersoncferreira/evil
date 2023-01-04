;;; custom/completions/config.el -*- lexical-binding: t; -*-

;;; consult
;; disable the default preview when switching buffers
(after! consult
  (setq consult-preview-key (kbd "M-.")))

;;; embark
;; do not ask for confirmation to delete a bookmark
(after! embark
  (setf embark-pre-action-hooks
        (assoc-delete-all
         'bookmark-delete
         embark-pre-action-hooks)))

(use-package! vertico
  :init
  (setq vertico-count-format nil
        vertico-cycle nil
        ;; keep cursor always at mid-height when scrolling..
        ;; bottom of screen is unecessary head movement
        vertico-scroll-margin 10)
  :config
  ;; restore some vim balance
  ;; if you want to type  [ or ] in the minibuffer use C-q [ or ]
  (map! :n "[I" #'+vertico/search-symbol-at-point
        :map vertico-map
        "]" #'vertico-next-group
        "[" #'vertico-previous-group))

(after! company
  (setq company-idle-delay nil))
