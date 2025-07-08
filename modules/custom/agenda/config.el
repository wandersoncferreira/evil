;;; custom/agenda/config.el -*- lexical-binding: t; -*-

(setq
 org-agenda-current-time-string
 "◀── now ─────────────────────────────────────────────────")

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
  (setq org-agenda-files (append
                          (list "~/googlecalendar_iagwanderson.org"
                                `,(concat org-roam-directory "/todo.org"))
                          (bk/roam-todo-files))))


(advice-add 'org-agenda :before #'bk/agenda-files-update)
(advice-add 'org-todo-list :before #'bk/agenda-files-update)

(setq bk/super-agenda-today-filter
  '((:discard (:habit t))
    (:discard (:tag "cisco"))
    (:discard (:tag "running"))
    (:discard (:tag "français"))
    (:name "Deadlines"
     :deadline t
     :discard (:deadline t)
     :order 1)
    (:name "Cronograma de Hoje"
     :anything t
     :order 2)))

(use-package! org-agenda
  :config
  (setq org-agenda-span 7
        org-agenda-start-day "+0d"
        org-log-into-drawer t
        org-agenda-custom-commands
        '(("d" "Agenda do Dia"
           ((agenda "" ((org-agenda-overriding-header "Agenda do Dia")
                        (org-agenda-span 1)
                        (org-agenda-prefix-format "   %i %?-2 t%s")
                        (org-agenda-skip-scheduled-if-done nil)
                        (org-agenda-skip-deadline-if-done t)
                        (org-agenda-day-face-function (lambda (date) 'org-agenda-date))
                        (org-agenda-skip-function
                         (lambda ()
                           (when (string-equal (org-entry-get (point) "style") "habit")
                             (outline-next-heading))))
                        (org-super-agenda-groups bk/super-agenda-today-filter)))
            (org-ql-block '(or (and (habit)
                                    (or (scheduled :to today)
                                        (deadline :to today)
                                        (done)))
                               (and (todo)
                                    (or (scheduled :to today)
                                        (deadline :to today)
                                        (todo "SOMEDAY"
                                              "CHECK"
                                              "PROJECT"
                                              "TO-READ"
                                              "TO-WATCH"))))
                          ((org-ql-block-header "Atividades Gerais")
                           (org-super-agenda-groups
                            '((:name "Habits" :habit t)
                              (:name "Compromissos Presenciais"
                               :tag "presencial")
                              (:name "Cisco"
                               :tag "cisco")
                              (:name "Français"
                               :tag "français")
                              (:name "Running"
                               :tag "running")
                              (:name "Gaveta"
                               :todo ("CHECK" "SOMEDAY" "TO-READ" "TO-WATCH")
                               :order 8)
                              (:name "Projetos"
                               :todo "PROJECT"
                               :order 9)
                              (:discard (:todo "TODO")))))))))))

(add-to-list 'org-modules 'org-habit t)

;; (setq org-habit-preceding-days 4
;;       org-habit-following-days 4
;;       org-habit-show-habits-only-for-today t
;;       org-habit-today-glyph ?⍟
;;       org-habit-completed-glyph ?✓
;;       org-habit-graph-column 40)

(use-package! org-super-agenda
  :after org
  :hook (org-agenda-mode . org-super-agenda-mode)
  :config
  (setq org-super-agenda-header-map nil)
  ;; hide the thin width char glyph
  (add-hook 'org-agenda-mode-hook
            (lambda () (setq-local nobreak-char-display nil))))

(use-package! org-gcal
  :config
  (setq org-gcal-up-days '10
        org-gcal-down-days '20
        org-gcal-recurring-events-mode 'top-level
        org-gcal-remove-api-cancelled-events t
        plstore-cache-passphrase-for-symmetric-encryption t
        org-gcal-fetch-file-alist '(("iagwanderson@gmail.com" . "~/googlecalendar_iagwanderson.org"))))
