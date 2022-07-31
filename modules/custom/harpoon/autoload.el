;;; custom/harpoon/autoload.el -*- lexical-binding: t; -*-

;;;###autoload
(defun harpoon/clean ()
  (interactive)
  (bk/reset-global-harpoons)
  (bookmark-in-project-delete-all))
