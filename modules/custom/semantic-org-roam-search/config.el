;;; custom/semantic-org-roam-search/config.el -*- lexical-binding: t; -*-

(defvar roam-search-api-endpoint
  "http://localhost:17042/api")

(defun call-roam-search-python-server (input-string)
  "Call Python server with INPUT-STRING."
  (let ((url-request-method "GET")
        (url-request-extra-headers
         '(("Content-Type" . "text/plain"))))
    (with-current-buffer
        (url-retrieve-synchronously
         (concat roam-search-api-endpoint "/" input-string))
      (goto-char (point-min))
      (search-forward-regexp "\n\n")
      (buffer-substring (point) (point-max)))))

(defun bk/roam-semantic-search ()
  "Call the semantic-search API on a selected region or ask for input."
  (interactive)
  (let* ((text (if (use-region-p)
                   (buffer-substring-no-properties (region-beginning) (region-end))
                 (read-string "Enter search: ")))
         (buf (get-buffer-create "*org-roam-similar-nodes*"))
         (api-output (call-roam-search-python-server text)))
    (with-current-buffer buf
      (erase-buffer)
      (org-mode)
      (insert (format "%s" api-output))
      (org-shifttab)
      (display-buffer buf))))

(define-minor-mode chat-minor-mode
  "A minor mode to send chat messages to API."
  :init-value nil
  :lighter " Chat"
  :keymap (let ((map (make-sparse-keymap)))
            (define-key map (kbd "RET") 'exchange-with-chat-api)
            map))

(general-define-key
 :keymaps 'chat-minor-mode-map
 :states '(insert)
 "RET" 'exchange-with-chat-api)

(defun q-n-a-with-org-roam ()
  "Create a temporary buffer in org mode for chatting with an API."
  (interactive)
  (let ((buf (get-buffer-create "*Q&A Org-roam*")))
    (switch-to-buffer buf)
    (org-mode)
    (chat-minor-mode)
    (erase-buffer)
    (insert "#+TITLE: Q&A with org-roam\n\n")
    (goto-char (point-max))
    (insert "Type your message here:\n> ")
    (goto-char (point-max))))

(defun insert-string-simulating-typing (string)
  "Inserts STRING into the current buffer simulating typing."
  (interactive "sEnter string to insert: ")
  (let ((delay 0.03)) ; adjust this delay as desired
    (dolist (char (append string nil))
      (insert char)
      (sit-for delay))))

(defun call-python-server (request-str)
  "Call Python server with INPUT-STRING and return the output string."
  (let ((url-request-method "GET")
        (url-request-extra-headers '(("Content-Type" . "text/plain")))
        (url-show-status nil)
        (url-show-trace nil))
    (with-current-buffer
        (url-retrieve-synchronously
         (concat roam-search-api-endpoint "/" request-str))
      (goto-char (point-min))
      (search-forward-regexp "\n\n")
      (buffer-substring (point) (point-max)))))

(defun split-string-at-substring (full-str sub-str)
  "Split FULL-STR at SUB-STR and return a list of two strings."
  (if (string-match sub-str full-str)
      (let ((parts (split-string full-str sub-str)))
        (list (car parts) (concat sub-str (mapconcat 'identity (cdr parts) sub-str))))
    (list full-str nil)))

(defun exchange-with-chat-api ()
  "Send the current message to the API and display the response."
  (interactive)
  (prin1 "aqui!")
  (let* ((message (buffer-substring-no-properties (line-beginning-position) (line-end-position)))
         (response (call-python-server message)))
    (goto-char (point-max))
    (insert "\n\n")
    (setq result (split-string-at-substring response "SOURCES:"))
    (insert-string-simulating-typing (nth 0 result))
    (when (nth 1 result)
      (insert (decode-coding-string (nth 1 result) 'utf-8)))
    (goto-char (point-max))
    (insert "\n\n> ")))
