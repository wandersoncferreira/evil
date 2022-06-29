;;; $DOOMDIR/preferences/+jumplist.el -*- lexical-binding: t; -*-

(after! better-jumper
  ;; save jumplist by buffer, not window
  (setq better-jumper-context 'buffer
        ;; more than 20 jumps, starts to drop the oldest
        better-jumper-max-length 24))
