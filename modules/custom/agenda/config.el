;;; custom/agenda/config.el -*- lexical-binding: t; -*-

(setq
 org-agenda-current-time-string
 "◀── now ─────────────────────────────────────────────────")

(defun bk/roam-todo-files ()
  "returns a list of note files containing the TODO tag."
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
  (setq org-agenda-files (append
                          (list "~/googlecalendar_iagwanderson.org"
                                `,(concat org-roam-directory "/todo.org"))
                          (bk/roam-todo-files))))


(advice-add 'org-agenda :before #'bk/agenda-files-update)
(advice-add 'org-todo-list :before #'bk/agenda-files-update)

(use-package! org-agenda
  :config
  (setq org-agenda-start-day "+0d"
        org-log-into-drawer t
        org-agenda-custom-commands
        '(("d" "Today"
           ((agenda "" ((org-agenda-span 1)
                        (org-agenda-prefix-format "   %i %?-2 t%s")
                        (org-super-agenda-groups
                         '((:name "Tasks"
                            :time-grid t
                            :scheduled today
                            :order 1)))))
            (org-ql-block '(todo "SOMEDAY"
                            "CHECK"
                            "PROJECT"
                            "TO-READ"
                            "TO-WATCH")
                          ((org-ql-block-header "\n\n----------------------------\n
Projects and ideas for the future")
                           (org-super-agenda-groups
                            '((:name "Drawer"
                               :todo ("CHECK" "SOMEDAY" "TO-READ" "TO-WATCH")
                               :order 8)
                              (:name "Projects"
                               :todo "PROJECT"
                               :order 9)
                              (:discard (:todo "TODO"))))))))
          ("t" "Tomorrow"
           ((agenda "" ((org-agenda-span 1)
                        (org-agenda-start-day "+1d")
                        (org-agenda-prefix-format "   %i %?-2 t%s")
                        (org-super-agenda-groups
                         '((:name "Tasks"
                            :time-grid t
                            :scheduled today
                            :order 1)))))
            (org-ql-block '(todo "SOMEDAY"
                            "CHECK"
                            "PROJECT"
                            "TO-READ"
                            "TO-WATCH")
                          ((org-ql-block-header "\n\n----------------------------\n
Projects and ideas for the future")
                           (org-super-agenda-groups
                            '((:name "Drawer"
                               :todo ("CHECK" "SOMEDAY" "TO-READ" "TO-WATCH")
                               :order 8)
                              (:name "Projects"
                               :todo "PROJECT"
                               :order 9)
                              (:discard (:todo "TODO"))))))))))

  (add-to-list 'org-modules 'org-habit t))

(defun bk/org-agenda-tomorrow ()
  (interactive)
  (org-agenda nil "t"))

(defun bk/org-agenda-today ()
  (interactive)
  (org-agenda nil "d"))

(map! :after evil-org-agenda
      :map evil-org-agenda-mode-map
      "dh" #'bk/org-agenda-today
      "dt" #'bk/org-agenda-tomorrow)

(use-package! org-super-agenda
  :after org
  :hook (org-agenda-mode . org-super-agenda-mode)
  :config
  (setq org-super-agenda-header-map nil)
  ;; hide the thin width char glyph
  (add-hook! 'org-agenda-mode-hook
    (setq-local nobreak-char-display nil)))

(use-package! org-gcal
  :config
  (setq org-gcal-up-days '10
        org-gcal-down-days '20
        org-gcal-recurring-events-mode 'top-level
        org-gcal-remove-api-cancelled-events t
        plstore-cache-passphrase-for-symmetric-encryption t
        org-gcal-fetch-file-alist '(("iagwanderson@gmail.com" . "~/googlecalendar_iagwanderson.org"))))

;;;###autoload
(defun bk/open-agenda-on-the-side ()
  (interactive)
  (let ((buff (current-buffer)))
    (if (string= "*Org Agenda*" (buffer-name buff))
        (org-agenda nil "d")
      (progn
        (delete-other-windows)
        (+evil/window-vsplit-and-follow)
        (org-agenda nil "d")))))

;; (map! :leader
;;       "oA" #'bk/open-agenda-on-the-side)
