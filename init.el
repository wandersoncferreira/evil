;;; init.el -*- lexical-binding: t; -*-
(doom! :input
       :completion
       vertico           ; the search engine of the future

       :ui
       doom              ; what makes DOOM look the way it does
       (popup +all)      ; tame sudden yet inevitable temporary windows
       vc-gutter         ; vcs diff in the fringe
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
       undo              ; persistent, smarter undo for your inevitable mistakes

       :term
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
       (clojure +lsp)    ; java with a lisp
       emacs-lisp        ; drown in parentheses
       (markdown +grip)  ; writing docs for people to ignore
       plantuml          ; diagrams for confusing people more
       (org
        +journal)        ; organize your plain life in plain text
       (haskell +lsp)    ; a language that's lazier than I am
       ledger            ; be audit you can be

       :email
       :app
       :custom
       buffers
       coding
       corfu
       encryption
       miscellaneous
       mydoom
       parenthesis

       :config
       (default +bindings +smartparens))
