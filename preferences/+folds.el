;;; $DOOMDIR/preferences/+folds.el -*- lexical-binding: t; -*-

(defun bk/toggle-fold ()
  (interactive)
  (if (and (boundp 'vimish-fold-mode) vimish-fold-mode)
      (turn-off-evil-vimish-fold-mode)
    (turn-on-evil-vimish-fold-mode)))

(map! :leader
      :desc "zFold" "tz" #'bk/toggle-fold)
