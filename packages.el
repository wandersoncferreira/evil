;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

;;; left blank on purpose
(package! emacsql :pin "07699353a43f629848c66c0949e7170e8f29e299")

;; setup lookup module
(package! synosaurus)
(package! google-translate)

;; custom/agenda/packages
(package! org-super-agenda)
(package! svg-tag-mode)
(package! org-ql)
(unpin! org-gcal)
(package! org-gcal)

;; custom/coding/packages
(package! ripgrep)
(package! exec-path-from-shell)

;; custom/coding/completions
(package! diredfl :disable t)
(package! dired-rsync :disable t)
(package! fd-dired :disable t)

;; custom/folders/packages
(package! dired-subtree)
(package! dired-quick-sort)

;; custom/git/packages
(package! forge)

;; custom/harpoon/packages
(package! bookmark-in-project)

;; custom/js/packages
(package! emmet-mode :disable t) ; in web-mode, prevent completion in <script>

;; custom/landlord/packages
(package! code-review :recipe (:local-repo "landlord/code-review" :files ("*.el") :build (:not compile)))
(package! helm-spotify-plus :recipe (:local-repo "landlord/helm-spotify-plus" :files ("*.el") :build (:not compile)))
(package! oblique-strategies :recipe (:local-repo "landlord/oblique-strategies" :files (:defaults "*")))
(package! alabaster-theme :recipe (:local-repo "landlord/alabaster-theme"))
(package! emojify)

;; custom/orgmode/packages
(package! org-roam-ui)
(package! org-download)
(package! org-transclusion)
(package! toc-org)
(package! org-similarity :recipe (:host github :repo "brunoarine/org-similarity" :branch "main"))
(package! org-inline-video-thumbnails :recipe (:host github :repo "kisaragi-hiu/org-inline-video-thumbnails" :branch "main"))
(package! org-modern)
(package! org-alert)
(package! org-variable-pitch)
(package! org-margin :recipe (:host github :repo "rougier/org-margin" :branch "master"))
(package! org-music :recipe (:host github :repo "debanjum/org-music" :branch "master"))
(package! org-jira)

;; custom/parenthesis/packages
(package! evil-cleverparens)
(package! evil-smartparens)

;; custom/shell/packages
(package! chatgpt-shell :pin nil)

;; custom/whatever/packages
(package! gif-screencast)
(package! gnuplot)
(package! gnuplot-mode)
(package! osx-dictionary)
(package! emacs-bitwarden :recipe (:host github :repo "jsilve24/emacs-bitwarden" :branch "main"))

;; custom/work/packages
(package! browse-at-remote)

;; themes
(package! ef-themes)
(package! almost-mono-themes)

;; ai
(package! mcp
  :pin "3a380185597f56290057f370ab65dde89a20a18f")

;; spelling
(package! jinx)

;; keys
(package! which-key :disable t)
