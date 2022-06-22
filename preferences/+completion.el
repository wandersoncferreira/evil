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
  (setq vertico-count 10)
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
      (add-text-properties (minibuffer-prompt-end) (point-max)
                           '(invisible t read-only t cursor-intangible t rear-nonsticky t))))

  (map! :map vertico-map
        "s-SPC" #'+vertico-restrict-to-matches)

  ;;; extensions
  ;; 1. using the whole buffer to display project-wide searches via `SPC-/'
  (vertico-multiform-mode +1)

  (setq vertico-multiform-categories
        '((consult-grep buffer)))

  (setq vertico-multiform-commands
        '((consult-imenu buffer)
          (+default/search-project buffer)))

  (set-popup-rule! "*vertico*" :side 'right :width 0.6))

;;; company
(use-package! company
  :config
  (setq company-tooltip-align-annotations t
        company-frontends '(company-pseudo-tooltip-frontend)))

(use-package! company-quickhelp
  :init
  (company-quickhelp-mode)
  :config
  (setq company-quickhelp-delay nil
        company-quickhelp-use-propertized-text t
        company-quickhelp-max-lines 10))

(map! :map company-active-map
      "C-h" #'company-quickhelp-manual-begin
      "M-h" #'company-show-doc-buffer)
