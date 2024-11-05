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
    (:name "Deadlines"
     :deadline t
     :discard (:deadline t)
     :order 1)
    (:name "Cronograma de Hoje"
     :anything t
     ;; :not (:deadline today)
     :order 2)))

(use-package! org-agenda
  :config
  (setq org-agenda-span 7
        org-agenda-start-day "+0d"
        org-log-into-drawer t
        org-agenda-custom-commands
        '(("d" "Agenda do Dia"
           ((agenda "" ((org-agenda-overriding-header "Agenda do Dia")
                        (org-agenda-span 2)
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
                              (:name "Reuniões"
                               :tag "reunião")
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

(defun svg-progress-percent (value)
  (save-match-data
    (svg-image (svg-lib-concat
                (svg-lib-progress-bar  (/ (string-to-number value) 100.0)
                                       nil :margin 0 :stroke 2 :radius 3 :padding 2 :width 11)
                (svg-lib-tag (concat value "%")
                             nil :stroke 0 :margin 0))
               :ascent 'center)))

(defun svg-progress-count (value)
  (save-match-data
    (let* ((seq (split-string value "/"))
           (count (if (stringp (car seq))
                      (float (string-to-number (car seq)))
                    0))
           (total (if (stringp (cadr seq))
                      (float (string-to-number (cadr seq)))
                    1000)))
      (svg-image (svg-lib-concat
                  (svg-lib-progress-bar (/ count total) nil
                                        :margin 0 :stroke 2 :radius 3 :padding 2 :width 11)
                  (svg-lib-tag value nil
                               :stroke 0 :margin 0))
                 :ascent 'center))))

(defun bk/make-svg-headings (name-string face)
  (svg-tag-make name-string
                :face face
                :inverse t
                :radius 10
                :margin 0
                :padding 4))


(use-package! svg-tag-mode
  :init
  (setq svg-tag-tags
        '(
          ;; headings
          ("Important" . ((lambda (tag) (bk/make-svg-headings "Important" 'org-todo))))
          ("Deadlines" . ((lambda (tag) (bk/make-svg-headings "Deadlines" 'org-todo))))
          ("Habits" . ((lambda (tag) (bk/make-svg-headings "Habits" 'org-date))))
          ("Gaveta" . ((lambda (tag) (bk/make-svg-headings "Gaveta" 'org-priority))))
          ("Projetos" . ((lambda (tag) (bk/make-svg-headings "Projetos" nil))))
          ;; more
          ("DONE" . ((lambda (tag) (svg-tag-make "DONE" :face 'org-done :margin 0))))
          ;; Progress bars
          ("\\(\\[[0-9]\\{1,3\\}%\\]\\)" . ((lambda (tag)
                                              (svg-progress-percent (substring tag 1 -2)))))
          ("\\(\\[[0-9]+/[0-9]+\\]\\)" . ((lambda (tag)
                                            (svg-progress-count (substring tag 1 -1)))))))
  :config
  (add-hook 'org-agenda-finalize-hook #'org-agenda-show-svg)
  (global-svg-tag-mode))


(use-package! org-gcal
  :config
  (setq org-gcal-client-id gclient-id
        org-gcal-client-secret gclient-secret
        plstore-cache-passphrase-for-symmetric-encryption t
        org-gcal-fetch-file-alist '(("iagwanderson@gmail.com" . "~/googlecalendar_iagwanderson.org"))))
