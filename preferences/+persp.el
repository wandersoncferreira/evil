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

;; shares a common set of buffers between perspectives
(defvar persp-shared-buffers
  '("*scratch*" "*Messages*"))

(add-hook 'persp-activated-functions
          (lambda (_)
            (persp-add-buffer persp-shared-buffers)))
