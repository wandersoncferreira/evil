;;; $DOOMDIR/preferences/+java.el -*- lexical-binding: t; -*-

(defun bk/java-setup ()
  (make-local-variable 'company-idle-delay)
  (setq company-idle-delay 0.2)
  (subword-mode))

(after! lsp-java
  (setq lsp-java-vmargs
        (list
         "-noverify"
         "-Xmx3G"
         "-XX:+UseG1GC"
         "-XX:+UseStringDeduplication"
         "-javaagent:/Users/wferreir/code/dotfiles/lombok-1.18.22.jar")))

(add-hook 'java-mode-hook #'bk/java-setup)
