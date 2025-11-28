;;; custom/clj/config.el -*- lexical-binding: t; -*-

(use-package! clojure-mode
  :defer t
  :config
  ;; keep the underscore as a word character like in Vim
  (add-hook! 'clojure-mode-hook
    (modify-syntax-entry ?_ "w"))

  ;; change evil-args delimiters
  (add-hook! 'clojure-mode-hook
    (setq-local evil-args-delimiters '(" "))))

(use-package! cider
  :defer t
  :init
  (setq ;; automatically download all available .jars with Java sources
   cider-auto-jump-to-error 'errors-only
   cider-show-error-buffer t ;; only-in-repl
   cider-font-lock-dynamically nil ;; use lsp semantic tokens
   cider-eldoc-display-for-symbol-at-point nil ;; use lsp
   cider-prompt-for-symbol nil
   cider-reuse-dead-repls nil
   cider-use-xref nil ;; use lsp
   cider-save-file-on-load t
   cider-mode-line '(:eval (format " cider[%s]" (bk/cider--modeline-info)))
   clojure-toplevel-inside-comment-form t))

;;use lsp completion
(add-hook! 'cider-mode-hook
  (remove-hook 'completion-at-point-functions #'cider-complete-at-point))

(defadvice clojure-test-run-tests (before save-first activate)
  (save-buffer))

(defadvice nrepl-load-current-buffer (before save-first activate)
  (save-buffer))

;; fix the placement of the test-report buffer
(set-popup-rule! "*cider-test-report*" :side 'right :width 0.4)

;; fix the placement of the cider-repl buffer
(set-popup-rule! "^\\*cider-repl" :side 'bottom :quit nil)

(use-package! clj-refactor
  :defer t
  :init
  (setq cljr-eagerly-build-asts-on-startup nil
        cljr-warn-on-eval nil
        cljr-add-ns-to-blank-clj-files nil ;; use lsp
        cljr-favor-private-functions nil))

(use-package! lsp-mode
  :commands lsp
  :config
  ;; clojure
  (setq lsp-completion-no-cache t
        lsp-semantic-tokens-enable t
        lsp-enable-file-watchers nil
        lsp-completion-use-last-result nil))

(map! (:after (:and clojure-mode cider)
       :localleader
       (:map (clojure-mode-map)
             (:prefix ("r" . "repl")
                      "s" #'sesman-browser)
             (:prefix ("e" . "eval")
                      "v" #'cider-eval-sexp-at-point
                      "s" #'yas-expand
                      ";" #'cider-eval-defun-to-comment))))

;; AI
;; (after! mcp
;;   (add-to-list 'mcp-hub-servers '("iroh" :command "clojure-mcp" :args ("iroh"))))
