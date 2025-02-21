;;; $DOOMDIR/init.el -*- lexical-binding: t; -*-

(doom! :input
       :completion
       vertico
       company

       :ui
       doom
       (popup +all)
       (treemacs +lsp)
       (modeline +light)
       (emoji +unicode)
       indent-guides
       unicode
       zen

       :editor
       (evil +everywhere)
       file-templates
       multiple-cursors
       snippets
       rotate-text
       word-wrap

       :emacs
       (dired +icons)
       electric
       vc
       undo

       :term
       :checkers
       (spell +aspell
              +everywhere)
       syntax

       :tools
       (lookup
        +offline
        +dictionary
        +docsets)
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
       yaml
       (python +lsp +pyright)
       (org +roam2
            +hugo
            +present
            +journal)
       web

       :email
       :app
       :config
       (default +bindings +smartparens)

       :custom
       agenda
       buffers
       clj
       coding
       completions
       encryption
       folders
       git
       harpoon
       js
       keys
       (landlord
        +code-review
        +spotify)
       orgmode
       parenthesis
       projects
       py
       self
       semantic-org-roam-search
       shell
       skin
       (whatever
        +screencast
        +finance)
       wicked
       (work
        +cisco))
