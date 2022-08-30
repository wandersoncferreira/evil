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

(map! :leader
      "bw" #'bk/bitwarden)

(when (modulep! +finance)
  (use-package! ledger-mode
    :mode ("\\.dat\\'")
    :config
    (setq ledger-schedule-file "~/org/ledger/ledger-2022.dat"
          ledger-reports
          '(("netcash" "ledger [[ledger-mode-flags]] -f %(ledger-file) -R -X R$ --current bal ^assets liabilities")
            ("sports" "ledger [[ledger-mode-flags]] -f %(ledger-file) -X R$ --current bal ^expenses:sports")
            ("doctor" "ledger [[ledger-mode-flags]] -f %(ledger-file) -X R$ --current bal ^expenses:doctor")
            ("apartamento-mae" "ledger [[ledger-mode-flags]] -f %(ledger-file) -X R$ -S date --current -w reg ^liabilities:apartment:mother")
            ("apartamento-misce" "ledger [[ledger-mode-flags]] -f %(ledger-file) -X R$ -S date --current -w reg ^liabilities:apartment:misce")
            ("eas-profit" "ledger [[ledger-mode-flags]] -f %(ledger-file) -X R$ --invert --current bal ^expenses:eval ^income:eval")
            ("food" "ledger [[ledger-mode-flags]] -f %(ledger-file) -X R$ --current bal ^expenses:food")
            ("donation" "ledger [[ledger-mode-flags]] -f %(ledger-file) -X R$ --current bal ^expenses:donation")
            ("apartamento-morumbi" "ledger [[ledger-mode-flags]] -f %(ledger-file) -X R$ --current bal ^expenses:house")
            ("creta" "ledger [[ledger-mode-flags]] -f %(ledger-file) -X R$ --current bal ^expenses:car:creta ^equity:car:creta")
            ("networth" "ledger [[ledger-mode-flags]] -f %(ledger-file) -X R$ --current bal ^assets liabilities")
            ("spent-vs-earned" "ledger [[ledger-mode-flags]] -f %(ledger-file) bal -X BRL --period=\"last 4 weeks\" ^Expenses ^Income --invert -S amount")
            ("budget" "ledger [[ledger-mode-flags]] -f %(ledger-file) -X R$ --current bal ^assets:bank:checking:budget liabilities:creditcard")
            ("taxes" "ledger [[ledger-mode-flags]] -f %(ledger-file) -R -X R$ --current bal ^expenses:taxes")
            ("bal" "%(binary) -f %(ledger-file) bal")
            ("reg" "%(binary) -f %(ledger-file) reg")
            ("payee" "%(binary) -f %(ledger-file) reg @%(payee)")
            ("account" "%(binary) -f %(ledger-file) reg %(account)")))))

(when (modulep! +feeds)
  (after! elfeed
    (setq elfeed-search-filter "@4-week-ago +unread"
          elfeed-feeds
          '(("https://memex.marginalia.nu/log/feed.xml" blog)
            ("http://nullprogram.com/feed/" blog dev)
            ("https://blog.cryptographyengineering.com/feed/" blog crypto)
            ("https://www.lesswrong.com/feed.xml?view=curated-rss" blog)
            ("https://api.quantamagazine.org/feed/" magazine)
            ("https://espial.esy.fun/u:yogsototh/feed.xml" bookmarks yann)
            ("https://www.masteringemacs.org/feed" blog emacs)
            ))

    ;; should not do this.. but memex does not support HTTP and
    ;; the SSL certificate is not updated.
    (setq elfeed-curl-extra-arguments '("--insecure")))

  ;; automatically update on elfeed-search
  (add-hook 'elfeed-search-mode-hook #'elfeed-update))
