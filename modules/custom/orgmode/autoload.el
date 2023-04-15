;;; custom/orgmode/autoload.el -*- lexical-binding: t; -*-

;;;###autoload
(defun bk/khoj--clear-chat-buffer ()
  "Clear Khoj Chat buffer"
  (interactive)
  (with-current-buffer (get-buffer khoj--chat-buffer-name)
    (let ((inhibit-read-only t))
      (erase-buffer)
      (insert "* Khoj Chat\n")))
  (message "Buffer cleared!"))
