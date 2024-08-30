;;; init.el -*- lexical-binding: t; -*-

(doom! :input
       :completion
       (vertico +childframe)
       (company +childframe +tng)

       :ui
       doom
       (popup +all)
       workspaces
       (treemacs +lsp)
       (modeline +light)
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
       web

       :email
       :app
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
