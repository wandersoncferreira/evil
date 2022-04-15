;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq user-full-name "Wanderson Ferreira"
      user-mail-address "wand@hey.com"
      ;; theme - I'm a huge fan of the default theme
      doom-theme nil
      ;; font
      doom-font (font-spec :family "Monaco" :size 12)
      ;; DO NOT display fixed line numbers in the left fringe
      display-line-numbers-type nil
      ;; where to find/add my org files?
      org-directory "~/org/"
      ;; do not ask me if I want to leave Emacs
      confirm-kill-emacs nil
      ;; dired tries to guess the default target directory
      dired-dwim-target t
      ;; search for typed word in all visible windows
      avy-all-windows t
      ;; change line spacing for all buffers
      line-spacing 3
      ;; tab key is very useful in insert molde to fix identation or completion imho
      tab-always-indent 'complete)

;; disable highliting of current line
(remove-hook 'doom-first-buffer-hook 'global-hl-line-mode)

;; disable aesthetic plugin for fancier bullets
(remove-hook 'org-mode-hook #'org-superstar-mode)

;; I don't want to group directories first in direct buffers, then use the original default value
(setq-default dired-listing-switches "-al")

;; start emacs maximized
(add-to-list 'initial-frame-alist '(fullscreen . maximized))

(use-package! smartparens
  :init
  (add-hook 'smartparens-enabled-hook #'evil-smartparens-mode)
  :config
  ;; fix bugs with smartparens and unbalanced pairs
  (dolist (brace '("(" "{" "[" "'" "\""))
    (sp-pair brace nil :unless nil))
  :hook ((clojure-mode . smartparens-strict-mode)
         (emacs-lisp-mode . smartparens-strict-mode)))

;;; vertico and consult
;; disable the default preview when switching buffers
(setq consult-preview-key (kbd "M-."))

;;; clojure setup
(use-package! cider
  :init
  (setq cider-jdk-src-paths '("~/Downloads/clojure-1.10.3-sources" "~/Downloads/jvm11/source")
        cider-clojure-cli-command "~/code/dotfiles/clojure/clojure-bin-enriched"
        cider-save-file-on-load t
        clojure-toplevel-inside-comment-form t
        cider-use-xref nil ;; use lsp
        )
  :config
  ;; remove the colors in the parens, I'm boring person
  (remove-hook 'clojure-mode-hook #'rainbow-delimiters-mode)
  ;; use lsp for completion
  (add-hook 'cider-mode-hook (lambda ()
                               (remove-hook 'completion-at-point-functions #'cider-complete-at-point))))

;; remove highlighting of the parens...
(after! elisp-mode
  (remove-hook 'emacs-lisp-mode-hook #'rainbow-delimiters-mode))

;; setup encryption
(require 'epa)
(require 'auth-source)

(setq epg-gpg-program "gpg"
      password-cache-expiry nil
      auth-sources (nreverse auth-sources)
      auth-source-cache-expiry nil
      epa-file-encrypt-to '("wand@hey.com"))

(set 'epg-pinentry-mode nil)

;; loading extra functions
(load! "+functions")
(load! "+bindings")

;; setup cisco configs
(add-hook 'after-init-hook
          (lambda ()
            (load-file (expand-file-name "+cisco.el.gpg" doom-private-dir))
            (require '+cisco)))

;; setup lsp
(use-package! lsp-mode
  :commands lsp
  :config
  (setq lsp-idle-delay 0.3
        lsp-completion-no-cache t
        lsp-completion-use-last-result nil))
