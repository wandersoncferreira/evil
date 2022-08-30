;;; custom/jvm/config.el -*- lexical-binding: t; -*-

(use-package! dap-mode
  :init
  (require 'dap-chrome)
  (setq dap-enable-mouse-support nil)
  :config
  (set-popup-rule! "\\*dap-ui-locals\\*" :side 'right :width 0.3)
  (set-popup-rule! "\\*dap-ui-sessions\\*" :side 'right :width 0.3))

(use-package! lsp-java
  :after java-mode
  :config
  (setq lsp-java-references-code-lens-enabled t
        lsp-java-implementations-code-lens-enabled t))

(after! cc-mode
  (add-hook 'java-mode-hook
            (lambda () (setq-local company-idle-delay 0.2))))
