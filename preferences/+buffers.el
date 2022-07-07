;;; $DOOMDIR/preferences/+buffers.el -*- lexical-binding: t; -*-

;;;###autoload
(defun iwb ()
  "Indent whole buffer."
  (interactive)
  (delete-trailing-whitespace)
  (indent-region (point-min) (point-max) nil)
  (untabify (point-min) (point-max)))

;;;###autoload
(defun switch-to-message-buffer ()
  "Switch to the `*Message*' buffer."
  (interactive)
  (with-current-buffer (messages-buffer)
    (switch-to-buffer (current-buffer))
    (evil-normal-state)))

;;;###autoload
(defun diff-current-buffer-with-file ()
  (interactive)
  (let ((buf (current-buffer)))
    (with-current-buffer buf
      (if buffer-file-name
          (progn
            (diff-buffer-with-file buf)
            (select-window (get-buffer-window "*Diff*")))
        (message "Buffer has not file")))))

;; set diff window to be in the right side
(set-popup-rule! "*Diff*" :side 'right :size 0.3)

(map! :leader
      :desc "Indent Whole Buffer" "bi" #'iwb
      :desc "Goto *Message* buffer" "mb" #'switch-to-message-buffer)
