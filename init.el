;;; init.el -*- lexical-binding: t; -*-

(doom! :input
       :completion
       vertico           ; the search engine of the future
       company           ; the ultimate code completion backend

       :ui
       doom              ; what makes DOOM look the way it does
       (popup +all)      ; tame sudden yet inevitable temporary windows
       workspaces        ; tab emulation, persistence & separate workspaces
       modeline          ; snazzy, Atom-inspired modeline, plus API

       :editor
       (evil +everywhere); come to the dark side, we have cookies
       file-templates    ; auto-snippets for empty files
       multiple-cursors  ; editing in many places at once
       snippets          ; my elves. They type so I don't have to

       :emacs
       dired             ; making dired pretty [functional]
       electric          ; smarter, keyword-based electric-indent
       vc                ; version-control and Emacs, sitting in a tree
       undo              ; persistent, smarter undo for your inevitable mistakes

       :term
       :checkers
       syntax            ; tasing you for every semicolon you forget

       :tools
       lookup            ; navigate your code and its documentation
       magit             ; a git porcelain for Emacs

       :os
       (:if IS-MAC
        macos)           ; improve compatibility with macOS

       :lang
       clojure           ; java with a lisp
       emacs-lisp        ; drown in parentheses
       markdown          ; writing docs for people to ignore
       plantuml          ; diagrams for confusing people more
       org               ; organize your plain life in plain text
       ledger            ; be audit you can be

       :email
       :app
       rss               ; emacs as an RSS reader

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
