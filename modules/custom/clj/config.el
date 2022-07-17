;;; custom/clj/config.el -*- lexical-binding: t; -*-

(use-package! cider
  :init
  (setq cider-jdk-src-paths '("~/Downloads/clojure-1.10.3-sources" "~/Downloads/jvm11/source")
        cider-clojure-cli-command "~/code/dotfiles/clojure/clojure-bin-enriched"
        ;; only jump to errors
        cider-auto-jump-to-error 'errors-only
        cider-save-file-on-load t
        cider-mode-line '(:eval (format " cider[%s]" (bk/cider--modeline-info)))
        clojure-toplevel-inside-comment-form t
        ;;; prefer lsp over cider
        ;; semantic tokens
        cider-font-lock-dynamically nil
        ;; completion system
        cider-use-xref nil)
  :config
  ;;; prefer lsp over cider
  ;; remove completion hooks
  (add-hook 'cider-mode-hook
            (lambda ()
              (remove-hook 'completion-at-point-functions
                           #'cider-complete-at-point)))

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