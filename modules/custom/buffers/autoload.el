;;; custom/buffers/autoload.el -*- lexical-binding: t; -*-

;;;###autoload
(defun bk/indent-whole-buffer ()
  "Indent whole buffer."
  (interactive)
  (delete-trailing-whitespace)
  (indent-region (point-min) (point-max) nil)
  (untabify (point-min) (point-max))
  (message "Buffer indented"))

;;;###autoload
(defun bk/switch-to-message-buffer ()
  "Switch to the `*Message*' buffer."
  (interactive)
  (with-current-buffer (messages-buffer)
    (switch-to-buffer (current-buffer))
    (evil-normal-state)))

;;;###autoload
(defun bk/diff-current-buffer-with-file ()
  "Run diff of current buffer against the file in your disk."
  (interactive)
  (let ((buf (current-buffer)))
    (with-current-buffer buf
      (if buffer-file-name
          (progn
            (diff-buffer-with-file buf)
            (select-window (get-buffer-window "*Diff*")))
        (message "Buffer has no file")))))
