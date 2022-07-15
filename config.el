;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(prefer-coding-system 'utf-8)

;;;###autoload
(defun bk/load-work-file (filename)
  (let ((file (expand-file-name
               (format "work/+%s.el.gpg" filename) doom-private-dir))
        (file-name-handler-alist
         '(("\\.gpg\\(~\\|\\.~[0-9]+~\\)?\\'" . epa-file-handler))))
    (load-file file)))

(defvar list-of-preferences
  '("appearance"
    "clojure"
    "evil"
    "keys"
    "vc"
    "window")
  "Not all is the way we like! Luck me, Emacs encourage customization.")

;; load the code

(dolist (cfg list-of-preferences)
  (let ((path (format "preferences/+%s" cfg)))
    (load! path)))
