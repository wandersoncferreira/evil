;;; custom/coding/autoload.el -*- lexical-binding: t; -*-

;;;###autoload
(defun bk/flycheck-list-errors ()
  "Toggle flycheck list errors buffer."
  (interactive)
  (let ((buff (get-buffer "*Flycheck errors*")))
    (if buff
        (kill-buffer buff)
      (flycheck-list-errors))))
