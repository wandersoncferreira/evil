;;; custom/buffers/autoload.el -*- lexical-binding: t; -*-

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
