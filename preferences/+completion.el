;;; $DOOMDIR/preferences/+completion.el -*- lexical-binding: t; -*-

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

(after! vertico
  (setq vertico-count-format nil
        vertico-cycle nil
        ;; keep cursor always at mid-height when scrolling..
        ;; bottom of screen is unecessary head movement
        vertico-scroll-margin 10)

  ;; let's make a test and only sort functions by history and alphabetically
  (setq vertico-sort-function #'vertico-sort-history-alpha)

  ;; restore some vim balance
  ;; if you want to type  [ or ] in the minibuffer use C-q [ or ]
  (map! :n "[I" #'+vertico/search-symbol-at-point
        :map vertico-map
        "]" #'vertico-next-group
        "[" #'vertico-previous-group)

  ;;; restrict the set of candidates
  (defun +vertico-restrict-to-matches ()
    (interactive)
    (let ((inhibit-read-only t))
      (goto-char (point-max))
      (insert " ")
      (add-text-properties
       (minibuffer-prompt-end) (point-max)
       '(invisible t read-only t cursor-intangible t rear-nonsticky t))))

  (map! :map vertico-map
        "s-SPC" #'+vertico-restrict-to-matches))

;;; corfu
(use-package! corfu
  :init
  (setq corfu-auto t
        corfu-auto-delay 0.1
        corfu-separator ?&)
  :config
  (global-corfu-mode))

;; do not truncate lines in the minibuffer
(add-hook 'minibuffer-setup-hook
          (lambda ()
            (setq-local truncate-lines nil)))
