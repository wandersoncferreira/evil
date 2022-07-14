;;; $DOOMDIR/preferences/+window.el -*- lexical-binding: t; -*-

;;;###autoload
(defun toggle-window-split ()
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

(map! :leader
      "wo" #'delete-other-windows
      "wr" #'windresize
      "wt" #'toggle-window-split
      :desc "Fullscreen (maximized)" "wf" #'toggle-frame-maximized
      )

(after! persp-mode
  (setq persp-lighter
        '(:eval
          (format
           (propertize
            " #%.30s"
            'face (let ((persp (get-current-persp)))
                    (if persp
                        (if (persp-contain-buffer-p (current-buffer) persp)
                            'persp-face-lighter-default
                          'persp-face-lighter-buffer-not-in-persp)
                      'persp-face-lighter-nil-persp)))
           (safe-persp-name (get-current-persp))))))

;; shares a common set of buffers between perspectives
(defvar persp-shared-buffers
  '("*scratch*" "*Messages*"))

(add-hook 'persp-activated-functions
          (lambda (_)
            (persp-add-buffer persp-shared-buffers)))

(after! persp-mode
  (setq persp-lighter
        '(:eval
          (format
           (propertize
            " #%.30s"
            'face (let ((persp (get-current-persp)))
                    (if persp
                        (if (persp-contain-buffer-p (current-buffer) persp)
                            'persp-face-lighter-default
                          'persp-face-lighter-buffer-not-in-persp)
                      'persp-face-lighter-nil-persp)))
           (safe-persp-name (get-current-persp))))))

;; shares a common set of buffers between perspectives
(defvar persp-shared-buffers
  '("*scratch*" "*Messages*"))

(add-hook 'persp-activated-functions
          (lambda (_)
            (persp-add-buffer persp-shared-buffers)))
