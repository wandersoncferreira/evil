;;; custom/buffers/config.el -*- lexical-binding: t; -*-

;; set diff window to be in the right side
(set-popup-rule! "*Diff*" :side 'right :size 0.3)

(map! :leader
      :desc "Indent Whole Buffer" "bi" #'iwb
      :desc "Goto *Message* buffer" "mb" #'switch-to-message-buffer)


;;; narrowing buffers
(map! :leader
      (:prefix ("N" . "narrowing")
       "f" #'narrow-to-defun
       "p" #'narrow-to-page
       "r" #'narrow-to-region
       "w" #'widen))
