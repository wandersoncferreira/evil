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
          '(("netcash/hoje" "ledger [[ledger-mode-flags]] -f %(ledger-file) -R -X R$ --current bal ^assets liabilities")
            ("netcash/futuro" "ledger [[ledger-mode-flags]] -f %(ledger-file) -R -X R$ bal ^assets liabilities")
            ("fatura/nubank" "ledger [[ledger-mode-flags]] -f %(ledger-file) -R -X R$ --current reg liabilities:creditcard:nubank")
            ("fatura/bradesco" "ledger [[ledger-mode-flags]] -f %(ledger-file) -R -X R$ --current reg liabilities:creditcard:bradesco")
            ("fatura/santander/mastercard" "ledger [[ledger-mode-flags]] -f %(ledger-file) -R -X R$ --current reg liabilities:creditcard:santander:mastercard")
            ("fatura/santander/infinite" "ledger [[ledger-mode-flags]] -f %(ledger-file) -R -X R$ --current reg liabilities:creditcard:santander:visainfinite")
            ("aluguel/morumbi" "ledger [[ledger-mode-flags]] -f %(ledger-file) -R -X R$ --sort d reg liabilities:boletos:quintoandar")
            ("cisco" "ledger [[ledger-mode-flags]] -f %(ledger-file) -R -X R$ --sort d reg income:cisco")
            ("maple-bear" "ledger [[ledger-mode-flags]] -f %(ledger-file) -R -X R$ --sort d reg liabilities:boletos:maplebear")))))

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
            ("https://www.masteringemacs.org/feed" blog emacs)))

    ;; should not do this.. but memex does not support HTTP and
    ;; the SSL certificate is not updated.
    (setq elfeed-curl-extra-arguments '("--insecure")))

  ;; automatically update on elfeed-search
  (add-hook 'elfeed-search-mode-hook #'elfeed-update))
