;;; $DOOMDIR/preferences/+jumplist.el -*- lexical-binding: t; -*-

(after! better-jumper
  (setq ;; more than 20 jumps, starts to drop the oldest
        better-jumper-max-length 24))
