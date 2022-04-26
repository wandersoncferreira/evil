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


(defvar default-file-name-handler-alist
  '(("\\.gpg\\(~\\|\\.~[0-9]+~\\)?\\'" . epa-file-handler)
    ("\\(?:\\.tzst\\|\\.zst\\|\\.dz\\|\\.txz\\|\\.xz\\|\\.lzma\\|\\.lz\\|\\.g?z\\|\\.\\(?:tgz\\|svgz\\|sifz\\)\\|\\.tbz2?\\|\\.bz2\\|\\.Z\\)\\(?:~\\|\\.~[-[:alnum:]:#@^._]+\\(?:~[[:digit:]]+\\)?~\\)?\\'" . jka-compr-handler)
    ("\\`/[^/|:]+:" . tramp-autoload-file-name-handler)
    ("\\`/:" . file-name-non-special)))

;;;###autoload
(defun bk/load-gpg-file (filename)
  (let ((file (expand-file-name (format "preferences/+%s.el.gpg" filename) doom-private-dir))
        (file-name-handler-alist default-file-name-handler-alist))
    (load-file file)))
