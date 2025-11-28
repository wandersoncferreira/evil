;;; custom/ai/config.el -*- lexical-binding: t; -*-

;; use new curl version from homebrew because it is required
;; by AWS Bedrock
(setenv "PATH" (concat "/opt/homebrew/opt/curl/bin:" (getenv "PATH")))
(add-to-list 'exec-path "/opt/homebrew/opt/curl/bin/curl")

(require 'gptel)
(setq gptel-default-mode 'org-mode
      gptel-log-level 'info
      gptel-use-tools t
      gptel-model 'claude-sonnet-4-5-20250929)

(gptel-make-bedrock "AWS"
  :stream t
  :region "us-east-1"
  :aws-profile "default"
  :model-region 'us
  :models '(claude-sonnet-4-5-20250929))

(gptel-make-anthropic "Claude Roam"
  :stream t
  :models '(claude-sonnet-4-5-20250929)
  :key (-some-> (auth-source-search :host "api.anthropic.com" :max 1)
         (car)
         (plist-get :secret)
         (funcall)))

(require 'gptel-integrations)

(use-package! mcp
  :config
  (require 'mcp-hub)
  (add-to-list 'mcp-hub-servers '("git" . (:command "uvx" :args ("mcp-server-git")) ))
  (add-to-list 'mcp-hub-servers '("time" . (:command "uvx" :args ("mcp-server-time"))))
  (add-to-list 'mcp-hub-servers '("github" . (:command "github-mcp-server" :args ("stdio")
                                              :env (:GITHUB_PERSONAL_ACCESS_TOKEN
                                                    ,(-some-> (auth-source-search :host "api.github_mcp_server.com" :max 1)
                                                       (car)
                                                       (plist-get :secret)
                                                       (funcall))))))
  (add-to-list 'mcp-hub-servers '("filesystem" . (:command "npx"
                                                  :args ("-y" "@modelcontextprotocol/server-filesystem")
                                                  :roots ("/Users/wferreir/Documents/code/"))))
  (mcp-hub-start-all-server))

;; IDE
(use-package! claude-code-ide
  :bind ("C-c C-'" . claude-code-ide-menu)
  :init
  (setq claude-code-ide-use-side-window nil
        claude-code-ide-focus-claude-after-ediff t
        claude-code-ide-show-claude-window-in-ediff nil
        claude-code-ide-switch-tab-on-ediff nil
        claude-code-ide-enable-mcp-server t)
  :config
  (claude-code-ide-emacs-tools-setup))
