;;; custom/clj/autoload.el -*- lexical-binding: t; -*-

;;;###autoload
(defun bk/cider--modeline-info ()
  "I'd like to see only cider[connected:port] or cider[not connected]"
  (if-let* ((current-connection (ignore-errors (cider-current-repl))))
      (with-current-buffer current-connection
        (concat
         (symbol-name cider-repl-type)
         (when cider-mode-line-show-connection
           (format ":connected:%s" (plist-get nrepl-endpoint :port)))))
    "not connected"))
