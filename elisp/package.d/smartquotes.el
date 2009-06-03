;;; smartquotes.el --- Insertion of unicode quotes in text documents -*- coding: utf-8 -*-

;; Copyright (C) 2007 Martin Blais
;; Inspired by xmlunicode.el, Copyright (C) 2003 Norman Walsh

;; Author: Martin Blais <blais@furius.ca>
;; Maintainer: Martin Blais <blais@furius.ca>
;; Created: 2007-08-26
;; Version: 1.0
;; Keywords: utf-8 unicode characters

;; This file is NOT part of GNU emacs.

;; This is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.

;; This software is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 59 Temple Place - Suite 330,
;; Boston, MA 02111-1307, USA.

;;; Commentary

;; The functions provided by xmlunicode.el for the insertion of the fancy
;; unicode quotes (double and single) take into account the context of the
;; document for XML documents. Those quotes are more useful, in my experience,
;; in text files written in UTF-8 encoding, such as ReST syntax. The XML
;; functions from xmlunicode often do not work properly in text files, due to
;; the presence of the occasional < or > symbol.

;; Therefore, the smart insertion functions are difficult to use, because their
;; behavior is unpredictable. In accordance with The Humane Interface principles
;; (see J.Raskins' book), we provide context-independent versions of these
;; functions that are much easier to learn and use quickly, since their
;; behaviour is unambigous.

;;; Usage

;; To use the suggested bindings, insert this in your .emacs:

;;    (require 'smartquotes)
;;    (add-hook 'text-mode-hook 'text-mode-unicode-hook)

;; This does the following for text-mode bindings:

;; - C-" inserts then cycles through the fancier double quotes;

;; - C-' inserts then cycles through the fancier single quotes;

;; - Inserting four dots inserts an ellipsis character. Inserting an additional
;;   fourth dot resumes with a string of dots;

;; - Inserting four hyphens inserts an mdash (a long dash character), then an
;;   ndash (an inter-word dash character), and then resumes with a string of
;;   normal hyphens.

;;; Changes

;;; Code:

(defvar smartq-ldquo  (decode-char 'ucs #x00201c))
(defvar smartq-rdquo  (decode-char 'ucs #x00201d))
(defvar smartq-lsquo  (decode-char 'ucs #x002018))
(defvar smartq-rsquo  (decode-char 'ucs #x002019))
(defvar smartq-quot   (decode-char 'ucs #x000022))
(defvar smartq-apos   (decode-char 'ucs #x000027))
(defvar smartq-capos  (decode-char 'ucs #x0002bc))
(defvar smartq-ndash  (decode-char 'ucs #x002013))
(defvar smartq-mdash  (decode-char 'ucs #x002014))
(defvar smartq-hellip (decode-char 'ucs #x002026))

(defun smartq-cycle-chars (charlist)
  "Given that the last character is the given list, cycle the
  last char between the available characters in the list."
;;   (let ((ch (char-before)))
  (let ((newch (cadr (memq (char-before) 
			   (append charlist (list (car charlist)))))))
    (if newch
	(progn 
	  (delete-backward-char 1)
	  (insert newch))
      (insert (car charlist)))))

(defmacro smartq-cycle-fun (charlist)
  `(lambda ()
     (interactive)
     (smartq-cycle-chars ,charlist)))

(defvar smartq-smart-double-quotes
  (list smartq-ldquo smartq-rdquo))

(defvar smartq-smart-single-quotes
  (list smartq-lsquo smartq-rsquo smartq-capos))

(defun smartq-smart-period ()
  "Insert an hellipsis for four dots."
  (interactive)
  (if (> (point) 3)
      (let ((ch1 (char-before))
	    (ch2 (char-before (- (point) 1)))
	    (ch3 (char-before (- (point) 2)))
	    (ch4 (char-before (- (point) 3))))
	(cond
	 ((in-comment)
	  (insert "."))
	 ((char-equal ch1 smartq-hellip)
	  (progn
	    (delete-backward-char 1)
	    (insert "....")))
	 ((and ch3 
	       (char-equal ch1 ?.)
	       (char-equal ch2 ?.)
	       (char-equal ch3 ?.)
	       (char-equal ch4 ?.))
	  (insert "."))
	 ((and (char-equal ch1 ?.) 
	       (char-equal ch2 ?.)
	       (char-equal ch3 ?.))
	  (progn
	    (delete-backward-char 3)
	    (insert smartq-hellip)))
	 (t (insert "."))))
    (insert ".")))

(defun smartq-smart-hyphen ()
  "Insert mdash and ndash right after 3 hyphens."
  (interactive)
  (if (> (point) 3)
      (let ((ch1 (char-before))
	    (ch2 (char-before (- (point) 1)))
	    (ch3 (char-before (- (point) 2)))
	    (ch4 (char-before (- (point) 3))))
	(cond
	 ((in-comment)
	  (insert "-"))

	 ((char-equal ch1 smartq-mdash)
	  (progn
	    (delete-backward-char 1)
	    (insert smartq-ndash)))

	 ((char-equal ch1 smartq-ndash)
	  (progn
	    (delete-backward-char 1)
	    (insert "----")))

	 ((and ch4
	       (char-equal ch1 ?-)
	       (char-equal ch2 ?-)
	       (char-equal ch3 ?-)
	       (char-equal ch4 ?-))
	  (progn
	    (insert "-")))

	 ((and ch3
	       (char-equal ch1 ?-)
	       (char-equal ch2 ?-)
	       (char-equal ch3 ?-))
	  (progn
	    (delete-backward-char 3)
	    (insert smartq-mdash)))

	 (t (insert "-"))))
    (insert "-")))

(fset 'smartq-cycle-double-quotes
      (smartq-cycle-fun smartq-smart-double-quotes))

(fset 'smartq-cycle-single-quotes
      (smartq-cycle-fun smartq-smart-single-quotes))

(defun text-mode-smartquotes-hook ()
  (when (or (eq major-mode 'text-mode)
	    (eq major-mode 'rst-mode)
            )
    (local-set-key [(control \")] 'smartq-cycle-double-quotes)
    (local-set-key [(control \')] 'smartq-cycle-single-quotes)
    (local-set-key [(?.)] 'smartq-smart-period)
    (local-set-key [(?-)] 'smartq-smart-hyphen)
    ))

(provide 'smartquotes)

