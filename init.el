;;; $DOOMDIR/init.el -*- lexical-binding: t; -*-

(doom! :input
       :completion
       vertico
       (corfu
        +icons
        +orderless
        +dabbrev)

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
       llm
       lsp

       :os
       (:if IS-MAC
        macos)

       :lang
       (clojure +lsp)
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
       ai
       buffers
       clj
       coding
       completions
       encryption
       folders
       harpoon
       js
       keys
       orgmode
       parenthesis
       projects
       py
       self
       semantic-org-roam-search
       search
       shell
       skin
       (whatever
        +screencast
        +finance)
       wicked
       (work
        +cisco))
