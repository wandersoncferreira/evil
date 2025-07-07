;;; custom/completions/config.el -*- lexical-binding: t; -*-

;; tab key is very useful in insert mode to fix identation or completion imho
(setq tab-always-indent 'complete)

;;; consult
;; disable the default preview when switching buffers
(after! consult
  (setq consult-preview-key "M-."))

(use-package! embark
  :bind
  ("C-." . embark-act)
  (:map completion-list-mode-map
        ("." . embark-act))
  (:map embark-collect-mode-map
        ("." . embark-act))
  ;; :custom
  ;; (embark-quit-after-action nil)
  ;; (embark-indicators '(embark-minimal-indicator
  ;;                      embark-highlight-indicator
  ;;                      embark-isearch-highlight-indicator))
  ;; (embark-cycle-key ".")
  ;; (embark-help-key "?")
  )

(use-package embark-consult
  :demand t)

(use-package! vertico
  :config
  ;; restore some vim balance
  ;; if you want to type  [ or ] in the minibuffer use C-q [ or ]
  (map! :n "[I" #'+vertico/search-symbol-at-point
        :map vertico-map
        "]" #'vertico-next-group
        "[" #'vertico-previous-group)

  (vertico-multiform-mode 1))
