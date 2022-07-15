;;; custom/cisco/config.el -*- lexical-binding: t; -*-

(let ((file-name-handler-alist
       '(("\\.gpg\\(~\\|\\.~[0-9]+~\\)?\\'" . epa-file-handler)))
      (fullpath (expand-file-name "modules/custom/cisco/config.el.gpg" doom-private-dir)))
  (load-file fullpath))
