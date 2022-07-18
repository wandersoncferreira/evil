;;; custom/search/config.el -*- lexical-binding: t; -*-

(use-package! engine-mode
  :init
  (progn
    (setq search-engine-alist
          `((clojure
             :name "Clojure 'Docs"
             :url "https://clojuredocs.org/search?q=%s")
            (maven
             :name "Maven Central"
             :url "https://search.maven.org/search?q=%s")
            (google
             :name "Google"
             :url "https://www.google.com/search?ie=utf-8&oe=utf-8&q=%s")))
    (dolist (engine search-engine-alist)
      (let ((func (intern (format "engine/search-%S" (car engine)))))
        (autoload func "engine-mode" nil 'interactive))))
  :config
  (message "Cheguei aqui!")
  (engine-mode t)
  (dolist (engine search-engine-alist)
    (let* ((cur-engine (car engine))
           (engine-url (plist-get (cdr engine) :url))
           (engine-keywords (plist-get (cdr engine) :keywords)))
      (eval `(defengine ,cur-engine ,engine-url ,@engine-keywords)))))
