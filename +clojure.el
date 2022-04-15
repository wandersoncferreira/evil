;;; ../code/evil/+clojure.el -*- lexical-binding: t; -*-

(use-package! cider
  :init
  (setq cider-jdk-src-paths '("~/Downloads/clojure-1.10.3-sources" "~/Downloads/jvm11/source")
        cider-clojure-cli-command "~/code/dotfiles/clojure/clojure-bin-enriched"
        cider-save-file-on-load t
        cider-use-xref nil ;; use lsp
        clojure-toplevel-inside-comment-form t)
  :config
  ;; remove the colors in the parens, I'm boring person
  (remove-hook 'clojure-mode-hook #'rainbow-delimiters-mode)

  ;; use lsp for completion
  (add-hook 'cider-mode-hook
            (lambda ()
              (remove-hook 'completion-at-point-functions #'cider-complete-at-point))))
