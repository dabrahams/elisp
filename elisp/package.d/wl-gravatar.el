;;; wl-gravatar.el --- gravatar fetch/store functions

;; Copyright (C) 2010  Kazuhiro NISHIYAMA

;; Author: Kazuhiro NISHIYAMA <zn@mbf.nifty.com>
;; Keywords: faces, tools, extensions, mail

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.

;; This file is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;; Commentary:

;; Usage:
;; (require 'wl-gravatar)
;; (setq wl-highlight-x-face-function 'wl-gravatar-insert)
;; (setq gnus-gravatar-directory "~/.emacs-gravatar/")
;; (setq gravatar-unregistered-icon 'identicon)
;; (setq wl-gravatar-retrieve-once t)

;;; Code:

(require 'gravatar)

(defvar wl-gravatar-retrieve-once nil)

(defun wl-gravatar-insert (&rest dummy)
  "Display Gravatar images."
  (let ((field (std11-fetch-field "From"))
        (size (gravatar-make-query-size gravatar-icon-size))
        filename
        image)
    (when field
      (setq field (wl-address-header-extract-address field))
      (setq filename (gravatar-make-store-filename field size))

      (flet ((safe-create-image()(ignore-errors (create-image filename))))

        ;; If the file exists, is new enough, and can create an image, don't re-fetch
        (unless (and wl-gravatar-retrieve-once
                     (file-exists-p filename)
                     (< (time-to-number-of-days
                         (time-subtract 
                          (current-time) (sixth (file-attributes filename))))
                        90)
                 (setq image (safe-create-image)))
          (progn
            (gravatar-retrieve filename (gravatar-make-url field size))
            (setq image (safe-create-image))
            ))

        (when image
          (save-excursion
            (goto-char (point-min))
            (when (re-search-forward "^From: " nil t)
              (insert-image image))))
      ))))

(provide 'wl-gravatar)
;;; wl-gravatar.el ends here
