;;; custom/orgmode/config.el -*- lexical-binding: t; -*-

(setq org-directory "~/org/"
      org-archive-location (concat org-directory ".archive/%s::"))

(after! org
  (setq org-capture-templates
        '(("t" "todo" entry (file+headline "todo.org" "Unsorted")
           "* [ ] %?\n"
           :prepend t)
          ("d" "deadline" entry (file+headline "todo" "Schedule")
           "* [ ] %?\nDEADLINE: <%(org-read-date)>\n\n%i"
           :prepend t)
          ("d" "schedule" entry (file+headline "todo" "Schedule")
           "* [ ] %?\nSCHEDULE: <%(org-read-date)>\n\n%i"
           :prepend t)
          ("c" "check out later" entry (file+headline "todo.org" "Check out later")
           "* [ ] %?\n"
           :prepend t)
          ("l" "ledger" plain (file "ledger.gpg")
           "%(+beancount/clone-transaction)"))))
