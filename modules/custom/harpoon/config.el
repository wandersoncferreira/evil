;;; custom/harpoon/config.el -*- lexical-binding: t; -*-

(defcustom harpoon-prefix-key "h"
  "Key to be used after LEADER to trigger harpoons.")

(defun bk/make-jump-to-harpoon (fn-number bm-name)
  "Create jump to Harpoon functions."
  (fset
   (intern (concat "harpoon/jump-to-" fn-number))
   `(lambda ()
      (interactive)
      (bookmark-jump ,bm-name)
      (message "Harpooned!"))))

(defun bk/make-set-to-harpoon (fn-number)
  "Create set Harpoon functions."
  (message "Loading harpon setters...")
  (fset
   (intern (concat "harpoon/set-" fn-number))
   `(lambda ()
      (interactive)
      (bookmark-in-project--has-file-name-or-error)
      (let* ((name (bookmark-in-project--name-impl bookmark-alist))
             (proj-dir (bookmark-in-project--project-root-impl))
             (abbrev-name (bookmark-in-project--name-abbrev proj-dir name))
             (harpoon-name (concat abbrev-name ":harpoon-" ,fn-number))
             (harpoon-key (concat harpoon-prefix-key ,fn-number)))
        (bookmark-in-project--without-messages
         (bookmark-set harpoon-name))
        (message "Harpoon %s set" ,fn-number)
        (map! :leader
              harpoon-key
              (bk/make-jump-to-harpoon ,fn-number harpoon-name))))))

(defun bk/load-harpoon-keys-in-project (&optional project-dir)
  "Harpoons are persistent across emacs sessions.

However, we lose the jump to harpoon functions. This function loads
the jump-to-* definitions after emacs starts."
  (bookmark-maybe-load-default-file)
  (let* ((proj-dir (or project-dir (bookmark-in-project--project-root-impl)))
         (bookmarks
          (bookmark-in-project--filter-by-project proj-dir bookmark-alist)))
    (dolist (bm bookmarks)
      (let* ((bm-name (car bm))
             (harpoon-number (and (string-match ":harpoon-\\([[:digit:]]\\).*" bm-name)
                                  (match-string 1 bm-name)))
             (harpoon-key (concat harpoon-prefix-key harpoon-number)))
        (message "Loading harpoon jump %s..." harpoon-number)
        (map! :leader
              harpoon-key
              (bk/make-jump-to-harpoon harpoon-number bm-name))))))

(defun bk/create-harpoons ()
  "This functions creates 5 harpoons.

Set the harpoon using SPC + h + {!, @, #, $, %}
Jump to harpoon using SPC + h + {1, 2, 3, 4, 5}."
  (dolist (n (number-sequence 1 5))
    (let* ((setter-keys '("!" "@" "#" "$" "%"))
           (setter-harpoon-key (concat harpoon-prefix-key (nth (- n 1) setter-keys)))
           (number-string (number-to-string n)))
      (map! :leader
            setter-harpoon-key
            (bk/make-set-to-harpoon number-string)))))

(defun harpoon/noop (n)
  (lambda ()
    (interactive)
    (message "Harpoon %s not defined." n)))

(defun bk/reset-global-harpoons ()
  (map! :leader
        "h1" (harpoon/noop 1)
        "h2" (harpoon/noop 2)
        "h3" (harpoon/noop 3)
        "h4" (harpoon/noop 4)
        "h5" (harpoon/noop 5)))

(use-package! bookmark-in-project
  :init
  (setq bookmark-in-project-verbose-cycle nil
        bookmark-in-project-verbose-toggle nil
        bookmark-in-project-name-fontify #'identity)
  :config
  (add-hook 'after-init-hook
            (lambda ()
              (bk/create-harpoons)
              (bk/reset-global-harpoons)))

  (advice-add '+workspace/switch-to
              :after
              (lambda (&rest args)
                (let ((persp-buff (car (persp-buffers (get-current-persp))))
                      (proj-dir))
                  (when (buffer-file-name persp-buff)
                    (with-current-buffer persp-buff
                      (setq proj-dir (projectile-project-root)))
                    (bk/reset-global-harpoons)
                    (bk/load-harpoon-keys-in-project proj-dir)))))

  (add-hook 'projectile-after-switch-project-hook
            (lambda ()
              (bk/reset-global-harpoons)
              (bk/load-harpoon-keys-in-project))))
