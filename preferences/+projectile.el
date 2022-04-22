;;; $DOOMDIR/preferences/+projectile.el -*- lexical-binding: t; -*-

(after! projectile

  ;; disable projectile caching
  (setq projectile-enable-caching nil)

  ;; add clojure specific folders to be ignored by projectile
  (setq projectile-globally-ignored-directories
        (append projectile-globally-ignored-directories
                '(".clj-kondo"
                  ".cpcache"
                  ".local")))

  ;; direct projectile to look for code in a specific folder.
  (setq projectile-project-search-path '("~/code")))
