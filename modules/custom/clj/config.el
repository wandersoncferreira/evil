;;; custom/clj/config.el -*- lexical-binding: t; -*-

(use-package! clojure-mode
  :config
  ;; keep the underscore as a word character like in Vim
  (add-hook 'clojure-mode-hook
            (lambda ()
              (modify-syntax-entry ?_ "w")))

  ;; change evil-args delimiters
  (add-hook 'clojure-mode-hook
            (lambda ()
              (setq-local evil-args-delimiters '(" ")))))

(use-package! cider
  :init
  (setq ;; automatically download all available .jars with Java sources
        ;; and javadocs - allowing you to navigate to Java sources and
        ;; javadocs in your Clojure projects
        cider-enrich-classpath t
        ;; only jump to errors
        cider-auto-jump-to-error 'errors-only
        cider-save-file-on-load t
        cider-mode-line '(:eval (format " cider[%s]" (bk/cider--modeline-info)))
        clojure-toplevel-inside-comment-form t)

  (defadvice clojure-test-run-tests (before save-first activate)
    (save-buffer))

  (defadvice nrepl-load-current-buffer (before save-first activate)
    (save-buffer))

  ;; add buffer to current persp
  (dolist (it '(cider-repl-mode-hook
                cider-test-report-mode-hook
                cider-popup-buffer-mode-hook))
    (add-hook it (lambda ()
                   (persp-add-buffer (current-buffer)))))

  ;; fix the placement of the test-report buffer
  (set-popup-rule! "*cider-test-report*" :side 'right :width 0.4)

  ;; fix the placement of the cider-repl buffer
  (set-popup-rule! "^\\*cider-repl" :side 'bottom :quit nil))

(use-package! clj-refactor
  :init
  (setq cljr-eagerly-build-asts-on-startup nil
        cljr-add-ns-to-blank-clj-files nil
        cljr-favor-private-functions nil))

(map! (:after (:and clojure-mode cider)
       :localleader
       (:map (clojure-mode-map)
        (:prefix ("r" . "repl")
         "s" #'sesman-browser)
        (:prefix ("e" . "eval")
         "v" #'cider-eval-sexp-at-point
         ";" #'cider-eval-defun-to-comment))))
