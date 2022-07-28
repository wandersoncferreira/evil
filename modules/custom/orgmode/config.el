;;; custom/orgmode/config.el -*- lexical-binding: t; -*-

(use-package! org
  :config
  (setq org-directory "~/org/"
        org-return-follows-link t
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
           :prepend t))))
