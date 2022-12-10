;; -*- no-byte-compile: t; -*-
;;; custom/landlord/packages.el

(package! code-review
  :recipe (:local-repo "../../../landlord/code-review" :files ("*.el") :build (:not compile)))

(package! helm-spotify-plus
  :recipe (:local-repo "../../../landlord/helm-spotify-plus" :files ("*.el") :build (:not compile)))

(package! oblique-strategies
  :recipe (:local-repo "../../../landlord/oblique-strategies"
           :files (:defaults "*")))

(package! alabaster-theme
  :recipe (:local-repo "../../../landlord/alabaster-theme"))

(package! emojify)
