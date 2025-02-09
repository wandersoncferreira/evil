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
  (setq projectile-project-search-path '("~/code"))

  (map! :leader
        :desc "Toggle Impl & Test" "pt" #'projectile-toggle-between-implementation-and-test
        :desc "List todos" "pl" #'magit-todos-list
        :desc "See project root dir" "pd" #'projectile-dired
        :desc "Ripgrep" "pg" #'projectile-ripgrep))

;; stop $HOME from being recognizes as a project root
(setq projectile-project-root-files-bottom-up
      (remove ".git" projectile-project-root-files-bottom-up))

;; add .github to files that identify the root of a project
(setq projectile-project-root-files-bottom-up
      (cons ".github" projectile-project-root-files-bottom-up))
