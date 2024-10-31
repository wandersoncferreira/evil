;; -*- no-byte-compile: t; -*-
;;; custom/orgmode/packages.el

(package! org-roam-ui)
(package! org-download)
(package! org-transclusion)
(package! org-similarity
  :recipe (:host github :repo "brunoarine/org-similarity" :branch "main"))
(package! org-inline-video-thumbnails
  :recipe
  (:host github
         :repo "kisaragi-hiu/org-inline-video-thumbnails"
         :branch "main"))
(package! org-modern)
(package! org-alert)
