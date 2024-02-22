;;; init.el -*- lexical-binding: t; -*-

(doom! :input
       :completion
       vertico
       company

       :ui
       doom
       (popup +all)
       workspaces
       modeline

       :editor
       (evil +everywhere)
       snippets

       :emacs
       dired
       electric
       vc
       undo

       :term
       :checkers
       syntax

       :tools
       lookup
       magit

       :os
       (:if IS-MAC
        macos)

       :lang
       clojure
       emacs-lisp
       javascript
       markdown
       plantuml
       (org +roam2
            +journal)
       ledger

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
       keys
       (landlord
        +code-review
        +spotify)
       orgmode
       parenthesis
       projects
       self
       skin
       (whatever
        +screencast
        +feeds
        +finance)
       wicked
       (work
        +cisco))
