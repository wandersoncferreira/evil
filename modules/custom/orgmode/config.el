;;; custom/orgmode/config.el -*- lexical-binding: t; -*-

(setq org-directory (expand-file-name "~/code/org/")
      org-deadline-warning-days 60
      org-hide-emphasis-markers t
      org-pretty-entities t
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

;; org roam section

(setq org-roam-directory (file-truename "~/code/roam")
      org-roam-db-location (file-truename "~/code/roam/notes/org-roam.db")
      org-roam-dailies-directory "notes/")

(setq org-roam-capture-templates
      '(("n" "notes" plain
         "%?"
         :if-new (file+head "notes/%<%Y%m%d%H%M%S>-${slug}.org"
                            "#+title: ${title}\n")
         :immediate-finish t
         :unnarrowed t)))

;; showing the number of backlinks for each node in `org-roam-node-find'
(cl-defmethod org-roam-node-directories ((node org-roam-node))
  (if-let ((dirs (file-name-directory (file-relative-name (org-roam-node-file node) org-roam-directory))))
      (format "(%s)" (car (split-string dirs "/")))
    ""))

(cl-defmethod org-roam-node-backlinkscount ((node org-roam-node))
  (let* ((count (caar (org-roam-db-query
                       [:select (funcall count source)
                                :from links
                                :where (= dest $s1)
                                :and (= type "id")]
                       (org-roam-node-id node)))))
    (format "[%d]" count)))

(setq org-roam-node-display-template
      "${directories:10} ${tags:10} ${title:100} ${backlinkscount:6}")

;; break lines automatically on the specified width
(add-hook 'org-mode-hook 'auto-fill-mode)

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
  (add-to-list 'company-backends 'company-capf)
 ;(org-roam-db-autosync-mode)
 )

(require 'org-roam-protocol)

(defun org-roam-link-report-dangling ()
  "Create a report of dangling links (broken links)
in Org-Roam,
A table containing the sources and the links themselves are presented."
  (interactive)
  (let ((buffer (generate-new-buffer "*Org-Roam Dangling Links*"))
        (query (org-roam-db-query
                "select
                        '\"id:' || ltrim(links.source, '\"'),
                       '(' || group_concat(rtrim(links.type, '\"') || ':' || ltrim(links.dest, '\"'), ' \"\n||\" ') || ')'
                   from links
                   where links.type in ('\"roam\"', '\"id\"')
                     and (rtrim(links.type, '\"') || ':' || ltrim(links.dest, '\"'))
                         not in
                               (select '\"id:' || ltrim(nodes.id, '\"') from nodes
                          union select '\"roam:' || ltrim(nodes.title, '\"') from nodes
                          union select '\"roam:' || ltrim(aliases.alias, '\"') from aliases)
                   group by links.source;")))
    (with-current-buffer buffer
      (switch-to-buffer buffer)
      (org-mode)
      (insert "#+TITLE: Dangling Links Report\n\n")
      (insert "* Dangling Links\n\n")
      (insert "| Source | Broken Links \n")
      (insert "|")
      (org-table-align)
      (org-table-insert-hline)
      (forward-line 2)
      (dolist (row query)
        (insert "||\n")
        (insert (format "| %s | %s\n" (car row) (cadr row)))
        (org-table-align))
      (goto-char (point-min)))))

(require 'org-download)

(defun bk/roam-todo-files ()
  "returns a list of note files containing the 'todo' tag."
  (seq-uniq
   (seq-map
    #'car
    (org-roam-db-query
     [:select [nodes:file]
              :from tags
              :left-join nodes
              :on (= tags:node-id nodes:id)
              :where (like tag (quote "%\"todo\"%"))]))))

(defun bk/agenda-files-update (&rest _)
  "update the value of org agenda"
  (setq org-agenda-files (bk/roam-todo-files)))

(advice-add 'org-agenda :before #'bk/agenda-files-update)
(advice-add 'org-todo-list :before #'bk/agenda-files-update)

(use-package! org-agenda
  :config
  (setq org-agenda-span 3
        org-agenda-start-day "+0d"
        org-agenda-hide-tags-regexp "draft\\|todo"
        org-agenda-skip-timestamp-if-done t
        org-agenda-skip-deadline-if-done t
        org-agenda-skip-scheduled-if-done t))

(use-package! org-transclusion
  :after org
  :init
  (map!
   :map global-map "<f12>" #'org-transclusion-add
   :leader
   :prefix "n"
   :desc "Org Transclusion Mode" "t" #'org-transclusion-mode))

(defun bk/insert-timestamp-now ()
  "insert org mode timestamp at point with current date and time"
  (interactive)
  (org-insert-time-stamp (current-time) t))

(use-package! org-roam-ui
  :config
  (setq org-roam-ui-sync-theme t
        org-roam-ui-follow t
        org-roam-ui-update-on-save t
        org-roam-ui-open-on-start nil))

;; org-tree-slide
(setq org-tree-slide-skip-outline-level 0)

;; overwrite the function to a weird behavior that i want
;; always try to move to the next heading nested
(defun org-tree-slide-move-next-tree ()
  "ALWAYS Display the next slide"
  (interactive)
  (when (org-tree-slide--active-p)
    (let ((msg (plist-get org-tree-slide-indicator :next))
          (message-log-max nil))
      (when msg
        (message "%s" msg)))
    (run-hooks 'org-tree-slide-before-move-next-hook)
    (widen)
    (org-tree-slide--outline-next-heading)
    (org-tree-slide--display-tree-with-narrow)))

;; org similarity
(use-package! org-similarity
  :config
  (setq org-similarity-directory org-roam-directory
        org-similarity-language "english"
        org-similarity-remove-first t
        org-similarity-use-id-links t
        org-similarity-recursive-search t
        org-similarity-number-of-documents 10)

  ;; overwrite internal function of org-similarity
  (defun org-similarity--show-sidebuffer (filename)
    "Search similar documents related to FILENAME and puts results in a side buffer."
    (add-to-list 'display-buffer-alist
                 '("*Similarity Results*"
                   ;; (display-buffer-in-side-window)
                   ;; changed to use some window because i cant split side windows
                   ;; and i want to use evil-split-and-follow function
                   ;; and keep the similarity buffer still visible
                   (display-buffer-use-some-window)
                   (inhibit-same-window . t)
                   (side . right)
                   (window-width . 0.33)))
    (let* ((org-similarity-heading org-similarity-heading-sidebuffer)
           (org-similarity-prefix org-similarity-prefix-sidebuffer)
           (results (org-similarity--run-command filename))
           (formatted-results (org-similarity--format-pairs (org-similarity--parse-json-string results))))
      (with-output-to-temp-buffer "*Similarity Results*"
        (princ formatted-results))
      (with-current-buffer "*Similarity Results*"
        (org-mode)))))
