;;; ../code/evil/preferences/+projectile.el -*- lexical-binding: t; -*-

(after! projectile

  ;; disable projectile caching
  (setq projectile-enable-caching nil)

  ;; direct projectile to look for code in a specific folder.
  (setq projectile-project-search-path '("~/code")))
