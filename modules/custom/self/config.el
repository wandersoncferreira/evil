;;; custom/self/config.el -*- lexical-binding: t; -*-

(setq user-full-name "Wanderson Ferreira"
      user-mail-address "wand@hey.com"

      ;; font
      doom-font (font-spec :size 14)

      ;; make doom increase font in smaller steps
      doom-font-increment 1

      ;; spc b x to create scratch buffers in elisp mode
      doom-scratch-initial-major-mode 'lisp-interaction-mode

      ;; initial major mode
      initial-major-mode 'lisp-interaction-mode

      initial-scratch-message "\
;; Here be evil dragons...
"

      ;; DO NOT display fixed line numbers in the left fringe
      display-line-numbers-type nil

      ;; when at the beginning of a line, make `ctrl-k' remove the whole
      ;; line, instead of just emptying it
      kill-whole-line t

      ;; change fringe width
      ;; remove default style of git-gutter-fringe to use thin fringe width
      +vc-gutter-default-style nil

      ;; do not ask me if I want to leave Emacs
      confirm-kill-emacs nil

      ;; prefer to use newer files always
      load-prefer-newer t

      ;; tab key is very useful in insert molde to fix identation or completion imho
      tab-always-indent 'complete

      ;; bring undo-* defaults back
      undo-limit 160000
      undo-strong-limit 240000
      undo-outer-limit 24000000)

;; disable management of mode-line by popups
(remove-hook '+popup-buffer-mode-hook #'+popup-set-modeline-on-enable-h)

;; change line spacing for all buffers
(setq-default line-spacing 6)

(map! :leader
      (:prefix "e"
       "s" #'eshell))
