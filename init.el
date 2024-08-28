;;; init.el -*- lexical-binding: t; -*-

(doom! :input
       :completion
       vertico
       company

       :ui
       doom
       doom-dashboard
       (popup +all)
       workspaces
       (treemacs +lsp)
       modeline
       zen

       :editor
       (evil +everywhere)
       snippets

       :emacs
       (dired +icons)
       electric
       vc
       undo

       :term
       :checkers
       syntax

       :tools
       lookup
       magit
       editorconfig
       direnv
       lsp

       :os
       (:if IS-MAC
        macos)

       :lang
       clojure
       emacs-lisp
       (javascript +lsp)
       markdown
       plantuml
       (python +lsp +pyright)
       (org +roam2
            +present
            +journal)
       ledger
       web

       :email
       :app
       rss

       :config
       (default +bindings +smartparens)

       :custom
       buffers
       clj
       coding
       completions
       encryption
       folders
       harpoon
       js
       keys
       (landlord
        +code-review
        +spotify)
       orgmode
       parenthesis
       projects
       self
       shell
       skin
       (whatever
        +screencast
        +feeds
        +finance)
       wicked
       (work
        +cisco))
