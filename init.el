;;; init.el -*- lexical-binding: t; -*-

(doom! :input
       :completion
       vertico           ; the search engine of the future
       company           ; the ultimate code completion backend

       :ui
       doom              ; what makes DOOM look the way it does
       (popup +all)      ; tame sudden yet inevitable temporary windows
       workspaces        ; tab emulation, persistence & separate workspaces
       treemacs          ; a project drawer, like neotree but cooler

       :editor
       (evil +everywhere); come to the dark side, we have cookies
       file-templates    ; auto-snippets for empty files
       multiple-cursors  ; editing in many places at once
       snippets          ; my elves. They type so I don't have to
       (format +onsave)  ; automated prettiness

       :emacs
       dired             ; making dired pretty [functional]
       electric          ; smarter, keyword-based electric-indent
       vc                ; version-control and Emacs, sitting in a tree
       undo              ; persistent, smarter undo for your inevitable mistakes

       :term
       eshell            ; the elisp shell that works everywhere

       :checkers
       syntax            ; tasing you for every semicolon you forget

       :tools
       lookup            ; navigate your code and its documentation
       magit             ; a git porcelain for Emacs
       lsp               ; M-x vscode

       :os
       (:if IS-MAC
        macos)           ; improve compatibility with macOS

       :lang
       clojure           ; java with a lisp
       emacs-lisp        ; drown in parentheses
       markdown          ; writing docs for people to ignore
       plantuml          ; diagrams for confusing people more
       (java +lsp)       ; the poster child for carpal tunnel syndrome
       org               ; organize your plain life in plain text
       ledger            ; be audit you can be

       :email
       :app
       rss               ; emacs as an RSS reader

       :config
       (default +bindings +smartparens)

       :custom
       apl
       buffers
       clj
       coding
       completions
       denote
       encryption
       folders
       harpoon
       jvm
       keys
       (landlord
        +code-review
        +spotify
        +oblique)
       orgmode
       parenthesis
       projects
       rst
       self
       skin
       (whatever
        +screencast
        +feeds
        +finance)
       wicked
       (work
        +cisco))
