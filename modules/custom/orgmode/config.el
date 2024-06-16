;;; custom/orgmode/config.el -*- lexical-binding: t; -*-

(setq org-directory (expand-file-name "~/code/org/")
      org-deadline-warning-days 60
      ;; add close time when changing to DONE
      org-log-done 'time
      org-default-notes-file (concat org-directory "capture.org"))

;; hide everything
(setq org-startup-folded t)

;; new state to todo
(setq org-todo-keywords
      '((sequence
         "TODO(t)"
         "WAIT(w)"
         "DELEGATED(e)"
         "STARTED(s)"
         "|"
         "DONE(d)"
         "CANCELED(c)"
         "INACTIVE(i)")))

(setq org-return-follows-link t)

(setq-local org-capture-templates
      '(("t" "todo" entry (file+headline "todo.org" "Unsorted")
         "* TODO %?\n"
         :prepend t)
        ("d" "deadline" entry (file+headline "todo.org" "Deadline")
         "* TODO %?\nDEADLINE: <%(org-read-date)>\n\n%i"
         :prepend t)
        ("s" "schedule" entry (file+headline "todo.org" "Scheduled")
         "* TODO %?\nSCHEDULED: <%(org-read-date)>\n\n%i"
         :prepend t)
        ("h" "habit" entry (file+headline "todo.org" "Habits")
         "* TODO %?\nSCHEDULED: <%(org-read-date)>\n:PROPERTIES:\n:STYLE:   habit\n:END:\n")
        ("c" "check out later" entry (file+headline "todo.org" "Check out later")
         "* TODO %?\n"
         :prepend t)))

(defun bk/skip-scheduled-or-deadline-if-not-today ()
  (let* ((subtree-end (save-excursion (org-end-of-subtree t)))
         (deadline-entry (org-entry-get nil "DEADLINE"))
         (deadline-day (when deadline-entry
                         (time-to-days (org-time-string-to-time deadline-entry))))
         (scheduled-entry (org-entry-get nil "SCHEDULED"))
         (scheduled-day (when scheduled-entry
                          (time-to-days
                           (org-time-string-to-time
                            scheduled-entry))))
         (now (time-to-days (current-time))))
    (and
     (or
      (and deadline-day (not (= deadline-day now)))
      (and scheduled-day (not (= scheduled-day now))))
     subtree-end)))

(require 'org-habit)

(defun bk/skip-habits ()
  (save-restriction
    (widen)
    (let ((next-headline (save-excursion (or (outline-next-heading) (point-max)))))
      (if (org-is-habit-p)
          next-headline
        nil))))

(setq org-agenda-custom-commands
      '(("d" "Today's agenda"
         ((agenda ""
                  ((org-agenda-span 'week)
                   (org-agenda-skip-function (lambda ()
                                               (or
                                                (bk/skip-scheduled-or-deadline-if-not-today)
                                                (bk/skip-habits))))))))))

(require 'org-tempo)

(add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))

(after! ox-hugo
  (setq org-hugo-base-dir "~/code/wandersoncferreira.github.io"
        org-hugo-section "posts"))

(setq org-roam-directory (file-truename "~/code/roam"))

(setq org-roam-capture-templates
      '(("f" "fleeting" plain
         "%?"
         :if-new (file+head "fleeting/%<%Y%m%d%H%M%S>-${slug}.org"
                            "#+title: ${title}\n")
         :immediate-finish t
         :unnarrowed t)
        ("l" "literature" plain
         "%?"
         :if-new (file+head "literature/%<%Y%m%d%H%M%S>-${slug}.org"
                            "#+title: ${title}\n")
         :immediate-finish t
         :unnarrowed t)
        ("c" "concept" plain
         "%?"
         :if-new (file+head "concepts/%<%Y%m%d%H%M%S>-${slug}.org"
                            "#+title: ${title}\n")
         :immediate-finish t
         :unnarrowed t)))

(cl-defmethod org-roam-node-type ((node org-roam-node))
  "Return the TYPE of NODE."
  (condition-case nil
      (file-name-directory
       (directory-file-name
        (file-name-directory
         (file-relative-name (org-roam-node-file node) org-roam-directory))))
    (error "")))

(setq org-roam-node-display-template
      (concat "${type:15} ${title:*} "
              (propertize "${tags:10}" 'face 'org-tag)))

;; every zettel is a draft until declared otherwise
(defun bk/tag-new-node-as-draft ()
  (org-roam-tag-add '("draft")))

(add-hook 'org-roam-capture-new-node-hook #'bk/tag-new-node-as-draft)

(use-package org-roam
  :init
  (setq org-roam-completion-everywhere t
        completion-ignore-case t)
  :config
  (add-hook 'org-mode-hook
            (lambda ()
              (set (make-local-variable 'company-backends)
                   '(company-capf))
              (setq-local company-idle-delay 0.3
                          company-minimum-prefix-length 3)))
  (add-to-list 'company-backends 'company-capf))


(require 'org-roam-protocol)
