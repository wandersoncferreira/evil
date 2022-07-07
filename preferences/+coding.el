;;; $DOOMDIR/preferences/+coding.el -*- lexical-binding: t; -*-

(defun toggle/flycheck-list-errors ()
  "Toggle flycheck list errors buffer."
  (interactive)
  (let ((buff (get-buffer "*Flycheck errors*")))
    (if buff
        (kill-buffer buff)
      (flycheck-list-errors))))

(map! :leader
      :desc "Toggle list errors" "fe" #'toggle/flycheck-list-errors
      :desc "Check buffer syntax" "fb" #'flycheck-buffer)

(use-package! evil-cleverparens
  :init
  (setq evil-cleverparens-use-additional-movement-keys nil
        evil-cleverparens-use-additional-bindings nil
        evil-cleverparens-use-s-and-S nil))

(after! flycheck
  ;; uses `flycheck-buffer' manually to check syntax
  (setq flycheck-check-syntax-automatically nil))

(after! ws-butler
  ;; include org mode too
  (setq ws-butler-global-exempt-modes
        '(special-mode
          comint-mode
          diff-mode
          eshell-mode
          markdown-mode
          org-mode)))
