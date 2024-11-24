;;; custom/work/config.el -*- lexical-binding: t; -*-

(when (modulep! +cisco)
  (let* ((fname "landlord/emacs-at-work/cisco.el")
         (fpath (expand-file-name fname doom-private-dir)))
    (add-to-list 'load-path fpath)
    (dolist (fun-name '(iroh/copy-permalink-at-point
                        iroh/repl-global-dev
                        iroh/cider-ns-refresh
                        iroh/browse-at-remote
                        iroh/browse-dev-resources
                        iroh/worktree
                        iroh/find-service-def))
      (autoload fun-name fpath "Cisco" t))
    (map! (:leader
           (:map (clojure-mode-map)
            (:prefix-map ("j" . "Job - Cisco Bindings")
             (:prefix ("r" . "Repl")
              "s" #'iroh/repl-global-dev
              "r" #'iroh/cider-ns-refresh)
             (:prefix ("b" . "Browse")
              "r" #'iroh/browse-at-remote
              "d" #'iroh/browse-dev-resources)
             (:prefix ("n" . "New")
              "f" #'iroh/worktree)
             (:prefix ("f" . "Find")
              "s" #'iroh/find-service-def)
             (:prefix ("y" . "Yank")
              "p" #'iroh/copy-permalink-at-point))))))
  (require 'browse-at-remote))
