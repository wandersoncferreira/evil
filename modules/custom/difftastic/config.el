;;; custom/difftastic/config.el -*- lexical-binding: t; -*-

(defun bk/magit--with-difftastic (buffer command)
  "Run COMMAND with GIT_EXTERNAL_DIFF=difft then show result in BUFFER."
  (let ((process-environment
         (cons (concat "GIT_EXTERNAL_DIFF=difft --width="
                       (number-to-string (frame-width)))
               process-environment)))
    (with-current-buffer buffer
      (setq buffer-read-only nil)
      (erase-buffer))
    (make-process
     :name (buffer-name buffer)
     :buffer buffer
     :command command
     :noquery t
     :sentinel (lambda (proc event)
                 (when (eq (process-status proc) 'exit)
                   (with-current-buffer (process-buffer proc)
                     (goto-char (point-min))
                     (ansi-color-apply-on-region (point-min) (point-max))
                     (setq buffer-read-only t)
                     (view-mode)
                     (end-of-line)
                     (let ((width (current-column)))
                       (while (zerop (forward-line 1))
                         (end-of-line)
                         (setq width (max (current-column) width)))
                       (setq width (+ width
                                      (fringe-columns 'left)
                                      (fringe-columns 'right)))
                       (goto-char (point-min))
                       (pop-to-buffer
                        (current-buffer)
                        `(,(when (> 80 (- (frame-width) width))
                             #'display-buffer-at-bottom)
                          (window-width
                           . ,(min width (frame-width))))))))))))

(defun bk/magit-show-with-diffstatic (rev)
  "Show the result of `git show REV'"
  (interactive
   (list (or
          (when (boundp 'rev) rev)
          (and (not current-prefix-arg)
               (or (magit-thing-at-point 'git-revision t)
                   (magit-branch-or-commit-at-point)))
          (magit-read-branch-or-commit "Revision"))))
  (if (not rev)
      (error "No revision specified")
    (bk/magit--with-difftastic
     (get-buffer-create (concat "*git show difftastic " rev "*"))
     (list "git" "--no-pager" "show" "--ext-diff" rev))))

(defun bk/magit-diff-with-difftastic (arg)
  "Show the result of `git diff ARG'"
  (interactive
   (list (or
          (when (boundp 'range) range)
          (and current-prefix-arg
               (magit-diff-read-range-or-commit "Range"))
          (pcase (magit-diff--dwim)
            ('unmerged (error "unmerged is not yet implemented"))
            ('unstaged nil)
            ('staged "--cached")
            (`(stash . ,value) (error "stash is not yet implemented"))
            (`(commit . ,value) (format "%s^..%s" value value))
            ((and range (pred stringp)) range)
            (_ (magit-diff-read-range-or-commit "Range/Commit"))))))
  (let ((name (concat "*git diff difftastic"
                      (if arg (concat " " arg) "")
                      "*")))
    (bk/magit--with-difftastic
     (get-buffer-create name)
     `("git" "--no-pager" "diff" "--ext-diff" ,@(when arg (list arg))))))

(transient-define-prefix bk/magit-aux-commands ()
  "My personal auxiliary magit commands."
  ["Auxiliary commands"
   ("d" "Difftastic Diff (dwim)" bk/magit-diff-with-difftastic)
   ("s" "Difftastic Show" bk/magit-show-with-diffstatic)])

(transient-append-suffix 'magit-dispatch "!"
  '("#" "My Magit Cmds" bk/magit-aux-commands))

(define-key magit-status-mode-map (kbd "#") #'bk/magit-aux-commands)

(set-popup-rule! "*git diff difftastic*" :side 'bottom :size 0.5)
