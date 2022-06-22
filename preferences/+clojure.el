;;; $DOOMDIR/preferences/+clojure.el -*- lexical-binding: t; -*-

;;;###autoload
(defun bk/cider--modeline-info ()
  "I'd like to see only cider[connected:port] or cider[not connected]"
  (if-let* ((current-connection (ignore-errors (cider-current-repl))))
      (with-current-buffer current-connection
        (concat
         (symbol-name cider-repl-type)
         (when cider-mode-line-show-connection
           (format ":connected:%s" (plist-get nrepl-endpoint :port)))))
    "not connected"))

(use-package! cider
  :init
  (setq cider-jdk-src-paths '("~/Downloads/clojure-1.10.3-sources" "~/Downloads/jvm11/source")
        cider-clojure-cli-command "~/code/dotfiles/clojure/clojure-bin-enriched"
        cider-save-file-on-load t
        cider-mode-line '(:eval (format " cider[%s]" (bk/cider--modeline-info)))
        clojure-toplevel-inside-comment-form t)
  :config
  ;; handling parens correctly
  (add-hook 'clojure-mode-hook
            (lambda ()
              (evil-cleverparens-mode)
              (evil-smartparens-mode)))

  ;; remove the colors in the parens, I'm boring person
  (remove-hook 'clojure-mode-hook #'rainbow-delimiters-mode)

  ;; include cider buffer into current workspace
  (add-hook 'cider-repl-mode-hook
            (lambda ()
              (persp-add-buffer (current-buffer))))

  ;; include test-report buffer into current workspace
  (add-hook 'cider-test-report-mode-hook
            (lambda ()
              (persp-add-buffer (current-buffer))))

  ;; include temp buffers created by cider into current workspace
  (add-hook 'cider-popup-buffer-mode-hook
            (lambda ()
              (persp-add-buffer (current-buffer))))

  ;; fix the placement of the test-report buffer
  (set-popup-rule! "*cider-test-report*" :side 'right :width 0.4)
  )

(map! (:localleader
       (:map (clojure-mode-map)
        (:prefix ("r" . "repl")
         "s" #'sesman-browser)
        (:prefix ("e" . "eval")
         "v" #'cider-eval-sexp-at-point
         ";" #'cider-eval-defun-to-comment))))
