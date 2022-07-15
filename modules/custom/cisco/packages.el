;; -*- no-byte-compile: t; -*-
;;; custom/cisco/packages.el

(let ((file-name-handler-alist
       '(("\\.gpg\\(~\\|\\.~[0-9]+~\\)?\\'" . epa-file-handler)))
      (fullpath (expand-file-name "modules/custom/cisco/packages.el.gpg" doom-private-dir)))
  (load-file fullpath))
