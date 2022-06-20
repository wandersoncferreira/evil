;;; $DOOMDIR/preferences/+coding.el -*- lexical-binding: t; -*-

(defun toggle/flycheck-list-errors ()
  "Toggle flycheck list errors buffer."
  (interactive)
  (let ((buff (get-buffer "*Flycheck errors*")))
    (if buff
        (kill-buffer buff)
      (flycheck-list-errors))))

(map! :leader
      "fe" #'toggle/flycheck-list-errors)

(use-package! evil-cleverparens
  :init
  (setq evil-cleverparens-use-additional-movement-keys nil
        evil-cleverparens-use-additional-bindings nil
        evil-cleverparens-use-s-and-S nil))
