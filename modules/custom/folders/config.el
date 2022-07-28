;;; custom/folders/config.el -*- lexical-binding: t; -*-

(after! dired
  ;; dired tries to guess the default target directory
  (setq dired-dwim-target t)

  ;; DO NOT group directories first
  (setq dired-listing-switches "-alh"))

(map! :leader
      "fj" #'dired-jump)
