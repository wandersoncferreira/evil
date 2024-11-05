;;; ../code/evil/config.el -*- lexical-binding: t; -*-

;; empty file added on purpose.
;; when you perform a clean install, Doom will automatically create this file.
;; we know what we are doing, don't we?
;; all my personal configurations are written in the `modules/custom' folder
;; and loaded in `init.el' under the `:custom' keys

;; project anatomy
;;
;; ./landlord - elisp packages that I own and are distributed as packages
;; ./modules  - configuration defined in `:custom' keys in init.el file
;; ./themes   - custom themes not available as elisp packages
;; ./docs     - too many words to say: "learn with practice, use Emacs + Vim"

;; load security variables and easier ways to reach it
(defvar private-file-name
  (expand-file-name "private.el" user-emacs-directory))
(load private-file-name)
(set-register ?s (cons 'file private-file-name))
