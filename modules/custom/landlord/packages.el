;; -*- no-byte-compile: t; -*-
;;; custom/landlord/packages.el

(package! code-review
  :recipe (:local-repo "../../../landlord/code-review"))

(package! helm-spotify-plus
  :recipe (:local-repo "../../../landlord/helm-spotify-plus"))

(package! oblique-strategies
  :recipe (:local-repo "../../../landlord/oblique-strategies"
           :files (:defaults "*")))

(package! alabaster-theme
  :recipe (:local-repo "../../../landlord/alabaster-theme"))
