;;; custom/buffers/config.el -*- lexical-binding: t; -*-

;; set diff window to be in the right side
(set-popup-rule! "*Diff*" :side 'right :size 0.3)

(map! :leader
      :desc "Indent Whole Buffer" "bi" #'bk/indent-whole-buffer
      :desc "Diff current buffer with file" "bd" #'bk/diff-current-buffer-with-file
      :desc "Goto *Message* buffer" "mb" #'bk/switch-to-message-buffer

      (:prefix
       ("N" . "narrowing")
       "f" #'narrow-to-defun
       "p" #'narrow-to-page
       "r" #'narrow-to-region
       "w" #'widen)

      :mode emacs-lisp-mode
      :localleader
      "eb" #'eval-buffer)
