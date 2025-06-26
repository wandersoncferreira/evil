;;; custom/self/config.el -*- lexical-binding: t; -*-

(setq user-full-name "Wanderson Ferreira"
      user-mail-address "wand@hey.com"

      ;; initial major mode
      initial-major-mode 'lisp-interaction-mode

      ;; when at the beginning of a line, make `ctrl-k' remove the whole
      ;; line, instead of just emptying it
      kill-whole-line t

      ;; do not ask me if I want to leave Emacs
      confirm-kill-emacs nil

      warning-minimum-level :error

      ;; prefer to use newer files always
      load-prefer-newer t

      ;; bring undo-* defaults back
      undo-limit 160000
      undo-strong-limit 240000
      undo-outer-limit 24000000)

;; disable management of mode-line by popups
(remove-hook '+popup-buffer-mode-hook #'+popup-set-modeline-on-enable-h)

(map! :leader (:prefix "e" "s" #'eshell))

;; disable yas-snippet globally
;; in fact, I wanted to remove (:editor snippets) from init.el
;; but the clojure module depends on it...
;; EDIT: 28/02/2024 - let me try to use this again!
;; (add-hook 'after-init-hook (lambda () (yas-global-mode -1)))

;; (after! spell-fu
;;   ;; TODO workround for https://github.com/doomemacs/doomemacs/issues/6246
;;   (unless (file-exists-p ispell-personal-dictionary)
;;     (make-directory (file-name-directory ispell-personal-dictionary) t)
;;     (with-temp-file ispell-personal-dictionary
;;       (insert (format "personal_ws-1.1 %s 0\n" ispell-dictionary)))))


(use-package! jinx
  :hook (org-mode . jinx-mode)
  :config
  (setq jinx-languages "pt_BR en_US"
        jinx-delay 1.0)
  (nconc (cadr jinx-exclude-faces) '(org-ref-ref-face))
  (map! :map evil-normal-state-map
        "z g" #'jinx-correct
        "z n" #'jinx-next))

(after! vertico-multiform
  (add-to-list 'vertico-multiform-categories
               '(jinx (vertico-grid-annotate . 25)))
  (vertico-multiform-mode 1))
