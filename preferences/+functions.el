;;; $DOOMDIR/preferences/+functions.el -*- lexical-binding: t; -*-

;;;###autoload
(defun bk/toggle-transparency ()
  (interactive)
  (let ((alpha (frame-parameter nil 'alpha)))
    (set-frame-parameter
     nil 'alpha
     (if (or (eql (cond ((numberp alpha) alpha)
                        ((numberp (cdr alpha)) (cdr alpha))
                        ((numberp (cadr alpha)) (cadr alpha)))
                  100)
             (not alpha))
         85
       100))))

;;;###autoload
(defun bk/load-gpg-file (filename)
  (let ((file (expand-file-name (format "preferences/+%s.el.gpg" filename) doom-private-dir))
        (file-name-handler-alist '(("\\.gpg\\(~\\|\\.~[0-9]+~\\)?\\'" . epa-file-handler))))
    (load-file file)))

;;;###autoload
(defun bk/bitwarden ()
  "Get bitwarden."
  (interactive)
  (kill-new (auth-source-pick-first-password
             :host "bitwarden.app"
             :user "bartuka")))
