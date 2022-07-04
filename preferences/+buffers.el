;;; $DOOMDIR/preferences/+buffers.el -*- lexical-binding: t; -*-

(defun iwb ()
  "Indent whole buffer."
  (interactive)
  (delete-trailing-whitespace)
  (indent-region (point-min) (point-max) nil)
  (untabify (point-min) (point-max)))

(map! :leader
      :desc "Indent Whole Buffer" "bi" #'iwb)
