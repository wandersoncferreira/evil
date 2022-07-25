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
  (let ((alpha (frame-parameter nil 'alpha)))
    (set-frame-parameter
     nil 'alpha
     (if (or (eql (cond ((numberp alpha) alpha)
                        ((numberp (cdr alpha)) (cdr alpha))
                        ((numberp (cadr alpha)) (cadr alpha)))
                  100)
             (not alpha))
         85
       100))))

;;;###autoload
(defun bk/toggle-window-split ()
  (interactive)
  (if (= (count-windows) 2)
      (let* ((this-win-buffer (window-buffer))
             (next-win-buffer (window-buffer (next-window)))
             (this-win-edges (window-edges (selected-window)))
             (next-win-edges (window-edges (next-window)))
             (this-win-2nd (not (and (<= (car this-win-edges)
                                         (car next-win-edges))
                                     (<= (cadr this-win-edges)
                                         (cadr next-win-edges)))))
             (splitter
              (if (= (car this-win-edges)
                     (car (window-edges (next-window))))
                  'split-window-horizontally
                'split-window-vertically)))
        (delete-other-windows)
        (let ((first-win (selected-window)))
          (funcall splitter)
          (if this-win-2nd (other-window 1))
          (set-window-buffer (selected-window) this-win-buffer)
          (set-window-buffer (next-window) next-win-buffer)
          (select-window first-win)
          (if this-win-2nd (other-window 1))))))
