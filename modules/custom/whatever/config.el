;;; custom/whatever/config.el -*- lexical-binding: t; -*-

;; timezones that I care about
(after! time
  ;; disable evil in world-clock mode
  (add-hook 'world-clock-mode-hook #'turn-off-evil-mode)

  (setq world-clock-list
        '(("America/Chicago" "Central")
          ("Europe/Paris" "Paris")
          ("Europe/Berlin" "Berlin")
          ("Europe/Zurich" "Zurich")
          ("EST5EDT" "Durham")
          ("MST7MDT" "Calgary"))))

(when (modulep! +screencast)
  (use-package! gif-screencast
    :defer t
    :commands gif-screencast
    :init
    (setq gif-screencast-args '("-x")
          gif-screencast-cropping-program ""
          gif-screencast-capture-format "ppm")))

;; keybindings for shortcuts
(map! :leader "bw" #'bk/bitwarden)
(map! :leader "bg" #'bk/gpg)

(when (modulep! +finance)
  (use-package! ledger-mode
    :mode ("\\.dat\\'")
    :config
    (setq ledger-schedule-file "~/org/ledger/ledger-2022.dat"
          ledger-reports
          '(("netcash/hoje" "ledger [[ledger-mode-flags]] -f %(ledger-file) -R -X R$ --current bal ^assets liabilities")
            ("netcash/futuro" "ledger [[ledger-mode-flags]] -f %(ledger-file) -R -X R$ bal ^assets liabilities")
            ("fatura/nubank" "ledger [[ledger-mode-flags]] -f %(ledger-file) -R -X R$ --current reg liabilities:creditcard:nubank")
            ("fatura/bradesco" "ledger [[ledger-mode-flags]] -f %(ledger-file) -R -X R$ --current reg liabilities:creditcard:bradesco")
            ("fatura/santander/mastercard" "ledger [[ledger-mode-flags]] -f %(ledger-file) -R -X R$ --current reg liabilities:creditcard:santander:mastercard")
            ("fatura/santander/infinite" "ledger [[ledger-mode-flags]] -f %(ledger-file) -R -X R$ --current reg liabilities:creditcard:santander:visainfinite")
            ("aluguel/morumbi" "ledger [[ledger-mode-flags]] -f %(ledger-file) -R -X R$ --sort d reg liabilities:boletos:quintoandar")
            ("cisco" "ledger [[ledger-mode-flags]] -f %(ledger-file) -R -X R$ --sort d reg income:cisco")
            ("maple-bear" "ledger [[ledger-mode-flags]] -f %(ledger-file) -R -X R$ --sort d reg liabilities:boletos:maplebear")))))

(use-package! emms
  :config
  (emms-all)
  (emms-default-players))

(defvar bitwarden-time-to-store "5 min"
  "Length of time to store last selected username and password before deleting. String should be recognized by the command run-at-time.")

;;;###autoload
(defun bitwarden--parse-hash-to-plist (e)
  "Pass emacs-bitwarden hash-table format to a plist."
  (let* ((login (gethash "login" e)))
    (message (gethash "name" e))
    (if login
        (list (gethash "name" e)
              (list
               :username (gethash "username" login)
               :password (gethash "password" login)))
      nil)))

;;;###autoload
(defun bitwarden-list-completing-read ()
  "A completing read interface built on top of emacs-bitwarden."
  (interactive)
  (let* ((vault (bitwarden-search))
         (vault (remq nil (mapcar 'bitwarden--parse-hash-to-plist vault)))
         (select (completing-read "Select:" vault))
         (select (car (cdr  (assoc select vault)))))
    (if (and  (boundp 'bitwarden--unstore-timer)
              (timerp bitwarden--unstore-timer))
        (progn
          (cancel-timer bitwarden--unstore-timer)
          (makunbound 'bitwarden--unstore-timer)))
    (setq bitwarden--username (plist-get select :username)
          bitwarden--password (plist-get select :password)
          bitwarden--unstore-timer (run-at-time
                                    bitwarden-time-to-store nil
                                    (lambda ()
                                      (makunbound 'bitwarden--username)
                                      (makunbound 'bitwarden--password)))))
  (message  "Username and Passwored temporarily stored."))


;;;###autoload
(defun bitwarden-kill-password (&optional arg)
  "Yank password from bitwarden--username.

With prefix argument, repeat completin-read selection even if there was a recent selection (e.g., the variable bitwarden--password is bound)."
  (interactive "P")
  (if (or  (not (boundp 'bitwarden--password))
           arg)
      (bitwarden-list-completing-read))
  (kill-new bitwarden--password))

;;;###autoload
(defun bitwarden-kill-username (&optional arg)
  "Yank password from bitwarden--username.

With prefix argument, repeat completin-read selection even if there was a recent selection (e.g., the variable bitwarden--username is bound)."
  (interactive "P")
  (if (or  (not (boundp 'bitwarden--username))
           arg)
      (bitwarden-list-completing-read))
  (kill-new bitwarden--username))


(use-package! bitwarden
  :config
  (setq bitwarden-user "wand@hey.com"
        bitwarden-api-secret-key
        (plist-get (car (auth-source-search :host "bitwarden.key")) :secret)
        bitwarden-api-client-id
        (plist-get (car (auth-source-search :host "bitwarden.id")) :secret)
        bitwarden-automatic-unlock
        (let* ((matches (auth-source-search :host "bitwarden.app"
                                            :user "bartuka"
                                            :require '(:secret)
                                            :max 1))
               (entry (nth 0 matches)))
          (plist-get entry :secret)))
  (bitwarden-login)
  (bitwarden-unlock))

(map! :leader "bu" #'bitwarden-kill-username)
(map! :leader "bj" #'bitwarden-kill-password)


;; bindings
;; open eshell in the root project
(map! :leader "oe" #'project-eshell)

;; google translate
(use-package! google-translate
  :config
  (setq google-translate-default-target-language nil
        google-translate-translation-directions-alist
        '(("fr" . "en")
          ("en" . "fr")
          ("en" . "pt_BR")))
  (map! :leader "sg" #'google-translate-smooth-translate))


;; spell-fu
(add-hook 'spell-fu-mode-hook
          (lambda ()
            (spell-fu-dictionary-add (spell-fu-get-ispell-dictionary "fr"))))
