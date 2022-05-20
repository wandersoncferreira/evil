;;; $DOOMDIR/preferences/+evil-gym.el -*- lexical-binding: t; -*-

;;; build muscle memory within some annoying walls
(add-hook 'after-init-hook #'global-evil-motion-trainer-mode)

(after! evil-motion-trainer
  (setq evil-motion-trainer-super-annoying-mode nil
        evil-motion-trainer-threshold 6)
  ;; add new advice
  (add-emt-advice sp-backward-delete-char '(sp-backward-kill-word)))
