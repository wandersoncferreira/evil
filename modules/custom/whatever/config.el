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

(use-package! emms
  :config
  (emms-all)
  (emms-default-players))
