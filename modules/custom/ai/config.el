;;; custom/ai/config.el -*- lexical-binding: t; -*-

(require 'gptel)

(setq gptel-default-mode 'org-mode
      gptel-log-level 'info
      gptel-use-tools t
      gptel-backend (gptel-make-gh-copilot "Copilot")
      gptel-model 'claude-sonnet-4)

(require 'gptel-integrations)
