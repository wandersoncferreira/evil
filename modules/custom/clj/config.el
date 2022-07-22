;;; custom/clj/config.el -*- lexical-binding: t; -*-

(when (featurep! +lsp)
  (after! cider
    (setq cider-font-lock-dynamically nil
          cider-use-xref nil)

    ;; prefer lsp over cider in completion
    (add-hook 'cider-mode-hook
              (lambda ()
                (remove-hook 'completion-at-point-functions
                             #'cider-complete-at-point))))

  (after! lsp-mode
    (setq lsp-semantic-tokens-enable nil
          lsp-file-watch-threshold nil
          lsp-enable-file-watchers nil
          lsp-modeline-diagnostics-enable nil
          lsp-idle-delay 0.2)))

(use-package! cider
  :init
  (setq cider-jdk-src-paths '("~/Downloads/clojure-1.10.3-sources" "~/Downloads/jvm11/source")
        cider-clojure-cli-command "~/code/dotfiles/clojure/clojure-bin-enriched"
        ;; only jump to errors
        cider-auto-jump-to-error 'errors-only
        cider-save-file-on-load t
        cider-mode-line '(:eval (format " cider[%s]" (bk/cider--modeline-info)))
        clojure-toplevel-inside-comment-form t)
  :config

  (set-lookup-handlers! '(cider-mode cider-repl-mode) nil)

  ;; remove the colors in the parens, I'm boring person
  (remove-hook 'clojure-mode-hook #'rainbow-delimiters-mode)

  (add-hook 'cider-repl-mode-hook
            (lambda ()
              ;; include cider buffer into current workspace
              (persp-add-buffer (current-buffer))))

  (add-hook 'cider-test-report-mode-hook
            (lambda ()
              ;; include test-report buffer into current workspace
              (persp-add-buffer (current-buffer))))

  (add-hook 'cider-popup-buffer-mode-hook
            (lambda ()
              ;; include temp buffers created by cider into current workspace
              (persp-add-buffer (current-buffer))))

  ;; fix the placement of the test-report buffer
  (set-popup-rule! "*cider-test-report*" :side 'right :width 0.4)

  ;; fix the placement of the cider-repl buffer
  (set-popup-rule! "^\\*cider-repl" :side 'bottom :quit nil))

(use-package! clj-refactor
  :after clojure-mode
  :config
  (set-lookup-handlers! 'clj-refactor-mode nil)
  (setq cljr-eagerly-build-asts-on-startup nil
        cljr-add-ns-to-blank-clj-files nil))

(map! (:localleader
       (:map (clojure-mode-map)
        (:prefix ("r" . "repl")
         "s" #'sesman-browser)
        (:prefix ("e" . "eval")
         "v" #'cider-eval-sexp-at-point
         ";" #'cider-eval-defun-to-comment))))
