;;; $DOOMDIR/preferences/+rss.el -*- lexical-binding: t; -*-

(after! elfeed
  (setq elfeed-feeds
        '("https://emilkirkegaard.dk/en/feed"
          "https://desmondrivet.com/feeds/blog.rss"
          "https://xkcd.com/atom.xml"
          "https://emacsredux.com/atom.xml"
          "https://okmij.org/ftp/rss.xml"
          "http://planet.clojure.in/atom.xml"))

  ;; (set-face-attribute 'elfeed-search-title-face nil :foreground "dim gray")
  ;; (set-face-attribute 'elfeed-search-unread-title-face nil :foreground "blue")
  )
