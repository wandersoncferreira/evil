;;; custom/skin/autoload.el -*- lexical-binding: t; -*-

;; set window width in 80 chars
(defun set-window-width (n)
  "Set the selected window's width."
  (adjust-window-trailing-edge
   (selected-window)
   (- n (window-width)) t))

;;;###autoload
(defun bk/set-80-columns ()
  "Set the selected window to 80 columns."
  (interactive)
  (set-window-width 80))

;;;###autoload
(defun set-font-for-laptop-usage ()
  "Set the font to a smaller value when working from the laptop.
Fit more in the screen!"
  (interactive)
  (setq doom-font (font-spec :size 11))
  (doom/reload-font))

;;;###autoload
(defun set-font-dual-monitor ()
  "Set the font to a higher value when working from external monitor."
  (interactive)
  (setq doom-font (font-spec :size 13))
  (doom/reload-font))

;;;###autoload
(defun bk/toggle-transparency ()
  (interactive)
  (let* ((alpha (frame-parameter nil 'alpha))
         (is-opaque? (or (eql (cond ((numberp alpha) alpha)
                                    ((numberp (cdr alpha)) (cdr alpha))
                                    ((numberp (cadr alpha)) (cadr alpha)))
                              100)
                         (not alpha)))
         (opacity (if is-opaque? 75 100))
         (theme (if is-opaque? 'doom-dark+ old-doom-theme)))
    (when is-opaque?
      (setq old-doom-theme doom-theme))
    (set-frame-parameter nil 'alpha opacity)
    (setq doom-theme theme)
    (load-theme doom-theme t)))

;;;###autoload
(defun what-face (pos)
  "Identify the face under point."
  (interactive "d")
  (let ((face (or (get-char-property (point) 'read-face-name)
                  (get-char-property (point) 'face))))
    (if face
        (message "Face: %s" face)
      (message "No face at %d pos"))))
