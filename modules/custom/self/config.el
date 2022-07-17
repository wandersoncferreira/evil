;;; custom/self/config.el -*- lexical-binding: t; -*-

(setq user-full-name "Wanderson Ferreira"
      user-mail-address "wand@hey.com"

      ;; font
      ;; systemfontstack.com
      doom-font (font-spec :size 12)

      ;; DO NOT display fixed line numbers in the left fringe
      display-line-numbers-type nil

      ;; when at the beginning of a line, make `ctrl-k' remove the whole
      ;; line, instead of just emptying it
      kill-whole-line t

      ;; where to find/add my org files?
      org-directory "~/org/"

      ;; change fringe width
      ;; remove default style of git-gutter-fringe to use thin fringe width
      +vc-gutter-default-style nil

      ;; do not ask me if I want to leave Emacs
      confirm-kill-emacs nil

      ;; dired tries to guess the default target directory
      dired-dwim-target t

      ;; prefer to use newer files always
      load-prefer-newer t

      ;; org return follow links
      org-return-follows-link t

      ;; tab key is very useful in insert molde to fix identation or completion imho
      tab-always-indent 'complete

      ;; bring undo-* defaults back
      undo-limit 160000
      undo-strong-limit 240000
      undo-outer-limit 24000000
      )

;; change line spacing for all buffers
(setq-default line-spacing 6)

;; do not show which-key if not explicitly asked
(setq which-key-show-early-on-C-h t
      which-key-idle-delay 10000
      which-key-idle-secondary-delay 0.05)

;; DO NOT group directories first
(after! dired
  (setq dired-listing-switches "-alh"))
