;;; $DOOMDIR/preferences/+evil.el -*- lexical-binding: t; -*-
;;; I want to keep Evil-mode as close to Vim as possible

(setq evil-mode-line-format 'before)

;; defaults like Vim, c-i jumps forward in the jump list
(setq evil-want-C-i-jump t)

;; defaults like Vim, yank to whole line
(setq evil-want-Y-yank-to-eol nil)

;; keep the underscore as a word character like in Vim
(add-hook 'clojure-mode-hook (lambda () (modify-syntax-entry ?_ "w")))

;; fix issue with ] and [ markers in Evil
;; more details https://discourse.doomemacs.org/t/how-to-fix-marker-is-not-set-in-this-buffer/2603/2
(defun bk/bring-marker-back-on-yank (&rest _)
  (evil-set-marker ?\[ (point))
  (evil-set-marker ?\] (1- (point))))

(advice-add #'evil-yank :before #'bk/bring-marker-back-on-yank)

;;; evil-motion-trainer
;;; build muscle memory within some annoying walls
(add-hook 'after-init-hook #'global-evil-motion-trainer-mode)

(after! evil-motion-trainer
  (setq evil-motion-trainer-super-annoying-mode nil
        evil-motion-trainer-threshold 6)
  ;; add new advice
  (add-emt-advice sp-backward-delete-char '(sp-backward-kill-word)))
