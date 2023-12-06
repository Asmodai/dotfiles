;;; -*- Mode: Emacs-Lisp; lexical-binding: t -*-
;;;
;;; funcs.el --- Org-specific functions and hacks.
;;;
;;; Copyright (c) 2023 Paul Ward <asmodai@gmail.com>
;;;
;;; Author:     Paul Ward <asmodai@gmail.com>
;;;
;;; This file is not part of GNU Emacs.
;;;
;;;{{{ License:
;;;
;;; This program is free software: you can redistribute it
;;; and/or modify it under the terms of the GNU General Public
;;; License as published by the Free Software Foundation,
;;; either version 3 of the License, or (at your option) any
;;; later version.
;;;
;;; This program is distributed in the hope that it will be
;;; useful, but WITHOUT ANY  WARRANTY; without even the implied
;;; warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
;;; PURPOSE.  See the GNU General Public License for more
;;; details.
;;;
;;; You should have received a copy of the GNU General Public
;;; License along with this program.  If not, see
;;; <http://www.gnu.org/licenses/>.
;;;
;;;}}}
;;;{{{ Commentary:
;;;
;;;}}}

(defun org-extensions--align-tags-here (to-col)
  "Align tags on the current headline to TO-COL.
Since TO-COL is derived from `org-tags-column', a negative value is
interpreted as alignment flush-right, a positive value as flush-left,
and 0 means insert a single space in between the headline and the tags."
  ;; source: https://list.orgmode.org/20200916225553.hrtxitzt46dzln7i@ionian.linksys.moosehall/
  (save-excursion
    (when (org-match-line org-tag-line-re)
      (let* ((tags-start (match-beginning 1))
             (tags-end (match-end 1))
             (tags-pixel-width
              (car (window-text-pixel-size (selected-window)
                                           tags-start tags-end)))
             (blank-start (progn
                            (goto-char tags-start)
                            (skip-chars-backward " \t")
                            (point)))
             ;; use this to avoid a 0-width space before tags on long lines:
             (blank-start-col (progn
                                (goto-char blank-start)
                                (current-column)))
             ;; this is to makes it work with org-indent-mode:
             (lpref (if (org-fold-folded-p) 0
                      (length (get-text-property (point) 'line-prefix)))))
        ;; If there is more than one space between the headline and
        ;; tags, delete the extra spaces.  Might be better to make the
        ;; delete region one space smaller rather than inserting a new
        ;; space?
        (when (> tags-start (1+  blank-start))
          (delete-region blank-start tags-start)
          (goto-char blank-start)
          (insert " "))
        (if (or (= to-col 0) (< (abs to-col) (1- blank-start-col)))
            ;; Just leave one normal space width
            (remove-text-properties blank-start (1+  blank-start)
                                    '(my-display nil))
          (message "In here: %s" lpref)
          (let ((align-expr
                 (if (> to-col 0)
                     ;; Left-align positive values
                     (+ to-col lpref)
                   ;; Right-align negative values by subtracting the
                   ;; width of the tags.  Conveniently, the pixel
                   ;; specification allows us to mix units,
                   ;; subtracting a pixel width from a column number.
                   `(-  ,(- lpref to-col) (,tags-pixel-width)))))
            (put-text-property blank-start (1+  blank-start)
                               'my-display
                               `(space . (:align-to ,align-expr)))))))))

(defun org-extensions/fix-tag-alignment ()
  (setq org-tags-column 70) ;; adjust this
  (advice-add 'org--align-tags-here :override #'org-extensions--align-tags-here)
  ;; this is needed to make it work with https://github.com/minad/org-modern:
  (add-to-list 'char-property-alias-alist '(display my-display))
  ;; this is needed to align tags upon opening an org file:
  (org-align-tags t))

;;; funcs.el ends here.
