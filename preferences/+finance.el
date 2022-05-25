;;; $DOOMDIR/preferences/+finance.el -*- lexical-binding: t; -*-

(use-package! ledger-mode
  :mode ("\\.dat\\'")
  :config
  (setq ledger-schedule-file "~/org/ledger/ledger-2022.dat"
        ledger-reports
        '(("netcash" "ledger [[ledger-mode-flags]] -f %(ledger-file) -R -X R$ --current bal ^assets:bank ^assets:crypto liabilities:creditcard")
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
          ("account" "%(binary) -f %(ledger-file) reg %(account)"))))
