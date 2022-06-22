;;; init.el -*- lexical-binding: t; -*-
(doom! :input
       :completion
       company           ; the ultimate code completion backend
       vertico           ; the search engine of the future

       :ui
       doom              ; what makes DOOM look the way it does
       (popup +all)      ; tame sudden yet inevitable temporary windows
       vc-gutter         ; vcs diff in the fringe
       hl-todo           ; highlight TODO/FIXME/NOTE/DEPRECATED/HACK/REVIEW
       workspaces        ; tab emulation, persistence & separate workspaces

       :editor
       (evil +everywhere); come to the dark side, we have cookies
       file-templates    ; auto-snippets for empty files
       multiple-cursors  ; editing in many places at once
       snippets          ; my elves. They type so I don't have to

       :emacs
       dired             ; making dired pretty [functional]
       electric          ; smarter, keyword-based electric-indent
       vc                ; version-control and Emacs, sitting in a tree

       :term
       eshell            ; the elisp shell that works everywhere
       :checkers
       syntax            ; tasing you for every semicolon you forget

       :tools
       lookup            ; navigate your code and its documentation
       lsp               ; M-x vscode
       magit             ; a git porcelain for Emacs

       :os
       (:if IS-MAC
        macos)           ; improve compatibility with macOS

       :lang
       (clojure +lsp)    ; java with a lisp
       emacs-lisp
       (latex +latexmk)  ; writing papers in Emacs has never been so fun
       markdown          ; writing docs for people to ignore
       (java +lsp)
       (org
        +hugo
        +roam2)          ; organize your plain life in plain text
       plantuml          ; diagrams for confusing people more
       ledger            ; be audit you can be

       :email
       :app
       :config
       (default +bindings +smartparens))
