;;; $DOOMDIR/preferences/+blog.el -*- lexical-binding: t; -*-

(after! org
  (require 'time-stamp)
  (add-hook 'write-file-functions 'time-stamp))

(after! org-roam
  (setq org-roam-directory "~/code/wandersoncferreira.github.io/orgfiles"
        org-id-link-to-org-use-id t
        org-id-extra-files (org-roam--list-files org-roam-directory)
        org-roam-capture-templates
        '(("d" "default" plain "%?"
           :immediate-finish t
           :if-new (file+head "${slug}.org"
                              "#+TITLE: ${title}\n#+hugo_lastmod: Time-stamp: <>\n\n")
           :unnarrowed t))))

(after! ox-hugo
  (setq org-hugo-base-dir "~/code/wandersoncferreira.github.io"
        org-hugo-section "items"))

;;;###autoload
(defun bk/publish-bookmark ()
  (interactive)
  (let ((org-hugo-section "bookmarks"))
    (org-hugo-export-wim-to-md)))

;;;###autoload
(defun bk/publish-posts ()
  (interactive)
  (let ((org-hugo-section "posts"))
    (org-hugo-export-wim-to-md)))

;;;###autoload
(defun bk/publish-notes ()
  (interactive)
  (let ((org-hugo-section "notes"))
    (org-hugo-export-wim-to-md)))

(use-package! websocket
  :after org-roam)

(use-package! org-roam-ui
  :after org-roam
  :config
  (setq org-roam-ui-sync-theme t
        org-roam-ui-follow t
        org-roam-ui-update-on-save t))
