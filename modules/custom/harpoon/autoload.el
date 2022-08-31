;;; custom/harpoon/autoload.el -*- lexical-binding: t; -*-

;;;###autoload
(defun harpoon/clean-project ()
  (interactive)
  (bk/reset-global-harpoons)
  (bookmark-in-project-delete-all))

;;;###autoload
(defun harpoon/delete ()
  (interactive)
  (let ((proj-dir (bookmark-in-project--project-root-impl)))
    (bookmark-maybe-load-default-file)
    (let ((bm-list (bookmark-in-project--filter-by-project proj-dir bookmark-alist)))
      (if (not bm-list)
          (message "No Harpoon to be deleted")
        (progn
          (bookmark-in-project--with-save-deferred
           (let* ((bm-to-delete (completing-read "Choose a Harpoon to delete: "
                                                 (-map (lambda (bm)
                                                         (car bm))
                                                       bm-list)))
                  (bm-number (cadr (split-string bm-to-delete ":harpoon-")))
                  (harpoon-key (concat "h" bm-number)))
             (with-demoted-errors "%S" (bookmark-delete bm-to-delete))
             (map! :leader harpoon-key (harpoon/noop (string-to-number bm-number)))
             (message "Harpoon deleted."))))))))

;;;###autoload
(defun harpoon/quick-menu ()
  (interactive)
  (bookmark-in-project-jump))
