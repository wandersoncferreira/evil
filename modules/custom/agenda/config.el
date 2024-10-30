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
  (setq org-agenda-files (bk/roam-todo-files)))

(advice-add 'org-agenda :before #'bk/agenda-files-update)
(advice-add 'org-todo-list :before #'bk/agenda-files-update)

(defvar bk/super-agenda-today-filter
  '((:name "Today"
     :scheduled t
     :order 2)
    (:name "Deadlines"
     :deadline t
     :order 3)
    (:name "Cronograma de Hoje"
     :time-grid t
     :discard (:deadline t)
     :order 1)))

(use-package! org-agenda
  :config
  (setq org-agenda-span 7
        org-agenda-start-day "+0d"
        ;; org-agenda-hide-tags-regexp "draft\\|todo"
        org-treat-insert-todo-heading-as-state-change t
        org-log-into-drawer t
        org-agenda-skip-timestamp-if-done t
        org-agenda-skip-deadline-if-done t
        org-agenda-skip-scheduled-if-done t
        org-agenda-custom-commands
        '(("d" "Agenda do Dia"
           ((agenda "" ((org-agenda-overriding-header "Agenda do Dia")
                        (org-agenda-span 1)
                        (org-agenda-skip-function
                         (lambda ()
                           (when (string-equal (org-entry-get (point) "style") "habit")
                             (outline-next-heading))))
                        (org-agenda-sorting-strategy '(scheduled-up deadline-up priority-down))
                        (org-super-agenda-groups bk/super-agenda-today-filter)))
            (org-ql-block '(or (and (habit)
                                    (or (scheduled :to today) (deadline :to today)))
                               (and (todo)
                                    (or (scheduled :to today)
                                        (deadline :to today)
                                        (todo "SOMEDAY"
                                              "CHECK"
                                              "TO-READ"
                                              "TO-WATCH"))))
                          ((org-ql-block-header "Atividades de Hoje")
                           (org-super-agenda-groups
                            '((:name "Habits" :habit t)
                              (:name "Compromissos Presenciais"
                               :tag "presencial"
                               :scheduled today
                               :deadline today)
                              (:name "Reuniões"
                               :time-grid t
                               :scheduled today
                               :deadline today
                               :tag "reunião")
                              (:name "Sometime this week"
                               :todo ("CHECK" "SOMEDAY" "TO-READ" "TO-WATCH")
                               :order 9
                               )))))))
          ("n" "Agenda de Amanhã"
           ((agenda "" ((org-agenda-overriding-header "Agenda de Amanhã")
                        (org-agenda-span 2)
                        (org-agenda-skip-function
                         (lambda ()
                           (when (string-equal (org-entry-get (point) "style") "habit")
                             (outline-next-heading))))
                        (org-agenda-sorting-strategy '(scheduled-up deadline-up priority-down))
                        (org-super-agenda-groups bk/super-agenda-today-filter))))))))

(add-to-list 'org-modules 'org-habit t)

(setq org-habit-preceding-days 4
      org-habit-following-days 4
      org-habit-show-habits-only-for-today nil
      org-habit-today-glyph ?⍟
      org-habit-completed-glyph ?✓
      org-habit-graph-column 40)

(use-package! org-super-agenda
  :after org
  :hook (org-agenda-mode . org-super-agenda-mode)
  :config
  (setq org-super-agenda-header-map nil)
  ;; hide the thin width char glyph
  (add-hook 'org-agenda-mode-hook
            (lambda () (setq-local nobreak-char-display nil))))

(defun org-agenda-show-svg ()
  (let* ((case-fold-search nil)
         (keywords (mapcar #'svg-tag--build-keywords svg-tag--active-tags))
         (keyword (car keywords)))
    (while keyword
      (save-excursion
        (while (re-search-forward (nth 0 keyword) nil t)
          (overlay-put (make-overlay
                        (match-beginning 0) (match-end 0))
                       'display  (nth 3 (eval (nth 2 keyword)))) ))
      (pop keywords)
      (setq keyword (car keywords)))))

(use-package! svg-tag-mode
  :init
  (setq svg-tag-tags
        '(("Important" . ((lambda (tag) (svg-tag-make "Important"
                                                   :face 'org-todo
                                                   :margin 2))))
          ("Habits" . ((lambda (tag) (svg-tag-make "Habits"
                                                   :face 'org-priority
                                                   :margin 0))))))
  :config
  (add-hook 'org-agenda-finalize-hook #'org-agenda-show-svg)
  (global-svg-tag-mode))
