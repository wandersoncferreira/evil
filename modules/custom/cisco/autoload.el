;;; custom/cisco/autoload.el -*- lexical-binding: t; -*-

(let ((file-name-handler-alist
       '(("\\.gpg\\(~\\|\\.~[0-9]+~\\)?\\'" . epa-file-handler)))
      (fullpath (expand-file-name "modules/custom/cisco/autoload.el.gpg" doom-private-dir)))
  (load-file fullpath))
