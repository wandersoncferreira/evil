;;; custom/orgmode/config.el -*- lexical-binding: t; -*-

(setq org-directory "~/org/"
      org-return-follows-link t
      org-fontify-quote-and-verse-blocks t
      org-fontify-whole-heading-line t
      org-startup-indented nil
      org-archive-location (concat org-directory ".archive/%s::")
      org-capture-templates
      '(("t" "todo" entry (file+headline "todo.org" "Unsorted")
         "* [ ] %?\n"
         :prepend t)
        ("d" "deadline" entry (file+headline "todo.org" "Schedule")
         "* [ ] %?\nDEADLINE: <%(org-read-date)>\n\n%i"
         :prepend t)
        ("d" "schedule" entry (file+headline "todo.org" "Schedule")
         "* [ ] %?\nSCHEDULE: <%(org-read-date)>\n\n%i"
         :prepend t)
        ("c" "check out later" entry (file+headline "todo.org" "Check out later")
         "* [ ] %?\n"
         :prepend t)))

(require 'org-tempo)

(add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))
