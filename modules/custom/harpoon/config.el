;;; custom/harpoon/config.el -*- lexical-binding: t; -*-

(defcustom harpoon-prefix-key "h"
  "Key to be used after LEADER to trigger harpoons.")

(defun bk/make-jump-to-harpoon (fn-number bm-name)
  "Create jump to Harpoon functions."
  (fset
   (intern (concat "bk/jump-to-harpoon-" fn-number))
   `(lambda ()
      (interactive)
      (bookmark-in-project--has-file-name-or-error)
      (bookmark-maybe-load-default-file)
      (bookmark-in-project--jump-impl
       (lambda ()
         (interactive)
         (bookmark-jump ,bm-name))))))

(defun bk/make-set-to-bookmark (fn-number)
  "Create set Harpoon functions."
  (fset
   (intern (concat "bk/set-harpoon-" fn-number))
   `(lambda ()
      (interactive)
      (let* ((name (bookmark-in-project--name-impl bookmark-alist))
             (proj-dir (bookmark-in-project--project-root-impl))
             (abbrev-name (bookmark-in-project--name-abbrev proj-dir name))
             (harpoon-name (concat abbrev-name ":harpoon-" ,fn-number))
             (harpoon-key (concat harpoon-prefix-key ,fn-number)))
        (bookmark-in-project--without-messages
         (bookmark-set harpoon-name))
        (map! :leader
              harpoon-key
              (bk/make-jump-to-bookmark ,fn-number harpoon-name))))))

(defun bk/load-harpoon-keys-in-project ()
  "Harpoons are persistent across emacs sessions.

However, we lose the jump to harpoon functions. This function loads
the jump-to-* definitions after emacs starts."
  (let* ((proj-dir (bookmark-in-project--project-root-impl))
         (bookmarks
          (bookmark-in-project--filter-by-project proj-dir bookmark-alist)))
    (dolist (bm bookmarks)
      (let* ((bm-name (car bm))
             (harpoon-number (and (string-match ":harpoon-\\([[:digit:]]\\).*" bm-name)
                                  (match-string 1 bm-name)))
             (harpoon-key (concat harpoon-prefix-key harpoon-number)))
        (map! :leader
              harpoon-key
              (bk/make-jump-to-bookmark harpoon-number bm-name))))))

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
            (bk/make-set-to-bookmark number-string)))))

(use-package! bookmark-in-project
  :config
  (setq bookmark-in-project-verbose-cycle nil
        bookmark-in-project-verbose-toggle nil
        bookmark-in-project-name-fontify #'identity)
  :config
  ;; create harpoons
  (bk/create-harpoons)

  ;; load saved harpoons after init
  (add-hook 'after-init-hook #'bk/load-harpoon-keys-in-project)

  ;; create alias to delete all harpoons from project
  (defalias 'bk/harpoon-clean-project 'bookmark-in-project-delete-all))
