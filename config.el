;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

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

(defvar list-of-work-settings
  '("cisco")
  "I have private emacs lisp code to ease my daily activities at work.
I should have started to document these shortcuts a long time ago, but better
late than never.")

;; load the code

(dolist (cfg list-of-preferences)
  (let ((path (format "preferences/+%s" cfg)))
    (load! path)))

(dolist (cfg list-of-work-settings)
  (bk/load-work-file cfg))
