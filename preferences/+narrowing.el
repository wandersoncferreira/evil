;;; $DOOMDIR/preferences/+narrowing.el -*- lexical-binding: t; -*-

(map! :leader
      (:prefix ("N" . "narrowing")
       "f" #'narrow-to-defun
       "p" #'narrow-to-page
       "r" #'narrow-to-region
       "w" #'widen))
