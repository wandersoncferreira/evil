;;; $DOOMDIR/preferences/+persp.el -*- lexical-binding: t; -*-

(after! persp-mode
  (setq persp-lighter
        '(:eval
          (format
           (propertize
            " #%.30s"
            'face (let ((persp (get-current-persp)))
                    (if persp
                        (if (persp-contain-buffer-p (current-buffer) persp)
                            'persp-face-lighter-default
                          'persp-face-lighter-buffer-not-in-persp)
                      'persp-face-lighter-nil-persp)))
           (safe-persp-name (get-current-persp))))))
