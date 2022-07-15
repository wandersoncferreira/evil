;;; custom/projects/config.el -*- lexical-binding: t; -*-

;;; External tools required to make projectile fly! fd, ag, rg
(after! projectile
  ;; disable projectile caching
  (setq projectile-enable-caching nil)

  ;; create missing test files
  (setq projectile-create-missing-test-files t)

  ;; add clojure specific folders to be ignored by projectile
  (setq projectile-globally-ignored-directories
        (append projectile-globally-ignored-directories
                '(".clj-kondo"
                  ".cpcache"
                  ".local")))

  ;; direct projectile to look for code in a specific folder.
  (setq projectile-project-search-path '("~/code")))

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
           (safe-persp-name (get-current-persp)))))

  ;; shares a common set of buffers between perspectives
  (defvar persp-shared-buffers
    '("*scratch*" "*Messages*"))

  (add-hook 'persp-activated-functions
            (lambda (_)
              (persp-add-buffer persp-shared-buffers))))
