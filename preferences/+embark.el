;;; $DOOMDIR/preferences/+embark.el -*- lexical-binding: t; -*-

(defun bk/vsplit-file-open (f)
  (let ((evil-vsplit-window-right t))
    (+evil/window-vsplit-and-follow)
    (find-file f)))

(defun bk/split-file-open (f)
  (let ((evil-split-window-below t))
    (+evil/window-split-and-follow)
    (find-file f)))

(map! :after embark
      :map embark-file-map
      "v" #'bk/vsplit-file-open
      "x" #'bk/split-file-open)
