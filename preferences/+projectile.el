;;; $DOOMDIR/preferences/+projectile.el -*- lexical-binding: t; -*-
;;; External tools required to make projectile fly!
;; fd, ag, rg

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
