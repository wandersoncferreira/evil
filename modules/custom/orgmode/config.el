;;; custom/orgmode/config.el -*- lexical-binding: t; -*-

(setq org-directory (expand-file-name "~/code/org/")
      org-deadline-warning-days 60
      org-hide-emphasis-markers t
      ;; remove gap when you add a new heading
      org-blank-before-new-entry '((heading . nil) (plain-list-item . nil))
      org-pretty-entities t
      ;; add close time when changing to DONE
      org-log-done 'time
      org-default-notes-file (concat org-directory "capture.org"))

;; hide everything
(setq org-startup-folded t)

;; new state to todo
(setq org-todo-keywords
      '((sequence
         "TODO(t!)"
         "WAIT(u)"
         "DELEGATED(e)"
         "STARTED(s)"
         "PROJECT(p)"
         "SOMEDAY(o)"
         "TO-READ(r)"
         "TO-WATCH(w)"
         "CHECK(k)"
         "|"
         "DONE(d!)"
         "CANCELED(c!)"
         )))

(add-hook 'org-trigger-hook 'save-buffer)

(setq org-return-follows-link t)

(add-hook 'org-mode-hook (lambda () (setq line-spacing 0.2)))

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

(require 'org-tempo)
(add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))

;; hugo section

(setq org-hugo-base-dir "~/code/wandersoncferreira.github.io")
(setq org-roam-publish-path org-hugo-base-dir)

(defun file-path-to-md-file-name (path)
    (let ((file-name (car (last (split-string path "/")))))
      (concat (car (split-string file-name "\\.")) ".md")))

  (defun file-path-to-slug (path)
    (let* ((file-name (car (last (split-string path "--"))))
           (title (car (split-string file-name "\\."))))
      (replace-regexp-in-string (regexp-quote "_") "-" title nil 'literal)))

(defun org-roam-publish-to-hugo ()
  (interactive)
  ;; make sure the author is me
  (setq user-full-name "Wanderson Ferreira")

  ;; call org roam to update id locations
  (org-roam-update-org-id-locations)

  (let ((files (org-roam-db-query
                [:select [nodes:id nodes:file]
                         :from nodes
                         :inner :join tags :on (= tags:node_id nodes:id)
                         :where (= tags:tag "publish")])))
    (-map
     (-lambda ((id file))
       ;; use temporary buffer to prevent a buffer being opened for each note
       (with-temp-buffer
         (message "Working on: %s" file)
         (insert-file-contents file)

         (goto-char (point-min))
         (while (re-search-forward "\\[\\[\\.\\/img\\([^]]*\\)\\]\\]" nil t)
           (replace-match "[[/img\\1]]" nil nil))
         (goto-char (point-min))
         (re-search-forward ":END:")
         (newline)
         ;; add in hugo tags for export.
         (insert
          (format "#+HUGO_BASE_DIR: %s\n#+HUGO_SECTION: ./\n#+HUGO_SLUG: %s\n#+EXPORT_FILE_NAME: %s\n"
                  org-roam-publish-path
                  (file-path-to-slug file)
                  (file-path-to-md-file-name file)))

         (org-hugo-export-to-md)))
     files)))

;; org roam section

(setq org-roam-directory (file-truename (concat doom-user-dir "others/roam2025"))
      org-roam-db-location (file-truename (concat doom-user-dir "others/roam2025/org-roam.db"))
      org-roam-dailies-directory "notes/")

(setq org-roam-capture-templates
      '(("n" "notes" plain
         "%?"
         :if-new (file+head "notes/%<%Y%m%d%H%M%S>-${slug}.org"
                            "#+title: ${title}\n")
         :immediate-finish t
         :unnarrowed t)))

(setq org-roam-node-display-template
     "${doom-tags:30} ${doom-hierarchy:*}" )

;; break lines automatically on the specified width
(add-hook 'org-mode-hook 'auto-fill-mode)

(use-package org-roam
  :init
  (setq org-roam-completion-everywhere t
        completion-ignore-case t)
 )

(after! org-roam
  (setq org-roam-capture-templates
        `(("n" "note" plain
           ,(format "#+title: ${title}\n" org-roam-directory)
           :target (file "note/%<%Y%m%d%H%M%S>-${slug}.org")
           :unnarrowed t)
          ("r" "thought" plain
           ,(format "#+title: ${title}\n" org-roam-directory)
           :target (file "thought/%<%Y%m%d%H%M%S>-${slug}.org")
           :unnarrowed t)
          ("t" "topic" plain
           ,(format "#+title: ${title}\n" org-roam-directory)
           :target (file "topic/%<%Y%m%d%H%M%S>-${slug}.org")
           :unnarrowed t)
          ("c" "contact" plain
           ,(format "#+title: ${title}\n" org-roam-directory)
           :target (file "contact/%<%Y%m%d%H%M%S>-${slug}.org")
           :unnarrowed t)
          ("p" "project" plain
           ,(format "#+title: ${title}\n" org-roam-directory)
           :target (file "project/%<%Y%m%d>-${slug}.org")
           :unnarrowed t)
          ("f" "todo" plain
           ,(format "#+title: ${title}\n" org-roam-directory)
           :target (file "todo/%<%Y%m%d%H%M%S>-${slug}.org")
           :unnarrowed t)
          ("w" "works" plain
           ,(format "#+title: ${title}\n" org-roam-directory)
           :target (file "works/%<%Y%m%d%H%M%S>-${slug}.org")
           :unnarrowed t)
          ("s" "secret" plain "#+title: ${title}\n\n"
           :target (file "secret/%<%Y%m%d%H%M%S>-${slug}.org.gpg")
           :unnarrowed t))))

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

(require 'org-inline-video-thumbnails)


(use-package! org-modern
  :hook (org-mode . org-modern-mode)
  :config
  (setq
   org-modern-star '( "⌾" "✸" "◈" "◇")
   org-modern-list '((42 . "◦") (43 . "•") (45 . "–"))
   org-pretty-entities t
   org-modern-table-vertical t
   org-modern-tag nil
   org-modern-priority nil
   org-modern-todo nil
   org-modern-table nil))

(use-package! org-variable-pitch
  :hook (org-mode . org-variable-pitch-minor-mode))

(use-package! org-margin
  :custom
  (org-margin-headers-set 'H-svg)
  :config
  (add-hook 'org-mode
            (lambda ()
              (org-indent-mode -1)
              (org-margin-mode))))

;; journal
(use-package! org-journal
  :defer 2
  :config
  (setq org-journal-dir (expand-file-name "~/code/roam/journal")
        org-journal-file-format "%Y-%m-%d"
        org-journal-encrypt-journal t))

(use-package! org-crypt
  :init
  (setq org-crypt-key "wand@hey.com"
        auto-save-default  nil)
  :config
  (org-crypt-use-before-save-magic))

;; org jira
(use-package! org-jira
  :init
  (setq jiralib-url "https://cisco-sbg.atlassian.net"
        org-jira-progress-issue-flow
        '(("Open" . "To Do")
          ("To Do" . "In Progress")
          ("In Progress" . "In Review")
          ("In Review" . "QA")
          ("QA" . "Ready for Acceptance")
          ("Ready for Acceptance" . "Ready for QA")
          ("Ready for QA" . "Done"))
        org-jira-custom-jqls
        '(
          (:jql "
assignee = currentUser() AND status not in (\"Won't Do\")
order by priority, created DESC "
           :filename "cisco")
          )))


;; toc-org
(use-package! toc-org
  :config
  (add-hook 'org-mode-hook 'toc-org-mode))
