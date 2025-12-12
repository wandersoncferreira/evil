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
   cider-save-file-on-load t
   cider-mode-line '(:eval (format " cider[%s]" (bk/cider--modeline-info)))
   clojure-toplevel-inside-comment-form t))

(defadvice clojure-test-run-tests (before save-first activate)
  (save-buffer))

(defadvice nrepl-load-current-buffer (before save-first activate)
  (save-buffer))

;; fix the placement of the test-report buffer
(set-popup-rule! "*cider-test-report*" :side 'right :width 0.4)

;; fix the placement of the cider-repl buffer
(set-popup-rule! "^\\*cider-repl" :side 'bottom :quit nil)

(use-package! clj-refactor
  :after cider
  :init
  (setq cljr-eagerly-build-asts-on-startup nil
        cljr-warn-on-eval nil
        cljr-favor-private-functions nil)
  :bind
  (:map clojure-mode-map
        ("R e" . cljr-extract-function)
        ("R tf" . cljr-thread-first-all)))

(map! (:after (:and clojure-mode cider)
       :localleader
       (:map (clojure-mode-map)
             (:prefix ("r" . "refactor")
                      "f" #'cljr-extract-function
                      "ec" #'cljr-extract-constant
                      "ed" #'cljr-extract-def
                      "tf" #'clojure-thread-first-all
                      "tl" #'clojure-thread-last-all
                      "tu" #'clojure-unwind-all)
             (:prefix ("e" . "eval")
                      "v" #'cider-eval-sexp-at-point
                      "s" #'yas-expand
                      ";" #'cider-eval-defun-to-comment))))
