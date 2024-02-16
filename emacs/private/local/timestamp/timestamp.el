;;; -*- Mode: Emacs-Lisp -*-
;;;
;;; timestamp.el --- Timestamp utilities.
;;;
;;; Copyright (c) 2023 Paul Ward <asmodai@gmail.com>
;;;
;;; Author:     Paul Ward <asmodai@gmail.com>
;;; Maintainer: Paul Ward <asmodai@gmail.com>
;;; Created:    09 Dec 2023 15:13:01
;;; Keywords:   
;;; URL:        not distributed yet
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

(defvar current-datetime-format "%a %b %d %Y"
  "Format of the date to insert via `insert-current-date-time'.")

(defvar current-time-format "%a %H:%M:%S"
  "Format of time to insert via `insert-current-time'.")

(defun insert-current-date ()
  "Insert the current date into the current buffer."
  (interactive)
  (insert (format-time-string current-datetime-format (current-time))))

(defun insert-current-time ()
  "Insert the current time into the current buffer."
  (interactive)
  (insert (format-time-string current-time-format (current-time))))

(global-set-key "\C-c\C-d" 'insert-current-date)
(global-set-key "\C-c\C-t" 'insert-current-time)

(provide 'timestamp)

;;; timestamp.el ends here.
