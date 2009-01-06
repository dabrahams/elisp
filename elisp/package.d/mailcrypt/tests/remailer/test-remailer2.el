
;; Note: this is not an automated test. Because of the latencies involved
;; (minutes to days), these tests need to be run by an attentive human.

;; This file defines some useful functions for doing end-to-end tests of the
;; mailcrypt remailer interface. The sequence to follow is:
;;
;;  Setup: create a mail alias that will do Maildir-style delivery into
;;   $MAILCRYPT/tests/remailer/ddir/ . I use a .qmail-SUFFIX file to accomplish
;;   this.
;;
;;  Testing:
;;
;;   start ./gtkwatcher.py from this directory. That will watch both sdir/
;;   and ddir/
;;
;;   Compose a message. The message should include notes about which remailer
;;   chain you intend to use, and something to remind yourself what exactly
;;   you were planning to test with this message.
;;
;;   Hit C-c / t (mc-test-remailer-annotate). This will pick a new sequence
;;   number, append a line to the message with the following format:
;;    MailcryptRemailerMessageId=NNNN
;;   and then use 'safecat' to put a copy of the (plaintext) message into
;;   sdir/ . At this point, gtkwatcher.py will list your message as
;;   'outstanding'.
;;
;;   Use mailcrypt as usual to encrypt the message for a remailer chain, and
;;   send it.
;;
;;   When the message finally makes it through the chain, your alias will drop
;;   it into ddir/, and gtkwatcher.py will notice it, moving it from the
;;   'outstanding' list into the 'received' list, with a note about how much
;;   latency was involved.
;;
;;   If something goes wrong, the message will remain in the 'outstanding'
;;   list forever (until you manually delete the file).

(defvar mc-test-remailer-safecat-prog "safecat")
(defvar mc-test-remailer-sdir "sdir"
  "Annotated messages are placed in a Maildir under this directory. It should
be an absolute path to the maildir, because it will be used from buffers that
are based in other directories.")

(defun mc-test-remailer-safecat-buffer ()
  (let* (
        (start (point-min)) (end (point-max))
        (maildir-tmpdir (concat mc-test-remailer-sdir "/tmp"))
        (maildir-newdir (concat mc-test-remailer-sdir "/new"))
        (cmd (format "%s %s %s" mc-test-remailer-safecat-prog
                     maildir-tmpdir maildir-newdir))
        )
    ;; dump the current buffer (or parts of it?) into |cmd
    ;(message "dirs %s %s" maildir-tmpdir maildir-newdir)
    (shell-command-on-region start end cmd)
    ))

(defvar mc-test-remailer-seqnum 0)
(defun mc-test-remailer-get-seqnum ()
  (setq mc-test-remailer-seqnum (+ mc-test-remailer-seqnum 1)))

(defun mc-test-remailer-annotate ()
  "*Mark the current message with a sequence number, then feed to sdir/"
  (interactive)
  (let ((note (format "\nMailcryptRemailerMessageId=%d\n"
                      (mc-test-remailer-get-seqnum)))
        )
    ;; append note to the current buffer
    (save-excursion
      (goto-char (point-max))
      (insert note)
      ;; feed it to sdir/
      (mc-test-remailer-safecat-buffer)
      )
    ))

;; bind C-c / t (in mew-write mode) to mc-test-remailer-annotate
(define-key mc-write-mode-map "\C-c/t" 'mc-test-remailer-annotate)
