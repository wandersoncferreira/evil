;;; $DOOMDIR/preferences/+uniquify.el -*- lexical-binding: t; -*-

;; enable uniquify again
(add-hook! 'doom-init-ui-hook
           :append
           #'(lambda ()
               (require 'uniquify)
               (setq uniquify-buffer-name-style 'reverse
                     uniquify-separator " • "
                     uniquify-after-kill-buffer-p t
                     uniquify-ignore-buffers-re "^\\*")))
