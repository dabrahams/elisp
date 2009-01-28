;;; my-loaddefs.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads (run-at-time) "FSF-timer" "../package.d/mailcrypt/FSF-timer.el"
;;;;;;  (18787 56325))
;;; Generated autoloads from ../package.d/mailcrypt/FSF-timer.el

(autoload 'run-at-time "FSF-timer" "\
Run a function at a time, and optionally on a regular interval.
Arguments are TIME, REPEAT, FUNCTION &rest ARGS.
TIME, a string, can be specified absolutely or relative to now.
TIME can also be an integer, a number of seconds.
REPEAT, an integer number of seconds, is the interval on which to repeat
the call to the function.  If REPEAT is nil or 0, call it just once.

Absolute times may be specified in a wide variety of formats;
Something of the form `HOUR:MIN:SEC TIMEZONE MONTH/DAY/YEAR', where
all fields are numbers, works; the format used by the Unix `date'
command works too.

Relative times may be specified as a series of numbers followed by units:
  1 min         	denotes one minute from now.
  min			does too.
  1 min 5 sec		denotes 65 seconds from now.
  1 min 2 sec 3 hour 4 day 5 week 6 fortnight 7 month 8 year
			denotes the sum of all the given durations from now.

\(fn TIME REPEAT FUNCTION &rest ARGS)" t nil)

;;;***

;;;### (autoloads (bbdb-insinuate-message bbdb-initialize bbdb-multiple-buffers
;;;;;;  bbdb-submit-bug-report) "bbdb" "../package.d/bbdb/lisp/bbdb.el"
;;;;;;  (18397 42911))
;;; Generated autoloads from ../package.d/bbdb/lisp/bbdb.el

(autoload 'bbdb-submit-bug-report "bbdb" "\
Submit a bug report, with pertinent information to the BBDB info list.

\(fn)" t nil)

(defvar bbdb-multiple-buffers nil "\
When non-nil we create a new buffer of every buffer causing pop-ups.
You can also set this to a function returning a buffer name.")

(custom-autoload 'bbdb-multiple-buffers "bbdb" t)

(autoload 'bbdb-initialize "bbdb" "\
*Initialize the BBDB.  One or more of the following symbols can be
passed as arguments to initiate the appropriate insinuations.

 Initialization of mail/news readers:

   gnus       Initialize BBDB support for the gnus mail/news reader
              version 3.15 or newer.  If you pass the `gnus' symbol,
              you should probably also pass the `message' symbol.
   mh-e       Initialize BBDB support for the MH-E mail reader.
   rmail      Initialize BBDB support for the RMAIL mail reader.
   sendmail   Initialize BBDB support for sendmail (M-x mail).
   vm         Initialize BBDB support for the VM mail reader.
              NOTE: For the VM insinuation to work properly, you must
              either call `bbdb-initialize' with the `vm' symbol from
              within your VM initialization file (\"~/.vm\") or you
              must call `bbdb-insinuate-vm' manually from within your
              VM initialization file.

 Initialization of miscellaneous package:

   message    Initialize BBDB support for Message mode.
   reportmail Initialize BBDB support for the Reportmail mail
              notification package.
   sc or      Initialize BBDB support for the Supercite message
   supercite  citation package.
   w3         Initialize BBDB support for Web browsers.

\(fn &rest TO-INSINUATE)" nil nil)

(autoload 'bbdb-insinuate-message "bbdb" "\
Call this function to hook BBDB into `message-mode'.

\(fn)" nil nil)

;;;***

;;;### (autoloads (bbdb-include-anniversaries bbdb-anniversaries
;;;;;;  bbdb-utilities-anniversaries) "bbdb-anniv" "../package.d/bbdb/bits/bbdb-anniv.el"
;;;;;;  (15006 27895))
;;; Generated autoloads from ../package.d/bbdb/bits/bbdb-anniv.el

(let ((loads (get 'bbdb-utilities-anniversaries 'custom-loads))) (if (member '"bbdb-anniv" loads) nil (put 'bbdb-utilities-anniversaries 'custom-loads (cons '"bbdb-anniv" loads))))

(defvar bbdb-anniversaries nil "\
Should BBDB anniversaries be included when the diary is displayed (fancy)?
You must modify via \\[customize] for this variable to have an effect.")

(custom-autoload 'bbdb-anniversaries "bbdb-anniv" nil)

(autoload 'bbdb-include-anniversaries "bbdb-anniv" "\
Not documented

\(fn)" nil nil)

;;;***

;;;### (autoloads (bbdb-get-only-first-address-p bbdb-get-addresses-headers
;;;;;;  bbdb-update-records bbdb-update-records-mode bbdb-help bbdb-info
;;;;;;  bbdb-creation-no-change bbdb-creation-newer bbdb-creation-older
;;;;;;  bbdb-timestamp-newer bbdb-timestamp-older bbdb-finger bbdb-dial
;;;;;;  bbdb-add-or-remove-mail-alias bbdb-define-all-aliases bbdb-yank
;;;;;;  bbdb-complete-name bbdb-read-addresses-with-completion bbdb-completion-predicate
;;;;;;  bbdb-completion-check-record bbdb-show-all-recipients bbdb-send-mail
;;;;;;  bbdb-dwim-net-address bbdb-sort-addresses bbdb-sort-phones
;;;;;;  bbdb-sort-notes bbdb-refile-record bbdb-omit-record bbdb-display-record-with-layout
;;;;;;  bbdb-display-record-completely bbdb-display-all-records-completely
;;;;;;  bbdb-toggle-records-display-layout bbdb-toggle-all-records-display-layout
;;;;;;  bbdb-delete-current-record bbdb-delete-current-field-or-record
;;;;;;  bbdb-transpose-fields bbdb-record-edit-property bbdb-record-edit-notes
;;;;;;  bbdb-edit-current-field bbdb-insert-new-field bbdb-append-records
;;;;;;  bbdb-append-records-p bbdb-apply-next-command-to-all-records
;;;;;;  bbdb-create bbdb-redisplay-records bbdb-changed bbdb-notes
;;;;;;  bbdb-net bbdb-company bbdb-name bbdb bbdb-search-invert-set)
;;;;;;  "bbdb-com" "../package.d/bbdb/lisp/bbdb-com.el" (18397 42930))
;;; Generated autoloads from ../package.d/bbdb/lisp/bbdb-com.el

(autoload 'bbdb-search-invert-set "bbdb-com" "\
Typing \\<bbdb-mode-map>\\[bbdb-search-invert-set] inverts the meaning of the next search command.
Sets `bbdb-search-invert' to t.
You will have to call this function again, if you want to
do repeated inverted searches.

\(fn)" t nil)

(autoload 'bbdb "bbdb-com" "\
Display all entries in the BBDB matching the regexp STRING
in either the name(s), company, network address, or notes.

\(fn STRING ELIDEP)" t nil)

(autoload 'bbdb-name "bbdb-com" "\
Display all entries in the BBDB matching the regexp STRING in the name
\(or ``alternate'' names).

\(fn STRING ELIDEP)" t nil)

(autoload 'bbdb-company "bbdb-com" "\
Display all entries in BBDB matching STRING in the company field.

\(fn STRING ELIDEP)" t nil)

(autoload 'bbdb-net "bbdb-com" "\
Display all entries in BBDB matching regexp STRING in the network address.

\(fn STRING ELIDEP)" t nil)

(autoload 'bbdb-notes "bbdb-com" "\
Display all entries in BBDB matching STRING in the named notes field.

\(fn WHICH STRING ELIDEP)" t nil)

(autoload 'bbdb-changed "bbdb-com" "\
Display all entries in the bbdb database which have been changed since
the database was last saved.

\(fn ELIDEP)" t nil)

(autoload 'bbdb-redisplay-records "bbdb-com" "\
Regrinds the contents of the *BBDB* buffer, without scrolling.
If possible, you should call `bbdb-redisplay-one-record' instead.

\(fn)" nil nil)

(autoload 'bbdb-create "bbdb-com" "\
Add a new entry to the bbdb database ; prompts for all relevant info
using the echo area, inserts the new record in the db, sorted alphabetically,
and offers to save the db file.  DO NOT call this from a program.  Call
bbdb-create-internal instead.

\(fn RECORD)" t nil)

(autoload 'bbdb-apply-next-command-to-all-records "bbdb-com" "\
Typing \\<bbdb-mode-map>\\[bbdb-apply-next-command-to-all-records] in the *BBDB* buffer makes the next command operate on all
of the records currently displayed.  (Note that this only works for
certain commands.)

\(fn)" t nil)

(autoload 'bbdb-append-records-p "bbdb-com" "\
Not documented

\(fn)" nil nil)

(autoload 'bbdb-append-records "bbdb-com" "\
Typing \\<bbdb-mode-map>\\[bbdb-append-records] in the *BBDB* buffer makes the next search/display command to append
new records to those in the *BBDB* buffer.

With an prefix arg (C-u) toggle between always append and no append.
With an prefix arg that is a positive number append will be enabled for that
many times.
With any other argument append will be enabled once.

\(fn ARG)" t nil)

(autoload 'bbdb-insert-new-field "bbdb-com" "\
Add a new field to the current record; the field type and contents
are prompted for if not supplied.

If you are inserting a new phone-number field, you can control whether
it is a north american or european phone number by providing a prefix
argument.  A prefix arg of ^U means it's to be a euronumber, and any
other prefix arg means it's to be a a structured north american number.
Otherwise, which style is used is controlled by the variable
`bbdb-north-american-phone-numbers-p'.

If you are inserting a new net address, you can have BBDB append a
default domain to any net address that does not contain one.  Set
`bbdb-default-domain' to a string such as \"mycompany.com\" (or,
depending on your environment, (getenv \"DOMAINNAME\")), and
\"@mycompany.com\" will be appended to an address that is entered as
just a username.  A prefix arg of ^U (or a `bbdb-default-domain'
value of \"\", the default) means do not alter the address.

\(fn RECORD NAME CONTENTS)" t nil)

(autoload 'bbdb-edit-current-field "bbdb-com" "\
Edit the contents of the Insidious Big Brother Database field displayed on
the current line (this is only meaningful in the \"*BBDB*\" buffer.)   If the
cursor is in the middle of a multi-line field, such as an address or comments
section, then the entire field is edited, not just the current line.

\(fn)" t nil)

(autoload 'bbdb-record-edit-notes "bbdb-com" "\
Not documented

\(fn BBDB-RECORD &optional REGRIND)" t nil)

(autoload 'bbdb-record-edit-property "bbdb-com" "\
Not documented

\(fn BBDB-RECORD &optional PROP REGRIND)" t nil)

(autoload 'bbdb-transpose-fields "bbdb-com" "\
This is like the `transpose-lines' command, but it is for BBDB fields.
If the cursor is on a field of a BBDB record, that field and the previous
field will be transposed.

With argument ARG, takes previous line and moves it past ARG fields.
With argument 0, interchanges field point is in with field mark is in.

Both fields must be in the same record, and must be of the same basic type
\(that is, you can use this command to change the order in which phone-number
fields are listed, but you can't use it to make an address appear before a
phone number; the order of field types is fixed.)

\(fn &optional ARG)" t nil)

(autoload 'bbdb-delete-current-field-or-record "bbdb-com" "\
Delete the line which the cursor is on; actually, delete the field which
that line represents from the database.  If the cursor is on the first line
of a database entry (the name/company line) then the entire entry will be
deleted.

\(fn &optional RECORDS NOPROMPT)" t nil)

(autoload 'bbdb-delete-current-record "bbdb-com" "\
Delete the entire bbdb database entry which the cursor is within.
Pressing \\<bbdb-mode-map>\\[bbdb-apply-next-command-to-all-records] will
delete all records listed in the BBDB buffer.

\(fn RECS &optional NOPROMPT)" t nil)

(autoload 'bbdb-toggle-all-records-display-layout "bbdb-com" "\
Show all the fields of all visible records.
Like `bbdb-toggle-records-display-layout' but for all visible records.

\(fn ARG &optional RECORDS)" t nil)

(autoload 'bbdb-toggle-records-display-layout "bbdb-com" "\
Toggle whether the current record is displayed expanded or elided
\(multi-line or one-line display.)  With a numeric argument of 0, the
current record will unconditionally be made elided; with any other argument,
the current record will unconditionally be shown expanded.
\\<bbdb-mode-map>
If \"\\[bbdb-apply-next-command-to-all-records]\\[bbdb-toggle-records-display-layout]\" is used instead of simply \"\\[bbdb-toggle-records-display-layout]\", then the state of all records will
be changed instead of just the one at point.  In this case, an argument
of 0 means that all records will unconditionally be made elided; any other
numeric argument means that all of the records will unconditionally be shown
expanded; and no numeric argument means that the records are made to be in
the opposite state of the record under point.

\(fn ARG)" t nil)

(autoload 'bbdb-display-all-records-completely "bbdb-com" "\
Show all the fields of all currently displayed records.
The display layout `full-multi-line' is used for this.

\(fn ARG &optional RECORDS)" t nil)

(autoload 'bbdb-display-record-completely "bbdb-com" "\
Show all the fields of the current record.
The display layout `full-multi-line' is used for this.

\(fn ARG)" t nil)

(autoload 'bbdb-display-record-with-layout "bbdb-com" "\
Show all the fields of the current record using LAYOUT.

\(fn LAYOUT &optional RECORDS)" t nil)

(autoload 'bbdb-omit-record "bbdb-com" "\
Remove the current record from the display without deleting it from the
database.  With a prefix argument, omit the next N records.  If negative,
omit backwards.

\(fn N)" t nil)

(autoload 'bbdb-refile-record "bbdb-com" "\
Merge the current record into some other record; that is, delete the
record under point after copying all of the data within it into some other
record.  this is useful if you realize that somehow a redundant record has
gotten into the database, and you want to merge it with another.

If both records have names and/or companies, you are asked which to use.
Phone numbers, addresses, and network addresses are simply concatenated.
The first record is the record under the point; the second is prompted for.
Completion behaviour is as dictated by the variable `bbdb-completion-type'.

\(fn OLD-RECORD NEW-RECORD)" t nil)

(autoload 'bbdb-sort-notes "bbdb-com" "\
Sort the notes in the record according to `bbdb-notes-sort-order'.
Can be used in `bbdb-change-hook'.

\(fn REC)" nil nil)

(autoload 'bbdb-sort-phones "bbdb-com" "\
Sort the phones in the record according to the location.
Can be used in `bbdb-change-hook'.

\(fn REC)" nil nil)

(autoload 'bbdb-sort-addresses "bbdb-com" "\
Sort the addresses in the record according to the location.
Can be used in `bbdb-change-hook'.

\(fn REC)" nil nil)

(autoload 'bbdb-dwim-net-address "bbdb-com" "\
Return a string to use as the email address of the given record.
It is formatted like \"Firstname Lastname <addr>\" unless both the first name
and last name are constituents of the address, as in John.Doe@SomeHost, or the
address is already in the form \"Name <foo>\" or \"foo (Name)\", in which case
the address is used as-is.

If the record has the field 'mail-name it is used instead of the record's name.

If `bbdb-dwim-net-address-allow-redundancy' is non-nil, the name is always
included.  If `bbdb-dwim-net-address-allow-redundancy' is 'netonly the name is
never included!

A title is prepended from the field `bbdb-dwim-net-address-title-field' if it
exists.

\(fn RECORD &optional NET)" nil nil)

(autoload 'bbdb-send-mail "bbdb-com" "\
Compose a mail message to the person indicated by the current bbdb record.
The first (most-recently-added) address is used if there are more than one.
\\<bbdb-mode-map>
If \"\\[bbdb-apply-next-command-to-all-records]\\[bbdb-send-mail]\" is used instead of simply \"\\[bbdb-send-mail]\", then mail will be sent to all of the
folks listed in the *BBDB* buffer instead of just the person at point.

\(fn BBDB-RECORD &optional SUBJECT)" t nil)

(autoload 'bbdb-show-all-recipients "bbdb-com" "\
*Display BBDB records for all recipients of the message in this buffer.

\(fn)" t nil)

(autoload 'bbdb-completion-check-record "bbdb-com" "\
Not documented

\(fn SYM REC)" nil nil)

(autoload 'bbdb-completion-predicate "bbdb-com" "\
For use as the third argument to `completing-read'.
Obey the semantics of `bbdb-completion-type'.

\(fn SYMBOL)" nil nil)

(autoload 'bbdb-read-addresses-with-completion "bbdb-com" "\
Like `read-string', but allows `bbdb-complete-name' style completion.

\(fn PROMPT &optional DEFAULT)" nil nil)

(autoload 'bbdb-complete-name "bbdb-com" "\
Complete the user full-name or net-address before point (up to the
preceeding newline, colon, or comma, or the value of START-POS).  If
what has been typed is unique, insert an entry of the form \"User Name
<net-addr>\" (although see documentation for
bbdb-dwim-net-address-allow-redundancy).  If it is a valid completion
but not unique, a list of completions is displayed.

If the completion is done and `bbdb-complete-name-allow-cycling' is
true then cycle through the nets for the matching record.

When called with a prefix arg then display a list of all nets.

Completion behaviour can be controlled with `bbdb-completion-type'.

\(fn &optional START-POS)" t nil)

(autoload 'bbdb-yank "bbdb-com" "\
Insert the current contents of the *BBDB* buffer at point.

\(fn)" t nil)

(autoload 'bbdb-define-all-aliases "bbdb-com" "\
Define mail aliases for some of the records in the database.
Every record which has a `mail-alias' field (but see
`bbdb-define-all-aliases-field') will have a mail alias defined for it
which is the contents of that field.  If there are multiple
comma-separated words in this field, then all of those words will be
defined as aliases for that record.

If multiple entries in the database have the same mail alias, then
that alias expands to a comma-separated list of the primary network
addresses of all of those people.

An alias ending in \"*\" will expand to all the nets of the record.
An alias ending in \"[NTH]\" will expand the the NTH net of the
record.

Special nets exist and expand to other nets using one of
`bbdb-magic-net-*', `bbdb-magic-net-1' or `bbdb-magic-net-SOMETHING'.
Magic nets may not contain any comma character. If you need one, please
put it into a custom magic net function or use the octal escape
sequence \"\\054\".

Nets matching \"FUNCTION/ARG\" (i.e. containing at least one \"/\")
will be passed to the function `bbdb-magic-net-FUNCTION' with the
string argument ARG.

Nets starting with a \"(\" will be considered as a lisp list where the
first element is prefixed by `bbdb-magic-net-' and then called as a
function with the rest of the list as arguments.

Nets which do not contain an \"@\" character and also exist as aliases
are expanded recursively.  This can be used to define hierarchical
aliases.

Other nets are formatted by `bbdb-dwim-net-address'.

\(fn)" t nil)

(autoload 'bbdb-add-or-remove-mail-alias "bbdb-com" "\
Add NEWALIAS in all RECORDS or remove it if DELETE it t.
When called with prefix argument it will remove the alias.
We honor `bbdb-apply-next-command-to-all-records'!
The new alias will only be added if it isn't there yet.

\(fn &optional RECORDS NEWALIAS DELETE)" t nil)

(autoload 'bbdb-dial "bbdb-com" "\
Dial the number at point.
If the point is at the beginning of a record, dial the first
phone number.  Does not dial the extension.  Does not apply the
transformations from bbdb-dial-local-prefix-alist if a prefix arg
is given.

\(fn PHONE FORCE-AREA-CODE)" t nil)

(autoload 'bbdb-finger "bbdb-com" "\
Finger the network address of a BBDB record.
If this command is executed from the *BBDB* buffer, finger the network
address of the record at point; otherwise, it prompts for a user.
With a numeric prefix argument, finger the Nth network address of the
current record; with a prefix argument of ^U, finger all of them.
The *finger* buffer is filled asynchronously, meaning that you don't
have to wait around for it to finish; but fingering another user before
the first finger has finished could have unpredictable results.
\\<bbdb-mode-map>
If this command is executed from the *BBDB* buffer, it may be prefixed
with \"\\[bbdb-apply-next-command-to-all-records]\" (as in \"\\[bbdb-apply-next-command-to-all-records]\\[bbdb-finger]\" instead of simply \"\\[bbdb-finger]\"), meaning to finger all of
the users currently listed in the *BBDB* buffer instead of just the one
at point.  The numeric prefix argument has the same interpretation.

You can define a special network address to \"finger\" by defining a
field `finger-host' (default value of `bbdb-finger-host-field').

\(fn RECORD &optional WHICH-ADDRESS)" t nil)

(autoload 'bbdb-timestamp-older "bbdb-com" "\
*Display records with timestamp older than DATE.
DATE must be in yyyy-mm-dd format.

\(fn DATE)" t nil)

(autoload 'bbdb-timestamp-newer "bbdb-com" "\
*Display records with timestamp newer than DATE.
DATE must be in yyyy-mm-dd format.

\(fn DATE)" t nil)

(autoload 'bbdb-creation-older "bbdb-com" "\
*Display records with creation-date older than DATE.
DATE must be in yyyy-mm-dd format.

\(fn DATE)" t nil)

(autoload 'bbdb-creation-newer "bbdb-com" "\
*Display records with creation-date newer than DATE.
DATE must be in yyyy-mm-dd format.

\(fn DATE)" t nil)

(autoload 'bbdb-creation-no-change "bbdb-com" "\
*Display records that have the same timestamp and creation-date.

\(fn)" t nil)

(autoload 'bbdb-info "bbdb-com" "\
Not documented

\(fn)" t nil)

(autoload 'bbdb-help "bbdb-com" "\
Not documented

\(fn)" t nil)

(defvar bbdb-update-records-mode 'annotating "\
Controls how `bbdb-update-records' processes email addresses.
Set this to an expression which evaluates either to 'searching or
'annotating.  When set to 'annotating email addresses will be fed to
`bbdb-annotate-message-sender' in order to update existing records or create
new ones.  A value of 'searching will search just for existing records having
the right net.

There is a version of this variable for each MUA, which overrides this variable
when set!

This variable is also used for inter-function communication between the
functions `bbdb-update-records' and `bbdb-prompt-for-create'.")

(custom-autoload 'bbdb-update-records-mode "bbdb-com" t)

(autoload 'bbdb-update-records "bbdb-com" "\
Returns the records corresponding to the list of addresses ADDRS,
creating or modifying them as necessary.  A record will be created if
AUTO-CREATE-P is non-nil or if OFFER-TO-CREATE is true and the user
confirms the creation.

`bbdb-update-records-mode' controls if records are updated or not.
A MUA specific variable, e.g. `bbdb/vm-update-records-mode', can
overwrite this.

See also `bbdb-get-only-first-address-p' to limit the update to the
sender of the message.

When hitting C-g once you will not be asked any more for new people listed
in this message, but it will search only for existing records.  When hitting
C-g again it will stop scanning.

\(fn ADDRS AUTO-CREATE-P OFFER-TO-CREATE)" nil nil)

(defvar bbdb-get-addresses-headers '((authors "From" "Resent-From" "Reply-To") (recipients "Resent-To" "Resent-CC" "To" "CC" "BCC")) "\
*List of headers to search for senders and recipients email addresses.
The headers are grouped into two classes, the authors and the senders headers.")

(custom-autoload 'bbdb-get-addresses-headers "bbdb-com" t)

(defvar bbdb-get-only-first-address-p nil "\
*If t `bbdb-update-records' will return only the first one.
Changing this variable will show its effect only after clearing the
`bbdb-message-cache' of a folder or closing and visiting it again.")

(custom-autoload 'bbdb-get-only-first-address-p "bbdb-com" t)

;;;***

;;;### (autoloads (bbdb-field-edit-del bbdb-field-edit-add) "bbdb-edit"
;;;;;;  "../package.d/bbdb/bits/bbdb-edit.el" (14977 21490))
;;; Generated autoloads from ../package.d/bbdb/bits/bbdb-edit.el

(autoload 'bbdb-field-edit-add "bbdb-edit" "\
Add VALUE to FIELD of bbdb-record(s).

\(fn BBDB-RECORD FIELD VALUE)" t nil)

(autoload 'bbdb-field-edit-del "bbdb-edit" "\
Delete VALUE to FIELD of bbdb-record(s).
If prefix arg exists, delete all existing field values matching VALUE(regexp).

\(fn BBDB-RECORD FIELD VALUE)" t nil)

;;;***

;;;### (autoloads (bbdb-create-ftp-site bbdb-ftp) "bbdb-ftp" "../package.d/bbdb/lisp/bbdb-ftp.el"
;;;;;;  (18011 20884))
;;; Generated autoloads from ../package.d/bbdb/lisp/bbdb-ftp.el

(autoload 'bbdb-ftp "bbdb-ftp" "\
Use ange-ftp to open an ftp-connection to a BBDB record's name.
If this command is executed from the *BBDB* buffer, ftp the site of
the record at point; otherwise, it prompts for an ftp-site.

\(fn BBDB-RECORD &optional WHICH)" t nil)

(autoload 'bbdb-create-ftp-site "bbdb-ftp" "\
Add a new ftp-site entry to the bbdb database.
Prompts for all relevant info using the echo area,
inserts the new record in the db, sorted alphabetically.

\(fn RECORD)" t nil)

;;;***

;;;### (autoloads (bbdb-insinuate-gnus bbdb/gnus-summary-show-all-recipients
;;;;;;  bbdb/gnus-score bbdb/gnus-snarf-signature bbdb/gnus-show-all-recipients
;;;;;;  bbdb/gnus-show-records bbdb/gnus-annotate-sender bbdb/gnus-update-records
;;;;;;  bbdb/gnus-update-record) "bbdb-gnus" "../package.d/bbdb/lisp/bbdb-gnus.el"
;;;;;;  (18389 44231))
;;; Generated autoloads from ../package.d/bbdb/lisp/bbdb-gnus.el

(autoload 'bbdb/gnus-update-record "bbdb-gnus" "\
Return the record corresponding to the current Gnus message, creating
or modifying it as necessary.  A record will be created if
bbdb/news-auto-create-p is non-nil, or if OFFER-TO-CREATE is true and
the user confirms the creation.

\(fn &optional OFFER-TO-CREATE)" nil nil)

(autoload 'bbdb/gnus-update-records "bbdb-gnus" "\
Return the records corresponding to the current Gnus message, creating
or modifying it as necessary.  A record will be created if
`bbdb/news-auto-create-p' is non-nil or if OFFER-TO-CREATE is true
and the user confirms the creation.

The variable `bbdb/gnus-update-records-mode' controls what actions
are performed and it might override `bbdb-update-records-mode'.

When hitting C-g once you will not be asked anymore for new people listed
in this message, but it will search only for existing records.  When hitting
C-g again it will stop scanning.

\(fn &optional OFFER-TO-CREATE)" nil nil)

(autoload 'bbdb/gnus-annotate-sender "bbdb-gnus" "\
Add a line to the end of the Notes field of the BBDB record
corresponding to the sender of this message.  If REPLACE is non-nil,
replace the existing notes entry (if any).

\(fn STRING &optional REPLACE)" t nil)

(autoload 'bbdb/gnus-show-records "bbdb-gnus" "\
Display the contents of the BBDB for all addresses of this message.
This buffer will be in `bbdb-mode', with associated keybindings.

\(fn &optional ADDRESS-CLASS)" t nil)

(autoload 'bbdb/gnus-show-all-recipients "bbdb-gnus" "\
Show all recipients of this message. Counterpart to `bbdb/vm-show-sender'.

\(fn)" t nil)

(autoload 'bbdb/gnus-snarf-signature "bbdb-gnus" "\
Snarf signature from the corresponding *Article* buffer.

\(fn)" t nil)

(autoload 'bbdb/gnus-score "bbdb-gnus" "\
This returns a score alist for Gnus.  A score pair will be made for
every member of the net field in records which also have a gnus-score
field.  This allows the BBDB to serve as a supplemental global score
file, with the advantage that it can keep up with multiple and changing
addresses better than the traditionally static global scorefile.

\(fn GROUP)" nil nil)

(autoload 'bbdb/gnus-summary-show-all-recipients "bbdb-gnus" "\
Display BBDB records for all recipients of the message.

\(fn NOT-ELIDED)" t nil)

(autoload 'bbdb-insinuate-gnus "bbdb-gnus" "\
Call this function to hook BBDB into Gnus.

\(fn)" nil nil)

;;;***

;;;### (autoloads (bbdb-menu bbdb-fontify-buffer) "bbdb-gui" "../package.d/bbdb/lisp/bbdb-gui.el"
;;;;;;  (17961 17312))
;;; Generated autoloads from ../package.d/bbdb/lisp/bbdb-gui.el

(autoload 'bbdb-fontify-buffer "bbdb-gui" "\
Not documented

\(fn &optional RECORDS)" t nil)

(autoload 'bbdb-menu "bbdb-gui" "\
Not documented

\(fn EVENT)" t nil)

;;;***

;;;### (autoloads (bbdb-force-record-create sample-bbdb-canonicalize-net-hook
;;;;;;  bbdb-auto-notes-hook bbdb-ignore-some-messages-hook bbdb-ignore-selected-messages-hook
;;;;;;  bbdb-ignore-most-messages-hook bbdb-extract-field-value bbdb-header-start
;;;;;;  bbdb-creation-date-hook bbdb-timestamp-hook) "bbdb-hooks"
;;;;;;  "../package.d/bbdb/lisp/bbdb-hooks.el" (18011 20885))
;;; Generated autoloads from ../package.d/bbdb/lisp/bbdb-hooks.el

(autoload 'bbdb-timestamp-hook "bbdb-hooks" "\
For use as a `bbdb-change-hook'; maintains a notes-field called `timestamp'
for the given record which contains the time when it was last modified.  If
there is such a field there already, it is changed, otherwise it is added.

\(fn RECORD)" nil nil)

(autoload 'bbdb-creation-date-hook "bbdb-hooks" "\
For use as a `bbdb-create-hook'; adds a notes-field called `creation-date'
which is the current time string.

\(fn RECORD)" nil nil)

(autoload 'bbdb-header-start "bbdb-hooks" "\
Returns a marker at the beginning of the header block of the current
message.  This will not necessarily be in the current buffer.

\(fn)" nil nil)

(autoload 'bbdb-extract-field-value "bbdb-hooks" "\
Given the name of a field (like \"Subject\") this returns the value of
that field in the current message, or nil.  This works whether you're in
Gnus, Rmail, or VM.  This works on multi-line fields, but if more than
one field of the same name is present, only the last is returned.  It is
expected that the current buffer has a message in it, and (point) is at the
beginning of the message headers.

\(fn FIELD-NAME)" nil nil)

(autoload 'bbdb-ignore-most-messages-hook "bbdb-hooks" "\
For use as the value of bbdb/news-auto-create-p or bbdb/mail-auto-create-p.
This will automatically create BBDB entries for messages which match
the bbdb-ignore-most-messages-alist (which see) and *no* others.

\(fn &optional INVERT-SENSE)" nil nil)

(autoload 'bbdb-ignore-selected-messages-hook "bbdb-hooks" "\
For use as a bbdb/news-auto-create-hook or bbdb/mail-auto-create-hook.
This will automatically create BBDB entries for messages based on a
combination of bbdb-ignore-some-messages-alist and
bbdb-ignore-most-messages-alist.  It first looks at the SOME list.  If
that doesn't disqualify a message, then it looks at the MOST list.  If
that qualifies the message, the record is auto-created, but a
confirmation is conditionally sought, based on the value of
`bbdb-ignore-selected-messages-confirmation'.

\(fn)" nil nil)

(autoload 'bbdb-ignore-some-messages-hook "bbdb-hooks" "\
For use as a `bbdb/news-auto-create-hook' or `bbdb/mail-auto-create-hook'.
This will automatically create BBDB entries for messages which do *not*
match the `bbdb-ignore-some-messages-alist' (which see).

\(fn)" nil nil)

(autoload 'bbdb-auto-notes-hook "bbdb-hooks" "\
For use as a `bbdb-notice-hook'.  This might automatically add some text
to the notes field of the BBDB record corresponding to the current record
based on the header of the current message.  See the documentation for
the variables `bbdb-auto-notes-alist' and `bbdb-auto-notes-ignore'.

\(fn RECORD)" nil nil)

(autoload 'sample-bbdb-canonicalize-net-hook "bbdb-hooks" "\
Not documented

\(fn ADDR)" nil nil)

(autoload 'bbdb-force-record-create "bbdb-hooks" "\
Force automatic creation of a BBDB records for the current message.
You might add this to the reply hook of your MUA in order to automatically
get records added for those people you reply to.

\(fn)" t nil)

;;;***

;;;### (autoloads (bbdb-merge-file bbdb-merge-record) "bbdb-merge"
;;;;;;  "../package.d/bbdb/lisp/bbdb-merge.el" (17865 1144))
;;; Generated autoloads from ../package.d/bbdb/lisp/bbdb-merge.el

(autoload 'bbdb-merge-record "bbdb-merge" "\
Generic merge function.

Merges new-record into your bbdb, using DATE to check who's more
up-to-date and OVERRIDE to decide who gets precedence if two dates
match. DATE can be extracted from a notes if it's an alist with an
element marked timestamp. Set OVERRIDE to 'new to allow the new record
to stomp on existing data, 'old to preserve existing data or nil to
merge both together. If it can't find a record to merge with, it will
create a new record. If MERGE-RECORD is set, it's a record discovered
by other means that should be merged with.

Returns the Grand Unified Record.

\(fn NEW-RECORD &optional MERGE-RECORD OVERRIDE)" nil nil)

(autoload 'bbdb-merge-file "bbdb-merge" "\
Merge a bbdb file into the in-core bbdb.

\(fn &optional BBDB-NEW OVERRIDE MATCH-FUN)" t nil)

;;;***

;;;### (autoloads (bbdb-insinuate-mh bbdb/mh-show-sender bbdb/mh-annotate-sender
;;;;;;  bbdb/mh-update-record) "bbdb-mhe" "../package.d/bbdb/lisp/bbdb-mhe.el"
;;;;;;  (17967 44425))
;;; Generated autoloads from ../package.d/bbdb/lisp/bbdb-mhe.el

(autoload 'bbdb/mh-update-record "bbdb-mhe" "\
Returns the record corresponding to the current MH message, creating or
modifying it as necessary.  A record will be created if
bbdb/mail-auto-create-p is non-nil, or if OFFER-TO-CREATE is true and
the user confirms the creation.

\(fn &optional OFFER-TO-CREATE)" nil nil)

(autoload 'bbdb/mh-annotate-sender "bbdb-mhe" "\
Add a line to the end of the Notes field of the BBDB record
corresponding to the sender of this message.  If REPLACE is non-nil,
replace the existing notes entry (if any).

\(fn STRING &optional REPLACE)" t nil)

(autoload 'bbdb/mh-show-sender "bbdb-mhe" "\
Display the contents of the BBDB for the sender of this message.
This buffer will be in bbdb-mode, with associated keybindings.

\(fn)" t nil)

(autoload 'bbdb-insinuate-mh "bbdb-mhe" "\
Call this function to hook BBDB into MH-E.

\(fn)" nil nil)

;;;***

;;;### (autoloads (bbdb-migrate-update-file-version bbdb-migrate-rewrite-all
;;;;;;  bbdb-unmigrate-record bbdb-migrate bbdb-migration-query)
;;;;;;  "bbdb-migrate" "../package.d/bbdb/lisp/bbdb-migrate.el" (18011
;;;;;;  20885))
;;; Generated autoloads from ../package.d/bbdb/lisp/bbdb-migrate.el

(autoload 'bbdb-migration-query "bbdb-migrate" "\
Ask if the database is to be migrated.
ONDISK is the version number of the database as currently stored on
disk.  Returns the version for the saved database.

\(fn ONDISK)" nil nil)

(autoload 'bbdb-migrate "bbdb-migrate" "\
Migrate the BBDB from the version on disk (the car of
`bbdb-file-format-migration') to the current version (in
`bbdb-file-format').

\(fn RECORDS)" nil nil)

(autoload 'bbdb-unmigrate-record "bbdb-migrate" "\
Reverse-migrate a single record from the current version (in
`bbdb-file-format') to the version to be saved (the cdr of
`bbdb-file-format-migration').

\(fn RECORD)" nil nil)

(autoload 'bbdb-migrate-rewrite-all "bbdb-migrate" "\
Rewrite each and every record in the bbdb file; this is necessary if we
are updating an old file format.  MESSAGE-P says whether to sound off
for each record converted.  If RECORDS is non-nil, its value will be
used as the list of records to update.

\(fn MESSAGE-P &optional RECORDS)" nil nil)

(autoload 'bbdb-migrate-update-file-version "bbdb-migrate" "\
Change the `file-version' string from the OLD version to the NEW
version.

\(fn OLD NEW)" nil nil)

;;;***

;;;### (autoloads (bbdb-obsolete-net-canonicalize-net-hook) "bbdb-obsolete"
;;;;;;  "../package.d/bbdb/bits/bbdb-obsolete.el" (15646 18903))
;;; Generated autoloads from ../package.d/bbdb/bits/bbdb-obsolete.el

(autoload 'bbdb-obsolete-net-canonicalize-net-hook "bbdb-obsolete" "\
Return user's current net address given obsolete ADDR.

Return ADDR if it is not obsolete anywhere, or there is no net address
in the matching record.  The field is set in `bbdb-obsolete-net-field'.

\(fn ADDR)" nil nil)

;;;***

;;;### (autoloads (bbdb-utilities-pgp) "bbdb-pgp" "../package.d/bbdb/bits/bbdb-pgp.el"
;;;;;;  (16183 22987))
;;; Generated autoloads from ../package.d/bbdb/bits/bbdb-pgp.el

(let ((loads (get 'bbdb-utilities-pgp 'custom-loads))) (if (member '"bbdb-pgp" loads) nil (put 'bbdb-utilities-pgp 'custom-loads (cons '"bbdb-pgp" loads))))

;;;***

;;;### (autoloads (bbdb-print) "bbdb-print" "../package.d/bbdb/lisp/bbdb-print.el"
;;;;;;  (17884 52100))
;;; Generated autoloads from ../package.d/bbdb/lisp/bbdb-print.el

(autoload 'bbdb-print "bbdb-print" "\
Make a TeX file for printing out the bbdb database.\\<bbdb-mode-map>
If \"\\[bbdb-apply-next-command-to-all-records]\\[bbdb-print]\" is used instead of simply \"\\[bbdb-print]\", then includes only the
people currently in the *BBDB* buffer.  With a prefix argument, makes
a brief (one-line-per-entry) printout.

There are various variables for customizing the content & format of
the printout, notably the variables `bbdb-print-alist' and
`bbdb-print-require'.  See the file bbdb-print.el for more information.

\(fn VISIBLE-RECORDS TO-FILE BRIEF)" t nil)

;;;***

;;;### (autoloads (bbdb-insinuate-reportmail) "bbdb-reportmail" "../package.d/bbdb/lisp/bbdb-reportmail.el"
;;;;;;  (17884 52100))
;;; Generated autoloads from ../package.d/bbdb/lisp/bbdb-reportmail.el

(autoload 'bbdb-insinuate-reportmail "bbdb-reportmail" "\
Call this function to hook BBDB into reportmail.

\(fn)" nil nil)

;;;***

;;;### (autoloads (bbdb-insinuate-rmail bbdb/rmail-show-sender bbdb/rmail-annotate-sender
;;;;;;  bbdb/rmail-update-records bbdb/rmail-update-record) "bbdb-rmail"
;;;;;;  "../package.d/bbdb/lisp/bbdb-rmail.el" (17961 17377))
;;; Generated autoloads from ../package.d/bbdb/lisp/bbdb-rmail.el

(autoload 'bbdb/rmail-update-record "bbdb-rmail" "\
Not documented

\(fn &optional OFFER-TO-CREATE)" nil nil)

(autoload 'bbdb/rmail-update-records "bbdb-rmail" "\
Returns the records corresponding to the current RMAIL emssage,
creating or modifying them as necessary.  A record will be created if
bbdb/mail-auto-create-p is non-nil or if OFFER-TO-CREATE is true, and
the user confirms the creation.

The variable `bbdb/rmail-update-records-mode' controls what actions
are performed and it might override `bbdb-update-records-mode'.

When hitting C-g once you will not be asked anymore for new people
listed n this message, but it will search only for existing records.
When hitting C-g again it will stop scanning.

\(fn &optional OFFER-TO-CREATE)" nil nil)

(autoload 'bbdb/rmail-annotate-sender "bbdb-rmail" "\
Add a line to the end of the Notes field of the BBDB record
corresponding to the sender of this message.  If REPLACE is non-nil,
replace the existing notes entry (if any).

\(fn STRING &optional REPLACE)" t nil)

(autoload 'bbdb/rmail-show-sender "bbdb-rmail" "\
Display the contents of the BBDB for the sender of this message.
This buffer will be in bbdb-mode, with associated keybindings.

\(fn)" t nil)

(autoload 'bbdb-insinuate-rmail "bbdb-rmail" "\
Call this function to hook BBDB into RMAIL.

\(fn)" nil nil)

;;;***

;;;### (autoloads (bbdb-insinuate-sc bbdb/sc-default) "bbdb-sc" "../package.d/bbdb/lisp/bbdb-sc.el"
;;;;;;  (17884 52100))
;;; Generated autoloads from ../package.d/bbdb/lisp/bbdb-sc.el

(autoload 'bbdb/sc-default "bbdb-sc" "\
If the current \"from\" field in `sc-mail-info' alist
contains only an e-mail address, lookup e-mail address in
BBDB, and prepend a new \"from\" field to `sc-mail-info'.

\(fn)" nil nil)

(autoload 'bbdb-insinuate-sc "bbdb-sc" "\
Call this function to hook BBDB into Supercite.

\(fn)" nil nil)

;;;***

;;;### (autoloads (bbdb-rfc822-addresses bbdb-extract-address-components
;;;;;;  bbdb-snarf-region bbdb-snarf) "bbdb-snarf" "../package.d/bbdb/lisp/bbdb-snarf.el"
;;;;;;  (17961 17312))
;;; Generated autoloads from ../package.d/bbdb/lisp/bbdb-snarf.el

(autoload 'bbdb-snarf "bbdb-snarf" "\
snarf up a bbdb record WHERE the point is.
We assume things are line-broken and paragraph-bounded.
The name comes first and other fields (address,
phone, email, web pages) are recognized by context.

Required context:
    addresses end with \"City, State ZIP\" or \"City, State\"
    phones match bbdb-snarf-phone-regexp
        (currently US-style phones)
    e-mail addresses have @'s in them
    web sites are recognized by http:// or www.

Address and phone context are currently US-specific;
patches to internationalize these assumptions are welcome.

\\[bbdb-snarf] is similar to \\[bbdb-whois-sentinel], but less specialized.

\(fn WHERE)" t nil)

(autoload 'bbdb-snarf-region "bbdb-snarf" "\
snarf up a bbdb record in the current region.  See `bbdb-snarf' for
more details.

\(fn BEGIN END)" t nil)

(autoload 'bbdb-extract-address-components "bbdb-snarf" "\
Return a list of address components found in ADSTRING.
If extracting fails one probably has to adjust the variable
`bbdb-extract-address-component-regexps'.

\(fn ADSTRING &optional IGNORE-ERRORS)" nil nil)

(autoload 'bbdb-rfc822-addresses "bbdb-snarf" "\
Split ADDRLINE into a list of parsed addresses.

You can't do this with rfc822.el in any sort of useful way because it discards
the comments. You can't do this with mail-extr.el because the multiple address
parsing in GNU Emacs appears to be broken beyond belief, and the XEmacs
version doesn't support multiple addresses.

\(fn ADDRLINE &optional IGNORE-ERRORS)" nil nil)

;;;***

;;;### (autoloads (bbdb-srv-add-phone bbdb/srv-auto-create-mail-news-dispatcher
;;;;;;  bbdb/srv-handle-headers-with-delay) "bbdb-srv" "../package.d/bbdb/lisp/bbdb-srv.el"
;;;;;;  (17884 52100))
;;; Generated autoloads from ../package.d/bbdb/lisp/bbdb-srv.el

(autoload 'bbdb/srv-handle-headers-with-delay "bbdb-srv" "\
Just like bbdb/srv-handle-headers, but only updates every few seconds.
This is so that trying to display many records in succession won't queue them
up, but will end up only displaying a record when no displays have been
requested for a couple of seconds.

\(fn HEADERS)" nil nil)

(defalias 'bbdb-srv 'bbdb/srv-handle-headers-with-delay)

(autoload 'bbdb/srv-auto-create-mail-news-dispatcher "bbdb-srv" "\
For use as the value of bbdb/srv-auto-create-p.
This will try to decide if this is a mail message or a news message, and then
run either bbdb/news-auto-create-p or bbdb/mail-auto-create-p as appropriate.
\(The heuristic is that news messages never have a Status or X-Mozilla-Status
header; and that mail messages never have Path headers.)

\(fn)" nil nil)

(autoload 'bbdb-srv-add-phone "bbdb-srv" "\
Not documented

\(fn PHONE-STRING &optional DESCRIPTION RECORD)" nil nil)

;;;***

;;;### (autoloads (bbdb-test/run-one-test bbdb-test/run-tests bbdb-test/run-all-tests)
;;;;;;  "bbdb-test" "../package.d/bbdb/testing/bbdb-test.el" (16175
;;;;;;  39563))
;;; Generated autoloads from ../package.d/bbdb/testing/bbdb-test.el

(autoload 'bbdb-test/run-all-tests "bbdb-test" "\
Run all BBDB tests.

\(fn &optional BATCH)" t nil)

(autoload 'bbdb-test/run-tests "bbdb-test" "\
Run BBDB tests.

\(fn)" t nil)

(autoload 'bbdb-test/run-one-test "bbdb-test" "\
Not documented

\(fn TEST-VAR)" t nil)

;;;***

;;;### (autoloads (bbdb-insinuate-vm bbdb/vm-set-auto-folder-alist
;;;;;;  bbdb/vm-set-auto-folder-alist-headers bbdb/vm-set-auto-folder-alist-field
;;;;;;  bbdb/vm-show-sender bbdb/vm-show-all-recipients bbdb/vm-show-records
;;;;;;  bbdb/vm-annotate-sender bbdb/vm-update-records bbdb/vm-update-record)
;;;;;;  "bbdb-vm" "../package.d/bbdb/lisp/bbdb-vm.el" (18389 44231))
;;; Generated autoloads from ../package.d/bbdb/lisp/bbdb-vm.el

(autoload 'bbdb/vm-update-record "bbdb-vm" "\
Not documented

\(fn &optional OFFER-TO-CREATE)" nil nil)

(autoload 'bbdb/vm-update-records "bbdb-vm" "\
Returns the records corresponding to the current VM message,
creating or modifying them as necessary.  A record will be created if
`bbdb/mail-auto-create-p' is non-nil or if OFFER-TO-CREATE is true, and
the user confirms the creation.

The variable `bbdb/vm-update-records-mode' controls what actions
are performed and it might override `bbdb-update-records-mode'.

When hitting C-g once you will not be asked anymore for new people listed
in this message, but it will search only for existing records.  When hitting
C-g again it will stop scanning.

\(fn &optional OFFER-TO-CREATE)" nil nil)

(autoload 'bbdb/vm-annotate-sender "bbdb-vm" "\
Add a line to the end of the Notes field of the BBDB record
corresponding to the sender of this message.  If REPLACE is non-nil,
replace the existing notes entry (if any).

\(fn STRING &optional REPLACE)" t nil)

(autoload 'bbdb/vm-show-records "bbdb-vm" "\
Display the contents of the BBDB for the sender of this message.
This buffer will be in bbdb-mode, with associated keybindings.

\(fn &optional ADDRESS-CLASS)" t nil)

(autoload 'bbdb/vm-show-all-recipients "bbdb-vm" "\
Show all recipients of this message. Counterpart to `bbdb/vm-show-sender'.

\(fn)" t nil)

(autoload 'bbdb/vm-show-sender "bbdb-vm" "\
Display the contents of the BBDB for the senders of this message.
With a prefix argument show the recipients instead,
with two prefix arguments show all records.
This buffer will be in `bbdb-mode', with associated keybindings.

\(fn &optional SHOW-RECIPIENTS)" t nil)

(defvar bbdb/vm-set-auto-folder-alist-field 'vm-folder "\
*The field which `bbdb/vm-set-auto-folder-alist' searches for.")

(custom-autoload 'bbdb/vm-set-auto-folder-alist-field "bbdb-vm" t)

(defvar bbdb/vm-set-auto-folder-alist-headers '("From:" "To:" "CC:") "\
*The headers used by `bbdb/vm-set-auto-folder-alist'.
The order in this list is the order how matching will be performed!")

(custom-autoload 'bbdb/vm-set-auto-folder-alist-headers "bbdb-vm" t)

(autoload 'bbdb/vm-set-auto-folder-alist "bbdb-vm" "\
Create a `vm-auto-folder-alist' according to the records in the bbdb.
For each record that has a 'vm-folder' attribute, add an
element (email-regexp . folder) to the `vm-auto-folder-alist'.

The element gets added to the 'element-name' sublist of the
`vm-auto-folder-alist'.

The car of the element consists of all the email addresses for the
bbdb record concatenated with OR; the cdr is the value of the
vm-folder attribute.

If the first character of vm-folders value is a quote ' it will be
parsed as lisp expression and is evaluated to return a folder name,
e.g. define you own function `my-folder-name' and set it to
        '(my-folder-name)

\(fn)" t nil)

(autoload 'bbdb-insinuate-vm "bbdb-vm" "\
Call this function to hook BBDB into VM.

\(fn)" nil nil)

;;;***

;;;### (autoloads (bbdb-insinuate-w3 bbdb-www-grab-homepage bbdb-www)
;;;;;;  "bbdb-w3" "../package.d/bbdb/lisp/bbdb-w3.el" (17884 52100))
;;; Generated autoloads from ../package.d/bbdb/lisp/bbdb-w3.el

(autoload 'bbdb-www "bbdb-w3" "\
Visit URLs stored in the `www' field of the current record.
\\[bbdb-apply-next-command-to-all-records]\\[bbdb-www] means to try all records currently visible.
Non-interactively, do all records if arg is nonnil.

\(fn REC &optional WHICH)" t nil)

(autoload 'bbdb-www-grab-homepage "bbdb-w3" "\
Grab the current URL and store it in the bbdb database

\(fn RECORD)" t nil)

(autoload 'bbdb-insinuate-w3 "bbdb-w3" "\
Call this function to hook BBDB into W3.

\(fn)" nil nil)

;;;***

;;;### (autoloads (bbdb-whois) "bbdb-whois" "../package.d/bbdb/lisp/bbdb-whois.el"
;;;;;;  (18011 20885))
;;; Generated autoloads from ../package.d/bbdb/lisp/bbdb-whois.el

(autoload 'bbdb-whois "bbdb-whois" "\
Not documented

\(fn THE-RECORD &optional SERVER)" t nil)

;;;***

;;;### (autoloads (bbdb-load-touchtones bbdb-sound-volume bbdb-sounds-directory
;;;;;;  bbdb-xemacs-display-completion-list) "bbdb-xemacs" "../package.d/bbdb/lisp/bbdb-xemacs.el"
;;;;;;  (18011 20885))
;;; Generated autoloads from ../package.d/bbdb/lisp/bbdb-xemacs.el

(autoload 'bbdb-xemacs-display-completion-list "bbdb-xemacs" "\
Wrapper for `display-completion-list'.
Allows callbacks on XEmacs `display-completion-list' is called with
`:activate-callback CALLBACK' if CALLBACK is non-nil.
`:user-data DATA' is also used if DATA is non-nil.
Neither are used if CALLBACK is nil.

\(fn LIST &optional CALLBACK DATA)" nil nil)

(defvar bbdb-sounds-directory (expand-file-name "~/.xemacs/etc/sounds") "\
The directory to load the touchtone sound files from, or nil if none.")

(custom-autoload 'bbdb-sounds-directory "bbdb-xemacs" t)

(defvar bbdb-sound-volume 50 "\
Volume for playing sounds.")

(custom-autoload 'bbdb-sound-volume "bbdb-xemacs" t)

(autoload 'bbdb-load-touchtones "bbdb-xemacs" "\
Load the touchtone sounds into `sound-alist'.
The directory specified in `bbdb-sounds-directory' is searched for the files
touchtone.*\\.\\(wav\\|au\\) as named in `bbdb-sound-files'.
They are stored in `sound-alist' as touchtone0 to touchtone11.

\(fn)" t nil)

;;;***

;;;### (autoloads (egg-minor-mode-find-file-hook egg-minor-mode)
;;;;;;  "egg" "../package.d/egg/egg.el" (18785 2839))
;;; Generated autoloads from ../package.d/egg/egg.el

(autoload 'egg-minor-mode "egg" "\
Turn-on egg-minor-mode which would enable key bindings for
egg in current buffer.\\<egg-minor-mode-map>
\\[egg-start-new-branch] start a new branch from the current HEAD.
\\[egg-status] shows the repo's current status
\\[egg-commit-log-edit] start editing the commit message for the current staged changes.
\\[egg-file-stage-current-file] stage new changes of the current file 
\\[egg-log] shows repo's history 
\\[egg-file-checkout-other-version] checkout another version of the current file 
\\[egg-file-cancel-modifications] delete unstaged modifications in the current file
\\[egg-next-action] perform the next logical action
\\[egg-file-diff] compare file with index or other commits
\\[egg-file-version-other-window] show other version of the current file.

\\{egg-minor-mode-map}

\(fn &optional ARG)" t nil)

(autoload 'egg-minor-mode-find-file-hook "egg" "\
Not documented

\(fn)" nil nil)

;;;***

;;;### (autoloads (egg-grep egg-grep-mode egg-grep-process-setup)
;;;;;;  "egg-grep" "../package.d/egg/egg-grep.el" (18785 2839))
;;; Generated autoloads from ../package.d/egg/egg-grep.el

(autoload 'egg-grep-process-setup "egg-grep" "\
Setup compilation variables and buffer for `egg-grep'.
Set up `compilation-exit-message-function' and run `egg-grep-setup-hook'.

\(fn)" nil nil)

(autoload 'egg-grep-mode "egg-grep" "\
Sets `compilation-last-buffer' and `compilation-window-height'.

\(fn)" nil nil)

(autoload 'egg-grep "egg-grep" "\
Not documented

\(fn LEVEL)" t nil)

;;;***

;;;### (autoloads (with-expect) "expect" "../package.d/mailcrypt/expect.el"
;;;;;;  (18787 56325))
;;; Generated autoloads from ../package.d/mailcrypt/expect.el

(autoload 'with-expect "expect" "\
Set things up for communication with PROGRAM.
FORMS will be evaluated in the normal manner.  To talk to the process,
use `expect' and `expect-send'.  See the manual for full documentation.
This macro returns nil.

If PROGRAM is a string, start that program.  If PROGRAM is a list, use
the first element of that list as the program and the remainder as the
parameters.  If PROGRAM is a process, talk to that process.

PROGRAM will be started up in a new, fresh temporary buffer.  The
buffer will be killed upon completion.  If PROGRAM is a process,
a new buffer won't be created, and the buffer won't be killed upon
completion.

\(fn PROGRAM &rest FORMS)" nil (quote macro))

;;;***

;;;### (autoloads (git-reblame git-blame-mode) "git-blame" "../../../../elisp/package.d/git-emacs/git-blame.el"
;;;;;;  (18785 2801))
;;; Generated autoloads from ../../../../elisp/package.d/git-emacs/git-blame.el

(autoload 'git-blame-mode "git-blame" "\
Toggle minor mode for displaying Git blame

With prefix ARG, turn the mode on if ARG is positive.

\(fn &optional ARG)" t nil)

(autoload 'git-reblame "git-blame" "\
Recalculate all blame information in the current buffer

\(fn)" t nil)

;;;***

;;;### (autoloads (mew-shimbun-expire mew-shimbun-expire-all mew-shimbun-re-retrieve-all
;;;;;;  mew-shimbun-re-retrieve mew-shimbun-retrieve-all mew-shimbun-retrieve
;;;;;;  mew-shimbun-goto-folder mew-shimbun-goto-unseen-folder) "mew-shimbun"
;;;;;;  "../package.d/w3m-el/shimbun/mew-shimbun.el" (18197 61166))
;;; Generated autoloads from ../package.d/w3m-el/shimbun/mew-shimbun.el

(autoload 'mew-shimbun-goto-unseen-folder "mew-shimbun" "\
Goto folder for SHIMBUN to have a few new messages.

\(fn)" t nil)

(autoload 'mew-shimbun-goto-folder "mew-shimbun" "\
Goto folder for SHIMBUN.
If called with '\\[universal-argument]', goto folder to have a few new messages.

\(fn &optional ARGS)" t nil)

(autoload 'mew-shimbun-retrieve "mew-shimbun" "\
Retrieve articles via SHIMBUN on this folder.

\(fn &optional NEWFLD)" t nil)

(autoload 'mew-shimbun-retrieve-all "mew-shimbun" "\
Retrieve all articles via SHIMBUN.

\(fn)" t nil)

(autoload 'mew-shimbun-re-retrieve "mew-shimbun" "\
Re-retrieve this message.
If called with '\\[universal-argument]', re-retrieve messages marked with
'mew-shimbun-mark-re-retrieve'.

\(fn &optional ARGS)" t nil)

(autoload 'mew-shimbun-re-retrieve-all "mew-shimbun" "\
Re-retrieve all messages in this folder.
If called with '\\[universal-argument]', re-retrieve messages in the region.

\(fn &optional ARG)" t nil)

(autoload 'mew-shimbun-expire-all "mew-shimbun" "\
Expire all shimbun folder.

\(fn)" t nil)

(autoload 'mew-shimbun-expire "mew-shimbun" "\
Expire this shimbun folder.

\(fn)" t nil)

;;;***

;;;### (autoloads (mime-w3m-preview-text/html) "mime-w3m" "../package.d/w3m-el/mime-w3m.el"
;;;;;;  (18197 61165))
;;; Generated autoloads from ../package.d/w3m-el/mime-w3m.el

(autoload 'mime-w3m-preview-text/html "mime-w3m" "\
Not documented

\(fn ENTITY SITUATION)" nil nil)

;;;***

;;;### (autoloads nil "muse" "../package.d/muse-el/lisp/muse.el"
;;;;;;  (18785 2863))
;;; Generated autoloads from ../package.d/muse-el/lisp/muse.el
 (add-to-list 'auto-mode-alist '("\\.muse\\'" . muse-mode-choose-mode))

;;;***

;;;### (autoloads (muse-blosxom-new-entry) "muse-blosxom" "../package.d/muse-el/lisp/muse-blosxom.el"
;;;;;;  (18785 2863))
;;; Generated autoloads from ../package.d/muse-el/lisp/muse-blosxom.el

(autoload 'muse-blosxom-new-entry "muse-blosxom" "\
Start a new blog entry with given CATEGORY.
The filename of the blog entry is derived from TITLE.
The page will be initialized with the current date and TITLE.

\(fn CATEGORY TITLE)" t nil)

;;;***

;;;### (autoloads (muse-colors-toggle-inline-images) "muse-colors"
;;;;;;  "../package.d/muse-el/lisp/muse-colors.el" (18785 2863))
;;; Generated autoloads from ../package.d/muse-el/lisp/muse-colors.el

(autoload 'muse-colors-toggle-inline-images "muse-colors" "\
Toggle display of inlined images on/off.

\(fn)" t nil)

;;;***

;;;### (autoloads (muse-import-docbook-files muse-import-docbook)
;;;;;;  "muse-import-docbook" "../package.d/muse-el/lisp/muse-import-docbook.el"
;;;;;;  (18785 2863))
;;; Generated autoloads from ../package.d/muse-el/lisp/muse-import-docbook.el

(autoload 'muse-import-docbook "muse-import-docbook" "\
Convert the Docbook buffer SRC to Muse, writing output in the DEST buffer.

\(fn SRC DEST)" t nil)

(autoload 'muse-import-docbook-files "muse-import-docbook" "\
Convert the Docbook file SRC to Muse, writing output to the DEST file.

\(fn SRC DEST)" t nil)

;;;***

;;;### (autoloads (muse-import-latex) "muse-import-latex" "../package.d/muse-el/lisp/muse-import-latex.el"
;;;;;;  (18785 2863))
;;; Generated autoloads from ../package.d/muse-el/lisp/muse-import-latex.el

(autoload 'muse-import-latex "muse-import-latex" "\
Not documented

\(fn)" t nil)

;;;***

;;;### (autoloads (muse-message-markup) "muse-message" "../package.d/muse-el/experimental/muse-message.el"
;;;;;;  (18785 2862))
;;; Generated autoloads from ../package.d/muse-el/experimental/muse-message.el

(autoload 'muse-message-markup "muse-message" "\
Markup a wiki-ish e-mail message as HTML alternative e-mail.
This step is manual by default, to give the author a chance to review
the results and ensure they are appropriate.
If you wish it to be automatic (a risky proposition), just add this
function to `message-send-hook'.

\(fn)" t nil)

;;;***

;;;### (autoloads (muse-list-edit-minor-mode muse-insert-tag muse-index
;;;;;;  muse-find-backlinks muse-search muse-search-with-command
;;;;;;  muse-what-changed muse-previous-reference muse-next-reference
;;;;;;  muse-follow-name-at-point-other-window muse-follow-name-at-point
;;;;;;  muse-browse-result muse-edit-link-at-point muse-insert-relative-link-to-file
;;;;;;  muse-decrease-list-item-indentation muse-increase-list-item-indentation
;;;;;;  muse-insert-list-item muse-mode-choose-mode muse-mode) "muse-mode"
;;;;;;  "../package.d/muse-el/lisp/muse-mode.el" (18785 2863))
;;; Generated autoloads from ../package.d/muse-el/lisp/muse-mode.el

(autoload 'muse-mode "muse-mode" "\
Muse is an Emacs mode for authoring and publishing documents.
\\{muse-mode-map}

\(fn)" t nil)

(autoload 'muse-mode-choose-mode "muse-mode" "\
Turn the proper Emacs Muse related mode on for this file.

\(fn)" nil nil)

(autoload 'muse-insert-list-item "muse-mode" "\
Insert a list item at the current point, taking into account
your current list type and indentation level.

\(fn)" t nil)

(autoload 'muse-increase-list-item-indentation "muse-mode" "\
Increase the indentation of the current list item.

\(fn)" t nil)

(autoload 'muse-decrease-list-item-indentation "muse-mode" "\
Decrease the indentation of the current list item.

\(fn)" t nil)

(autoload 'muse-insert-relative-link-to-file "muse-mode" "\
Insert a relative link to a file, with optional description, at point.

\(fn)" t nil)

(autoload 'muse-edit-link-at-point "muse-mode" "\
Edit the current link.
Do not rename the page originally referred to.

\(fn)" t nil)

(autoload 'muse-browse-result "muse-mode" "\
Visit the current page's published result.

\(fn STYLE &optional OTHER-WINDOW)" t nil)

(autoload 'muse-follow-name-at-point "muse-mode" "\
Visit the link at point.

\(fn &optional OTHER-WINDOW)" t nil)

(autoload 'muse-follow-name-at-point-other-window "muse-mode" "\
Visit the link at point in other window.

\(fn)" t nil)

(autoload 'muse-next-reference "muse-mode" "\
Move forward to next Muse link or URL, cycling if necessary.

\(fn)" t nil)

(autoload 'muse-previous-reference "muse-mode" "\
Move backward to the next Muse link or URL, cycling if necessary.
In case of Emacs x <= 21 and ignoring of intangible properties (see
`muse-mode-intangible-links').

This function is not entirely accurate, but it's close enough.

\(fn)" t nil)

(autoload 'muse-what-changed "muse-mode" "\
Show the unsaved changes that have been made to the current file.

\(fn)" t nil)

(autoload 'muse-search-with-command "muse-mode" "\
Search for the given TEXT string in the project directories
using the specified command.

\(fn TEXT)" t nil)

(autoload 'muse-search "muse-mode" "\
Search for the given TEXT using the default grep command.

\(fn)" t nil)

(autoload 'muse-find-backlinks "muse-mode" "\
Grep for the current pagename in all the project directories.

\(fn)" t nil)

(autoload 'muse-index "muse-mode" "\
Display an index of all known Muse pages.

\(fn)" t nil)

(autoload 'muse-insert-tag "muse-mode" "\
Insert a tag interactively with a blank line after it.

\(fn TAG)" t nil)

(autoload 'muse-list-edit-minor-mode "muse-mode" "\
This is a global minor mode for editing files with lists.
It is meant to be used with other major modes, and not with Muse mode.

Interactively, with no prefix argument, toggle the mode.
With universal prefix ARG turn mode on.
With zero or negative ARG turn mode off.

This minor mode provides the Muse keybindings for editing lists,
and support for filling lists properly.

It recognizes not only Muse-style lists, which use the \"-\"
character or numbers, but also lists that use asterisks or plus
signs.  This should make the minor mode generally useful.

Definition lists and footnotes are also recognized.

Note that list items may omit leading spaces, for compatibility
with modes that set `left-margin', such as
`debian-changelog-mode'.

\\{muse-list-edit-minor-mode-map}

\(fn &optional ARG)" t nil)

;;;***

;;;### (autoloads (muse-project-publish muse-project-publish-this-file
;;;;;;  muse-project-find-file) "muse-project" "../package.d/muse-el/lisp/muse-project.el"
;;;;;;  (18785 2863))
;;; Generated autoloads from ../package.d/muse-el/lisp/muse-project.el

(autoload 'muse-project-find-file "muse-project" "\
Open the Muse page given by NAME in PROJECT.
If COMMAND is non-nil, it is the function used to visit the file.
If DIRECTORY is non-nil, it is the directory in which the page
will be created if it does not already exist.  Otherwise, the
first directory within the project's fileset is used.

\(fn NAME PROJECT &optional COMMAND DIRECTORY)" t nil)

(autoload 'muse-project-publish-this-file "muse-project" "\
Publish the currently-visited file according to `muse-project-alist',
prompting if more than one style applies.

If FORCE is given, publish the file even if it is up-to-date.

If STYLE is given, use that publishing style rather than
prompting for one.

\(fn &optional FORCE STYLE)" t nil)

(autoload 'muse-project-publish "muse-project" "\
Publish the pages of PROJECT that need publishing.

\(fn PROJECT &optional FORCE)" t nil)

;;;***

;;;### (autoloads (muse-browse-url) "muse-protocols" "../package.d/muse-el/lisp/muse-protocols.el"
;;;;;;  (18785 2863))
;;; Generated autoloads from ../package.d/muse-el/lisp/muse-protocols.el

(autoload 'muse-browse-url "muse-protocols" "\
Handle URL with the function specified in `muse-url-protocols'.
If OTHER-WINDOW is non-nil, open in a different window.

\(fn URL &optional OTHER-WINDOW)" t nil)

;;;***

;;;### (autoloads (muse-publish-this-file muse-publish-file muse-publish-region)
;;;;;;  "muse-publish" "../package.d/muse-el/lisp/muse-publish.el"
;;;;;;  (18785 2863))
;;; Generated autoloads from ../package.d/muse-el/lisp/muse-publish.el

(autoload 'muse-publish-region "muse-publish" "\
Apply the given STYLE's markup rules to the given region.
The result is placed in a new buffer that includes TITLE in its name.

\(fn BEG END &optional TITLE STYLE)" t nil)

(autoload 'muse-publish-file "muse-publish" "\
Publish the given FILE in a particular STYLE to OUTPUT-DIR.
If the argument FORCE is nil, each file is only published if it is
newer than the published version.  If the argument FORCE is non-nil,
the file is published no matter what.

\(fn FILE STYLE &optional OUTPUT-DIR FORCE)" t nil)

(autoload 'muse-publish-this-file "muse-publish" "\
Publish the currently-visited file.
Prompt for both the STYLE and OUTPUT-DIR if they are not
supplied.

\(fn STYLE OUTPUT-DIR &optional FORCE)" t nil)

;;;***

;;;### (autoloads (gnus-group-make-shimbun-groups gnus-group-make-shimbun-group
;;;;;;  gnus-summary-refer-shimbun-article) "nnshimbun" "../package.d/w3m-el/shimbun/nnshimbun.el"
;;;;;;  (18734 31102))
;;; Generated autoloads from ../package.d/w3m-el/shimbun/nnshimbun.el

(autoload 'gnus-summary-refer-shimbun-article "nnshimbun" "\
Show a shimbun article pointed to by the given URL.

\(fn URL)" t nil)

(autoload 'gnus-group-make-shimbun-group "nnshimbun" "\
Create a new nnshimbun group.
The user will be prompted for a SERVER name and a GROUP name.  When
this command is called with a prefix argument, it makes an ephemeral
shimbun group.

\(fn SERVER GROUP &optional EPHEMERAL)" t nil)

(autoload 'gnus-group-make-shimbun-groups "nnshimbun" "\
Create all nnshimbun groups prepared for SERVER.

\(fn SERVER)" t nil)

;;;***

;;;### (autoloads (octet-mime-setup mime-view-octet mime-preview-octet
;;;;;;  octet-find-file octet-buffer) "octet" "../package.d/w3m-el/octet.el"
;;;;;;  (17133 57129))
;;; Generated autoloads from ../package.d/w3m-el/octet.el

(autoload 'octet-buffer "octet" "\
View octet-stream content according to `octet-type-filter-alist'.
Optional NAME is the filename.
If optional CONTENT-TYPE is specified, it is used for type guess.

\(fn &optional NAME CONTENT-TYPE)" t nil)

(autoload 'octet-find-file "octet" "\
Find FILE with octet-stream decoding.

\(fn FILE)" t nil)

(autoload 'mime-preview-octet "octet" "\
A method for mime-view to preview octet message.

\(fn ENTITY SITUATION)" nil nil)

(autoload 'mime-view-octet "octet" "\
A method for mime-view to display octet message.

\(fn ENTITY SITUATION)" nil nil)

(autoload 'octet-mime-setup "octet" "\
Octet setting for MIME module.

\(fn)" nil nil)

;;;***

;;;### (autoloads (planner-calendar-show planner-calendar-goto planner-search-notes
;;;;;;  planner-search-notes-with-body planner-create-task-from-buffer
;;;;;;  planner-create-low-priority-task-from-buffer planner-create-medium-priority-task-from-buffer
;;;;;;  planner-create-high-priority-task-from-buffer planner-goto-next-daily-page
;;;;;;  planner-goto-previous-daily-page planner-goto-tomorrow planner-goto-yesterday
;;;;;;  planner-goto-most-recent planner-goto-today planner-show
;;;;;;  planner-goto-plan-page planner-goto plan planner-create-note
;;;;;;  planner-resolve-position-url planner-browse-position-url
;;;;;;  planner-annotation-from-file-with-position planner-annotation-as-kill
;;;;;;  planner-mode) "planner" "../package.d/planner-el/planner.el"
;;;;;;  (18785 2890))
;;; Generated autoloads from ../package.d/planner-el/planner.el

(autoload 'planner-mode "planner" "\
A personal information manager for Emacs.
\\{planner-mode-map}

\(fn)" t nil)

(autoload 'planner-annotation-as-kill "planner" "\
Copy the current annotation into the kill ring.
When called with a prefix argument, prompt for the link display name.

\(fn ARG)" t nil)

(autoload 'planner-annotation-from-file-with-position "planner" "\
Return the filename and cursor position of the current buffer.
If `planner-annotation-use-relative-file' is t or a function that
returns non-nil, a relative link is used instead. If
`planner-annotation-strip-directory' is non-nil, the directory is
stripped from the link description.

\(fn)" nil nil)

(autoload 'planner-browse-position-url "planner" "\
If this is a position URL, jump to it.

\(fn URL)" nil nil)

(autoload 'planner-resolve-position-url "planner" "\
Replace ID with the blog, web or e-mail address of the BBDB record.

\(fn ID)" nil nil)

(autoload 'planner-create-note "planner" "\
Create a note to be remembered in PAGE (today if PAGE is nil).
If `planner-reverse-chronological-notes' is non-nil, create the
note at the beginning of the notes section; otherwise, add it to
the end.  Position point after the anchor.

\(fn &optional PAGE)" t nil)

(autoload 'plan "planner" "\
Start your planning for the day, carrying unfinished tasks forward.

If FORCE-DAYS is a positive integer, search that many days in the past
for unfinished tasks.
If FORCE-DAYS is 0 or t, scan all days.
If FORCE-DAYS is nil, use the value of `planner-carry-tasks-forward'
instead, except t means scan only yesterday.

\(fn &optional FORCE-DAYS)" t nil)

(autoload 'planner-goto "planner" "\
Jump to the planning page for DATE.
If no page for DATE exists and JUST-SHOW is non-nil, don't create
a new page - simply return nil.

\(fn DATE &optional JUST-SHOW)" t nil)

(autoload 'planner-goto-plan-page "planner" "\
Opens PAGE in the the `planner-project' wiki.
Use `planner-goto' if you want fancy calendar completion.

\(fn PAGE)" t nil)

(autoload 'planner-show "planner" "\
Show the plan page for DATE in another window, but don't select it.
If no page for DATE exists, return nil.

\(fn DATE)" t nil)

(autoload 'planner-goto-today "planner" "\
Jump to the planning page for today.

\(fn)" t nil)

(autoload 'planner-goto-most-recent "planner" "\
Go to the most recent day with planning info.

\(fn)" t nil)

(autoload 'planner-goto-yesterday "planner" "\
Goto the planner page DAYS before the currently displayed date.
If DAYS is nil, goes to the day immediately before the currently
displayed date.  If the current buffer is not a daily planner
page, calculates date based on today.

\(fn &optional DAYS)" t nil)

(autoload 'planner-goto-tomorrow "planner" "\
Goto the planner page DAYS after the currently displayed date.
If DAYS is nil, goes to the day immediately after the currently
displayed date.  If the current buffer is not a daily planner
page, calculates date based on today.

\(fn &optional DAYS)" t nil)

(autoload 'planner-goto-previous-daily-page "planner" "\
Goto the last plan page before the current date.
The current date is taken from the day page in the current
buffer, or today if the current buffer is not a planner page.
Does not create pages if they do not yet exist.

\(fn)" t nil)

(autoload 'planner-goto-next-daily-page "planner" "\
Goto the first plan page after the current date.
The current date is taken from the day page in the current
buffer, or today if the current buffer is not a planner page.
Does not create pages if they do not yet exist.

\(fn)" t nil)

(autoload 'planner-create-high-priority-task-from-buffer "planner" "\
Create a high-priority task based on this buffer.
Do not use this in LISP programs. Instead, set the value of
`planner-default-task-priority' and call `planner-create-task' or
`planner-create-task-from-buffer'.

\(fn)" t nil)

(autoload 'planner-create-medium-priority-task-from-buffer "planner" "\
Create a high-priority task based on this buffer.
Do not use this in LISP programs. Instead, set the value of
`planner-default-task-priority' and call `planner-create-task' or
`planner-create-task-from-buffer'.

\(fn)" t nil)

(autoload 'planner-create-low-priority-task-from-buffer "planner" "\
Create a high-priority task based on this buffer.
Do not use this in LISP programs. Instead, set the value of
`planner-default-task-priority' and call `planner-create-task' or
`planner-create-task-from-buffer'.

\(fn)" t nil)

(autoload 'planner-create-task-from-buffer "planner" "\
Create a new task named TITLE on DATE based on the current buffer.
With a prefix, do not prompt for PLAN-PAGE. The task is
associated with PLAN-PAGE if non-nil. If STATUS is non-nil, use
that as the status for the task. Otherwise, use
`planner-default-task-status'. See `planner-create-task' for more
information.

\(fn TITLE DATE &optional PLAN-PAGE STATUS)" t nil)

(autoload 'planner-search-notes-with-body "planner" "\
Return a buffer with all the notes returned by the query for REGEXP.
If called with a prefix argument, prompt for LIMIT and search days on
or after LIMIT. Display the body of the notes as well.

\(fn REGEXP LIMIT)" t nil)

(autoload 'planner-search-notes "planner" "\
Return a buffer with all the notes returned by the query for REGEXP.
If called with a prefix argument, prompt for LIMIT and search days on
or after LIMIT. If INCLUDE-BODY is non-nil, return the body as well.

\(fn REGEXP LIMIT &optional INCLUDE-BODY)" t nil)

(autoload 'planner-calendar-goto "planner" "\
Goto the plan page corresponding to the calendar date.

\(fn)" t nil)

(autoload 'planner-calendar-show "planner" "\
Show the plan page for the calendar date under point in another window.

\(fn)" t nil)

;;;***

;;;### (autoloads (planner-accomplishments-show planner-accomplishments-update
;;;;;;  planner-accomplishments-insinuate) "planner-accomplishments"
;;;;;;  "../package.d/planner-el/planner-accomplishments.el" (18785
;;;;;;  2890))
;;; Generated autoloads from ../package.d/planner-el/planner-accomplishments.el

(autoload 'planner-accomplishments-insinuate "planner-accomplishments" "\
Automatically call `planner-accomplishments-update'.

\(fn)" nil nil)

(autoload 'planner-accomplishments-update "planner-accomplishments" "\
Update `planner-accomplishments-section'.

\(fn)" t nil)

(autoload 'planner-accomplishments-show "planner-accomplishments" "\
Display a buffer with the current page's accomplishment report.

\(fn)" t nil)

;;;***

;;;### (autoloads (planner-appt-use-tasks-and-schedule planner-appt-use-schedule
;;;;;;  planner-appt-use-tasks planner-appt-insinuate planner-appt-insinuate-if-today
;;;;;;  planner-appt-update) "planner-appt" "../package.d/planner-el/planner-appt.el"
;;;;;;  (18785 2890))
;;; Generated autoloads from ../package.d/planner-el/planner-appt.el

(autoload 'planner-appt-update "planner-appt" "\
Update the appointments on the current page.

\(fn)" t nil)

(autoload 'planner-appt-insinuate-if-today "planner-appt" "\
Not documented

\(fn)" nil nil)

(autoload 'planner-appt-insinuate "planner-appt" "\
Insinuate appointment alerting into planner mode.
Appointment methods should be set up first using one of:
  `planner-appt-use-tasks'
  `planner-appt-use-schedule'
  `planner-appt-use-tasks-and-schedule'.

\(fn)" nil nil)

(autoload 'planner-appt-use-tasks "planner-appt" "\
Use tasks to derive appointment alerts.

\(fn)" nil nil)

(autoload 'planner-appt-use-schedule "planner-appt" "\
Use the schedule to derive appointment alerts.

\(fn)" nil nil)

(autoload 'planner-appt-use-tasks-and-schedule "planner-appt" "\
Use both tasks and the schedule to derive appointment alerts.

\(fn)" nil nil)

;;;***

;;;### (autoloads (planner-bbdb-resolve-url planner-bbdb-browse-url
;;;;;;  planner-bbdb-annotation-from-bbdb) "planner-bbdb" "../package.d/planner-el/planner-bbdb.el"
;;;;;;  (18785 2890))
;;; Generated autoloads from ../package.d/planner-el/planner-bbdb.el

(autoload 'planner-bbdb-annotation-from-bbdb "planner-bbdb" "\
If called from a bbdb buffer, return an annotation.
Suitable for use in `planner-annotation-functions'.

\(fn)" nil nil)

(autoload 'planner-bbdb-browse-url "planner-bbdb" "\
If this is a BBDB URL, jump to it.

\(fn URL)" nil nil)

(autoload 'planner-bbdb-resolve-url "planner-bbdb" "\
Replace ID with the blog, web or e-mail address of the BBDB record.

\(fn ID)" nil nil)

;;;***

;;;### (autoloads (planner-bibtex-browse-url planner-bibtex-annotation-old
;;;;;;  planner-bibtex-annotation-new) "planner-bibtex" "../package.d/planner-el/planner-bibtex.el"
;;;;;;  (18785 2890))
;;; Generated autoloads from ../package.d/planner-el/planner-bibtex.el

(autoload 'planner-bibtex-annotation-new "planner-bibtex" "\
Return an annotation for the current bibtex entry.

\(fn)" nil nil)

(autoload 'planner-bibtex-annotation-old "planner-bibtex" "\
Return the filename on the current line in dired.

\(fn)" nil nil)

(autoload 'planner-bibtex-browse-url "planner-bibtex" "\
If this is a Bibtex URL, jump to it.

\(fn URL)" nil nil)

;;;***

;;;### (autoloads (planner-bookmark-browse-url planner-bookmark-annotation-from-bookmark)
;;;;;;  "planner-bookmark" "../package.d/planner-el/planner-bookmark.el"
;;;;;;  (18785 2890))
;;; Generated autoloads from ../package.d/planner-el/planner-bookmark.el

(autoload 'planner-bookmark-annotation-from-bookmark "planner-bookmark" "\
If called from a bookmark buffer, return an annotation.
Suitable for use in `planner-annotation-functions'.

\(fn)" nil nil)

(autoload 'planner-bookmark-browse-url "planner-bookmark" "\
If this is a bookmark URL, jump to it.

\(fn URL)" nil nil)

;;;***

;;;### (autoloads (planner-cyclic-create-tasks-maybe) "planner-cyclic"
;;;;;;  "../package.d/planner-el/planner-cyclic.el" (18785 2890))
;;; Generated autoloads from ../package.d/planner-el/planner-cyclic.el

(autoload 'planner-cyclic-create-tasks-maybe "planner-cyclic" "\
Maybe create cyclic tasks.
This will only create tasks for future dates or today.

\(fn)" t nil)

;;;***

;;;### (autoloads (planner-deadline-remove planner-deadline-change
;;;;;;  planner-deadline-update) "planner-deadline" "../package.d/planner-el/planner-deadline.el"
;;;;;;  (18785 2890))
;;; Generated autoloads from ../package.d/planner-el/planner-deadline.el

(autoload 'planner-deadline-update "planner-deadline" "\
Replace the text for all tasks with deadlines.
By default, deadlines are of the form {{Deadline: yyyy.mm.dd}}.
See `planner-deadline-regexp' for details.

\(fn)" t nil)

(autoload 'planner-deadline-change "planner-deadline" "\
Change the deadline of current task to DATE.
If DATE is nil, prompt for it.

\(fn DATE)" t nil)

(defalias 'planner-deadline-add 'planner-deadline-change)

(autoload 'planner-deadline-remove "planner-deadline" "\
Remove the deadline of the current task.

\(fn)" t nil)

;;;***

;;;### (autoloads (planner-diary-add-entry planner-diary-insinuate
;;;;;;  planner-diary-show-day-plan-or-diary planner-diary-insert-all-diaries-maybe
;;;;;;  planner-diary-insert-all-diaries planner-diary-update-section)
;;;;;;  "planner-diary" "../package.d/planner-el/planner-diary.el"
;;;;;;  (18785 2890))
;;; Generated autoloads from ../package.d/planner-el/planner-diary.el

(autoload 'planner-diary-update-section "planner-diary" "\
Update FILE's existing section TITLE by replacing existing text with TEXT.
If optional arg FORCE is non-nil, update the section even if it doesn't exist,
i.e. insert TITLE followed by TEXT at the top of the buffer.

\(fn FILE TITLE TEXT &optional FORCE)" nil nil)

(autoload 'planner-diary-insert-all-diaries "planner-diary" "\
Update all diary sections in a day plan file.
If FORCE is non-nil, insert a diary section even if there is no section header.
Inserts only diaries if the corresponding `planner-diary-use-*' variable is t.

\(fn &optional FORCE)" t nil)

(autoload 'planner-diary-insert-all-diaries-maybe "planner-diary" "\
Update all diary sections in a day plan file.
If the current day is in the past and FORCE is nil, don't do anything.
If FORCE is non-nil, insert a diary section even if there is no section header.
Inserts only diaries if the corresponding `planner-diary-use-*' variable is t.

\(fn &optional FORCE)" t nil)

(autoload 'planner-diary-show-day-plan-or-diary "planner-diary" "\
Show the day plan or diary entries for the date under point in calendar.
Add this to `calendar-move-hook' if you want to use it.  In that case you
should also `remove-hook' `planner-calendar-show' from `calendar-move-hook'.

\(fn)" t nil)

(autoload 'planner-diary-insinuate "planner-diary" "\
Hook Diary into Planner.
Automatically insert and update a Diary section in day plan files.
This adds a new key binding to `planner-mode-map':
C-cC-e updates the diary sections.

\(fn)" nil nil)

(defalias 'planner-insinuate-diary 'planner-diary-insinuate)

(autoload 'planner-diary-add-entry "planner-diary" "\
Prompt for a diary entry to add to `diary-file' on DATE.
Uses `planner-annotation-functions' to make hyperlinks.
TIME and TEXT are used in the description.

\(fn DATE TIME TEXT)" t nil)

;;;***

;;;### (autoloads (planner-erc-browse-url planner-erc-annotation-from-erc)
;;;;;;  "planner-erc" "../package.d/planner-el/planner-erc.el" (18785
;;;;;;  2890))
;;; Generated autoloads from ../package.d/planner-el/planner-erc.el

(autoload 'planner-erc-annotation-from-erc "planner-erc" "\
Return an annotation for the current line.
This function can be added to `planner-annotation-functions'.

\(fn)" nil nil)

(autoload 'planner-erc-browse-url "planner-erc" "\
If this is an IRC URL, jump to it.

\(fn URL)" nil nil)

;;;***

;;;### (autoloads (planner-export-diary planner-export-diary-setup
;;;;;;  planner-export-diary-future) "planner-export-diary" "../package.d/planner-el/planner-export-diary.el"
;;;;;;  (18785 2890))
;;; Generated autoloads from ../package.d/planner-el/planner-export-diary.el

(autoload 'planner-export-diary-future "planner-export-diary" "\
Exports only `planner-export-number-of-days' days of entries.
This function can be put into your `after-save-hook'.

\(fn)" t nil)

(autoload 'planner-export-diary-setup "planner-export-diary" "\
Add `planner-export-diary-future' to `after-save-hook' in planner buffers.
You can add this function to `planner-mode-hook'.

\(fn)" nil nil)

(autoload 'planner-export-diary "planner-export-diary" "\
Exports all the schedules or the ones from FROM to TO (inclusive).

\(fn &optional FROM TO)" t nil)

;;;***

;;;### (autoloads (planner-gnats-browse-url planner-gnats-annotation-from-gnats)
;;;;;;  "planner-gnats" "../package.d/planner-el/planner-gnats.el"
;;;;;;  (18785 2890))
;;; Generated autoloads from ../package.d/planner-el/planner-gnats.el

(autoload 'planner-gnats-annotation-from-gnats "planner-gnats" "\
If called from gnats-edit or gnats-view buffer, return an annotation.
Suitable for use in `planner-annotation-functions'.

\(fn)" nil nil)

(autoload 'planner-gnats-browse-url "planner-gnats" "\
If this is a Gnats URL, view the pr (view-pr).

\(fn URL)" nil nil)

;;;***

;;;### (autoloads (planner-gnus-browse-url planner-gnus-annotation
;;;;;;  planner-gnus-insinuate) "planner-gnus" "../package.d/planner-el/planner-gnus.el"
;;;;;;  (18785 2890))
;;; Generated autoloads from ../package.d/planner-el/planner-gnus.el

(autoload 'planner-gnus-insinuate "planner-gnus" "\
Hook Planner into Gnus.

Adds special planner keybindings to the variable
`gnus-summary-article-map'. From a summary or article buffer, you
can type C-c C-t to call planner-create-task-from-buffer.

\(fn)" nil nil)

(autoload 'planner-gnus-annotation "planner-gnus" "\
Return an annotation from a Gnus summary or message buffer.
Suitable for use in `planner-annotation-functions'. If you
include this, you can omit `planner-gnus-annotation-from-summary'
and `planner-gnus-annotation-from-message'.

\(fn)" nil nil)

(autoload 'planner-gnus-browse-url "planner-gnus" "\
If this is a Gnus URL, jump to it.

\(fn URL)" nil nil)

;;;***

;;;### (autoloads (planner-id-setup planner-id-update-tasks-maybe
;;;;;;  planner-id-markup planner-id-add-task-id-maybe planner-id-jump-to-linked-task
;;;;;;  planner-id-find-task) "planner-id" "../package.d/planner-el/planner-id.el"
;;;;;;  (18785 2890))
;;; Generated autoloads from ../package.d/planner-el/planner-id.el

(autoload 'planner-id-find-task "planner-id" "\
Find task described by TASK-INFO. If POINT is non-nil, start from there.
If task is found, move point to line beginning and return non-nil.
If task is not found, leave point at POINT or the start of the buffer
and return nil.

\(fn TASK-INFO &optional POINT)" nil nil)

(autoload 'planner-id-jump-to-linked-task "planner-id" "\
Display the linked task page.
If INFO is specified, follow that task instead.

\(fn &optional INFO)" t nil)

(autoload 'planner-id-add-task-id-maybe "planner-id" "\
Add task ID if `planner-id-add-task-id-flag' is non-nil.

\(fn)" nil nil)

(autoload 'planner-id-markup "planner-id" "\
Highlight IDs as unobtrusive, clickable text from BEG to END.
VERBOSE is ignored.

\(fn BEG END &optional VERBOSE)" nil nil)

(autoload 'planner-id-update-tasks-maybe "planner-id" "\
Update tasks depending on the value of `planner-id-update-automatically'.

\(fn)" nil nil)

(autoload 'planner-id-setup "planner-id" "\
Hook into `planner-mode'.

\(fn)" nil nil)

;;;***

;;;### (autoloads (planner-ledger-insert-maybe) "planner-ledger"
;;;;;;  "../package.d/planner-el/planner-ledger.el" (18785 2890))
;;; Generated autoloads from ../package.d/planner-el/planner-ledger.el

(autoload 'planner-ledger-insert-maybe "planner-ledger" "\
Maybe insert ledger sections into a Planner page.

\(fn)" t nil)

;;;***

;;;### (autoloads (planner-lisp-browse-url) "planner-lisp" "../package.d/planner-el/planner-lisp.el"
;;;;;;  (18785 2890))
;;; Generated autoloads from ../package.d/planner-el/planner-lisp.el

(autoload 'planner-lisp-browse-url "planner-lisp" "\
If this is a LISP URL, evaluate it.

\(fn URL)" nil nil)

;;;***

;;;### (autoloads (planner-log-edit-add-note) "planner-log-edit"
;;;;;;  "../package.d/planner-el/planner-log-edit.el" (18785 2890))
;;; Generated autoloads from ../package.d/planner-el/planner-log-edit.el

(autoload 'planner-log-edit-add-note "planner-log-edit" "\
Add a note describing the commit to the current planner page.

\(fn)" nil nil)

;;;***

;;;### (autoloads (planner-mhe-browse-url planner-mhe-annotation)
;;;;;;  "planner-mhe" "../package.d/planner-el/planner-mhe.el" (18785
;;;;;;  2890))
;;; Generated autoloads from ../package.d/planner-el/planner-mhe.el

(autoload 'planner-mhe-annotation "planner-mhe" "\
If called from a MH-E folder or message buffer, return an annotation.
Suitable for use in `planner-annotation-functions'.

\(fn)" nil nil)

(autoload 'planner-mhe-browse-url "planner-mhe" "\
If this is a MH-E URL, jump to it.

\(fn URL)" nil nil)

;;;***

;;;### (autoloads (planner-multi-remove-task-from-pool) "planner-multi"
;;;;;;  "../package.d/planner-el/planner-multi.el" (18785 2890))
;;; Generated autoloads from ../package.d/planner-el/planner-multi.el

(autoload 'planner-multi-remove-task-from-pool "planner-multi" "\
Remove completed tasks from `planner-multi-copy-tasks-to-page' if that still leaves them linked.

\(fn OLD-STATUS NEW-STATUS)" nil nil)

;;;***

;;;### (autoloads (planner-notes-index-years planner-notes-index-months
;;;;;;  planner-notes-index-weeks planner-notes-index-days planner-notes-index
;;;;;;  planner-notes-index-month-table-tag planner-notes-index-tag)
;;;;;;  "planner-notes-index" "../package.d/planner-el/planner-notes-index.el"
;;;;;;  (18785 2890))
;;; Generated autoloads from ../package.d/planner-el/planner-notes-index.el

(autoload 'planner-notes-index-tag "planner-notes-index" "\
Mark up planner-notes-index tags.

Tags can be of the form:

  <planner-notes-index page=\"2004.03.02\">
  <planner-notes-index from=\"2004.03.01\" to=\"2004.03.31\">
  <planner-notes-index limit=\"10\">

\(fn TAG-BEG TAG-END ATTRS)" nil nil)

(autoload 'planner-notes-index-month-table-tag "planner-notes-index" "\
Mark up a month note index.  Tag is from BEG to END.
ATTRS is a list of attributes. \"Month\" is a yyyy.mm
 string (default: current month). \"Limit\" is the maximum number
 of items per day (default: all).

Examples:
<planner-notes-index-month-table month=\"2004.02\">
<planner-notes-index-month-table month=\"2004.02\" limit=\"4\">

\(fn BEG END ATTRS)" nil nil)

(autoload 'planner-notes-index "planner-notes-index" "\
Display a clickable notes index.
If called from a Lisp program, display only dates between FROM
and TO. With a prefix arg LIMIT, display only that number of
entries.

\(fn &optional FROM TO LIMIT)" t nil)

(autoload 'planner-notes-index-days "planner-notes-index" "\
Display an index of notes posted over the past few DAYS.
The list ends with the day of the current buffer or `planner-today'.

\(fn DAYS)" t nil)

(autoload 'planner-notes-index-weeks "planner-notes-index" "\
Display an index of notes posted over the past few WEEKS.
The list ends with the week of the current buffer or `planner-today'.
Weeks start from Sunday.

\(fn WEEKS)" t nil)

(autoload 'planner-notes-index-months "planner-notes-index" "\
Display an index of notes posted over the past few MONTHS.
The list ends with the month of the current buffer or `planner-today'.

\(fn MONTHS)" t nil)

(autoload 'planner-notes-index-years "planner-notes-index" "\
Display an index of notes posted over the past few YEARS.
The current year is included.

\(fn YEARS)" t nil)

;;;***

;;;### (autoloads (planner-psvn-log-edit-add-note planner-psvn-browse-url
;;;;;;  planner-annotation-from-psvn) "planner-psvn" "../package.d/planner-el/planner-psvn.el"
;;;;;;  (18785 2890))
;;; Generated autoloads from ../package.d/planner-el/planner-psvn.el

(autoload 'planner-annotation-from-psvn "planner-psvn" "\
If called from a psvn  *svn-log-view* buffer, return an annotation.
Suitable for use in `planner-annotation-functions'.

\(fn)" nil nil)

(autoload 'planner-psvn-browse-url "planner-psvn" "\
If this is a psvn url, handle it.

\(fn URL)" nil nil)

(autoload 'planner-psvn-log-edit-add-note "planner-psvn" "\
Add a note describing the commit via psvn to the current planner page.

\(fn)" nil nil)

;;;***

;;;### (autoloads (planner-rank-update-all planner-rank-update-current-task
;;;;;;  planner-rank-change planner-sort-tasks-by-urgency planner-sort-tasks-by-importance
;;;;;;  planner-sort-tasks-by-rank) "planner-rank" "../package.d/planner-el/planner-rank.el"
;;;;;;  (18785 2890))
;;; Generated autoloads from ../package.d/planner-el/planner-rank.el

(autoload 'planner-sort-tasks-by-rank "planner-rank" "\
Sort tasks by status (_PDXC), priority (ABC), and rank.
Suitable for `planner-sort-tasks-key-function'

\(fn)" nil nil)

(autoload 'planner-sort-tasks-by-importance "planner-rank" "\
Sort tasks by status (_PDXC), priority (ABC), and importance.
Suitable for `planner-sort-tasks-key-function'

\(fn)" nil nil)

(autoload 'planner-sort-tasks-by-urgency "planner-rank" "\
Sort tasks by status (_PDXC), priority (ABC), and urgency.
Suitable for `planner-sort-tasks-key-function'

\(fn)" nil nil)

(autoload 'planner-rank-change "planner-rank" "\
Change the IMPORTANCE and URGENCY of the current task.
If there's deadline available, calculate urgency instead of asking
the user.

\(fn &optional IMPORTANCE URGENCY)" t nil)

(autoload 'planner-rank-update-current-task "planner-rank" "\
Re-calculate rank for the current task.

\(fn)" t nil)

(autoload 'planner-rank-update-all "planner-rank" "\
Re-calculate rank for all tasks in the current page.

\(fn)" t nil)

;;;***

;;;### (autoloads (planner-rdf-publish-index planner-rdf-publish-file)
;;;;;;  "planner-rdf" "../package.d/planner-el/planner-rdf.el" (18785
;;;;;;  2890))
;;; Generated autoloads from ../package.d/planner-el/planner-rdf.el

(autoload 'planner-rdf-publish-file "planner-rdf" "\
Publish the file in RDF format, if called by PlannerMode.
Designed to be called via `muse-after-publish-hook'.
Non-Planner files, matching `muse-image-regexp' will be treated
differently. Currently they are simply ignored.

\(fn FILE)" t nil)

(autoload 'planner-rdf-publish-index "planner-rdf" "\
Create an index for the .rdf files.
Will be called via `muse-after-publish-hook'.
Creates index.rdf, a rdf:bag, with all existing .rdf files as
items.

\(fn)" t nil)

;;;***

;;;### (autoloads (planner-registry-initialize) "planner-registry"
;;;;;;  "../package.d/planner-el/planner-registry.el" (18785 2890))
;;; Generated autoloads from ../package.d/planner-el/planner-registry.el

(autoload 'planner-registry-initialize "planner-registry" "\
Set `planner-registry-alist' from `planner-registry-file'.
If `planner-registry-file' doesn't exist, create it.
If FROM-SCRATCH is non-nil, make the registry from scratch.

\(fn &optional FROM-SCRATCH)" t nil)

;;;***

;;;### (autoloads (planner-report-generate) "planner-report" "../package.d/planner-el/planner-report.el"
;;;;;;  (18785 2890))
;;; Generated autoloads from ../package.d/planner-el/planner-report.el

(autoload 'planner-report-generate "planner-report" "\
Generate a status report spanning a period from BEGIN to END.
BEGIN and END are in the format YYYY.MM.DD.

\(fn BEGIN END)" t nil)

;;;***

;;;### (autoloads (planner-rmail-browse-url planner-rmail-annotation-from-mail)
;;;;;;  "planner-rmail" "../package.d/planner-el/planner-rmail.el"
;;;;;;  (18785 2890))
;;; Generated autoloads from ../package.d/planner-el/planner-rmail.el

(autoload 'planner-rmail-annotation-from-mail "planner-rmail" "\
Return an annotation for the current message.
This function can be added to `planner-annotation-functions'.

\(fn)" nil nil)

(autoload 'planner-rmail-browse-url "planner-rmail" "\
If this is an RMAIL URL, jump to it.

\(fn URL)" nil nil)

;;;***

;;;### (autoloads (planner-rss-add-note) "planner-rss" "../package.d/planner-el/planner-rss.el"
;;;;;;  (18785 2890))
;;; Generated autoloads from ../package.d/planner-el/planner-rss.el

(autoload 'planner-rss-add-note "planner-rss" "\
Export the current note using `planner-rss-add-item'.
If FEED is non-nil, add the note to the specified feed only.
Call with the interactive prefix in order to be prompted for FEED.

\(fn &optional FEED)" t nil)

;;;***

;;;### (autoloads (planner-schedule-show-end-project) "planner-schedule"
;;;;;;  "../package.d/planner-el/planner-schedule.el" (18785 2890))
;;; Generated autoloads from ../package.d/planner-el/planner-schedule.el

(autoload 'planner-schedule-show-end-project "planner-schedule" "\
Display the estimated project completion time.

\(fn)" t nil)

;;;***

;;;### (autoloads (planner-tasks-overview-show-summary planner-tasks-overview-jump
;;;;;;  planner-tasks-overview-jump-other-window planner-tasks-overview)
;;;;;;  "planner-tasks-overview" "../package.d/planner-el/planner-tasks-overview.el"
;;;;;;  (18785 2890))
;;; Generated autoloads from ../package.d/planner-el/planner-tasks-overview.el

(autoload 'planner-tasks-overview "planner-tasks-overview" "\
Display a task overview from START to END.

\(fn START END)" t nil)

(autoload 'planner-tasks-overview-jump-other-window "planner-tasks-overview" "\
Display the task under point in a different window.

\(fn)" t nil)

(autoload 'planner-tasks-overview-jump "planner-tasks-overview" "\
Display the task under point.

\(fn &optional OTHER-WINDOW)" t nil)

(autoload 'planner-tasks-overview-show-summary "planner-tasks-overview" "\
Count unscheduled, scheduled, and completed tasks for FILE-LIST.
If called with an interactive prefix, prompt for the page(s) to
display. planner-multi is required for multiple pages.

\(fn &optional FILE-LIST)" t nil)

;;;***

;;;### (autoloads (planner-colors-timeclock-report-tag) "planner-timeclock"
;;;;;;  "../package.d/planner-el/planner-timeclock.el" (18785 2890))
;;; Generated autoloads from ../package.d/planner-el/planner-timeclock.el

(autoload 'planner-colors-timeclock-report-tag "planner-timeclock" "\
Replace the region BEG to END with a timeclock report, colorizing
the result.

\(fn BEG END)" nil nil)

;;;***

;;;### (autoloads (planner-timeclock-summary-show-2 planner-timeclock-summary-show-range-filter
;;;;;;  planner-timeclock-summary-show-filter planner-timeclock-summary-show
;;;;;;  planner-timeclock-summary-update planner-timeclock-summary-insinuate)
;;;;;;  "planner-timeclock-summary" "../package.d/planner-el/planner-timeclock-summary.el"
;;;;;;  (18785 2890))
;;; Generated autoloads from ../package.d/planner-el/planner-timeclock-summary.el

(autoload 'planner-timeclock-summary-insinuate "planner-timeclock-summary" "\
Automatically call `planner-timeclock-summary-update'.
This function is called when the day page is saved.

\(fn)" nil nil)

(autoload 'planner-timeclock-summary-update "planner-timeclock-summary" "\
Update `planner-timeclock-summary-section'. in the current day page.
The section is updated only if it exists.

\(fn)" t nil)

(autoload 'planner-timeclock-summary-show "planner-timeclock-summary" "\
Display a buffer with the timeclock summary for DATE.
Date is a string in the form YYYY.MM.DD.

\(fn &optional DATE)" t nil)

(autoload 'planner-timeclock-summary-show-filter "planner-timeclock-summary" "\
Show a timeclock report filtered by FILTER for DATE.

If FILTER is a regexp, only plan pages matching that regexp will
be included. If FILTER is a function, it will be called with the
current timeclock item, and the line considered if the function
returned non-nil.

If called interactively, prompt for FILTER (a regexp) and DATE.
DATE is a string in the form YYYY.MM.DD and can be nil.

\(fn FILTER DATE)" t nil)

(autoload 'planner-timeclock-summary-show-range-filter "planner-timeclock-summary" "\
Show a timeclock report filtered by FILTER for START-DATE to END-DATE.

If FILTER is a regexp, only plan pages matching that regexp will
be included. If FILTER is a function, it will be called with the
current timeclock item, and the line considered if the function
returned non-nil.

If called interactively, prompt for FILTER (a regexp), START-DATE and END-DATE.
Dates are strings in the form YYYY.MM.DD and can be nil.

\(fn FILTER START-DATE END-DATE)" t nil)

(autoload 'planner-timeclock-summary-show-2 "planner-timeclock-summary" "\
Display a buffer with the timeclock summary for DATE.

Date is a string in the form YYYY.MM.DD. It will be asked if not
given.

\(fn &optional DATE)" t nil)

;;;***

;;;### (autoloads (planner-timeclock-summary-proj-report planner-timeclock-summary-proj-current
;;;;;;  planner-timeclock-summary-proj-all) "planner-timeclock-summary-proj"
;;;;;;  "../package.d/planner-el/planner-timeclock-summary-proj.el"
;;;;;;  (18785 2890))
;;; Generated autoloads from ../package.d/planner-el/planner-timeclock-summary-proj.el

(autoload 'planner-timeclock-summary-proj-all "planner-timeclock-summary-proj" "\
Insert time report for all projects in the current buffer.

\(fn)" t nil)

(autoload 'planner-timeclock-summary-proj-current "planner-timeclock-summary-proj" "\
Insert time report for the current project in the current buffer.

\(fn)" t nil)

(autoload 'planner-timeclock-summary-proj-report "planner-timeclock-summary-proj" "\
Insert time report for PROJECT in the current buffer.

\(fn PROJECT)" t nil)

;;;***

;;;### (autoloads (planner-trunk-tasks) "planner-trunk" "../package.d/planner-el/planner-trunk.el"
;;;;;;  (18785 2890))
;;; Generated autoloads from ../package.d/planner-el/planner-trunk.el

(autoload 'planner-trunk-tasks "planner-trunk" "\
Trunk(group) tasks in the current page.
Please refer the docstring of `planner-trunk-rule-list' for how
it works. You may want to call this function before you sort tasks
and/or after you create new tasks. If a prefix is given or FORCE is not
nil, trunk completed tasks together with non-completed tasks not
matter what the `planner-trunk-rule-list' said.

\(fn &optional FORCE)" t nil)

;;;***

;;;### (autoloads (planner-unix-mail-browse-url planner-unix-mail-annotation-from-mail)
;;;;;;  "planner-unix-mail" "../package.d/planner-el/planner-unix-mail.el"
;;;;;;  (18785 2890))
;;; Generated autoloads from ../package.d/planner-el/planner-unix-mail.el

(autoload 'planner-unix-mail-annotation-from-mail "planner-unix-mail" "\
Return an annotation for the current message.
This function can be added to `planner-annotation-functions'.

\(fn)" nil nil)

(autoload 'planner-unix-mail-browse-url "planner-unix-mail" "\
If this is an UNIX-MAIL URL, jump to it.

\(fn URL)" nil nil)

;;;***

;;;### (autoloads (planner-vm-browse-url planner-vm-annotation-from-mail)
;;;;;;  "planner-vm" "../package.d/planner-el/planner-vm.el" (18785
;;;;;;  2890))
;;; Generated autoloads from ../package.d/planner-el/planner-vm.el

(autoload 'planner-vm-annotation-from-mail "planner-vm" "\
Return an annotation for the current message.
This function can be added to `planner-annotation-functions'.

\(fn)" nil nil)

(autoload 'planner-vm-browse-url "planner-vm" "\
If this is an VM URL, jump to it.

\(fn URL)" nil nil)

;;;***

;;;### (autoloads (planner-w3m-annotation-from-w3m) "planner-w3m"
;;;;;;  "../package.d/planner-el/planner-w3m.el" (18785 2890))
;;; Generated autoloads from ../package.d/planner-el/planner-w3m.el

(autoload 'planner-w3m-annotation-from-w3m "planner-w3m" "\
If called from a w3m page, return an annotation.
Suitable for use in `planner-annotation-functions'.

\(fn)" nil nil)

;;;***

;;;### (autoloads (planner-wl-browse-url planner-wl-annotation-from-wl
;;;;;;  planner-wl-insinuate) "planner-wl" "../package.d/planner-el/planner-wl.el"
;;;;;;  (18785 2890))
;;; Generated autoloads from ../package.d/planner-el/planner-wl.el

(autoload 'planner-wl-insinuate "planner-wl" "\
Hook Planner into Wanderlust.
Add special planner keybindings to`wl-summary-mode-map'.
From the Wanderlust Summary view, you can type C-c C-t to create a task.

\(fn)" nil nil)

(autoload 'planner-wl-annotation-from-wl "planner-wl" "\
If called from wl, return an annotation.
Suitable for use in `planner-annotation-functions'.

\(fn)" nil nil)

(autoload 'planner-wl-browse-url "planner-wl" "\
If this is a Wanderlust URL, jump to it.

\(fn URL)" nil nil)

;;;***

;;;### (autoloads (planner-xtla-log-edit-add-note planner-xtla-browse-url
;;;;;;  planner-annotation-from-xtla) "planner-xtla" "../package.d/planner-el/planner-xtla.el"
;;;;;;  (18785 2890))
;;; Generated autoloads from ../package.d/planner-el/planner-xtla.el

(autoload 'planner-annotation-from-xtla "planner-xtla" "\
If called from a xtla buffer, return an annotation.
Suitable for use in `planner-annotation-functions'.

\(fn)" nil nil)

(autoload 'planner-xtla-browse-url "planner-xtla" "\
If this is a xtla url, handle it.

\(fn URL)" nil nil)

(autoload 'planner-xtla-log-edit-add-note "planner-xtla" "\
Provide `planner-log-edit'-like functionality for xtla.
This function is automatically called by `tla-commit-hook'.
See also `planner-xtla-log-edit-notice-commit-function'.

\(fn)" t nil)

;;;***

;;;### (autoloads (svn-status svn-checkout) "psvn" "../package.d/psvn.el"
;;;;;;  (18789 2764))
;;; Generated autoloads from ../package.d/psvn.el

(autoload 'svn-checkout "psvn" "\
Run svn checkout REPOS-URL PATH.

\(fn REPOS-URL PATH)" t nil)
 (defalias 'svn-examine 'svn-status)

(autoload 'svn-status "psvn" "\
Examine the status of Subversion working copy in directory DIR.
If ARG is -, allow editing of the parameters. One could add -N to
run svn status non recursively to make it faster.
For every other non nil ARG pass the -u argument to `svn status', which
asks svn to connect to the repository and check to see if there are updates
there.

If there is no .svn directory, examine if there is CVS and run
`cvs-examine'. Otherwise ask if to run `dired'.

\(fn DIR &optional ARG)" t nil)

;;;***

;;;### (autoloads (remember-diary-extract-entries remember-clipboard
;;;;;;  remember-other-frame remember) "remember" "../package.d/remember-el/remember.el"
;;;;;;  (18785 2915))
;;; Generated autoloads from ../package.d/remember-el/remember.el

(autoload 'remember "remember" "\
Remember an arbitrary piece of data.
INITIAL is the text to initially place in the *Remember* buffer,
or nil to bring up a blank *Remember* buffer.

With a prefix or a visible region, use the region as INITIAL.

\(fn &optional INITIAL)" t nil)

(autoload 'remember-other-frame "remember" "\
Call `remember' in another frame.

\(fn &optional INITIAL)" t nil)

(autoload 'remember-clipboard "remember" "\
Remember the contents of the current clipboard.
Most useful for remembering things from Netscape or other X Windows
application.

\(fn)" t nil)

(autoload 'remember-diary-extract-entries "remember" "\
Extract diary entries from the region.

\(fn)" nil nil)

;;;***

;;;### (autoloads (remember-bbdb-store-in-mailbox) "remember-bbdb"
;;;;;;  "../package.d/remember-el/remember-bbdb.el" (18785 2915))
;;; Generated autoloads from ../package.d/remember-el/remember-bbdb.el

(autoload 'remember-bbdb-store-in-mailbox "remember-bbdb" "\
Store remember data as if it were incoming mail.
In which case `remember-mailbox' should be the name of the mailbox.
Each piece of psuedo-mail created will have an `X-Todo-Priority'
field, for the purpose of appropriate splitting.

\(fn)" nil nil)

;;;***

;;;### (autoloads (remember-location remember-url) "remember-bibl"
;;;;;;  "../package.d/remember-el/remember-bibl.el" (18785 2915))
;;; Generated autoloads from ../package.d/remember-el/remember-bibl.el

(autoload 'remember-url "remember-bibl" "\
Remember a URL in `bibl-mode' that is being visited with w3.

\(fn)" t nil)

(autoload 'remember-location "remember-bibl" "\
Remember a bookmark location in `bibl-mode'.

\(fn)" t nil)

;;;***

;;;### (autoloads (remember-blosxom) "remember-blosxom" "../package.d/remember-el/remember-blosxom.el"
;;;;;;  (18785 2915))
;;; Generated autoloads from ../package.d/remember-el/remember-blosxom.el

(autoload 'remember-blosxom "remember-blosxom" "\
Remember this text to a blosxom story.
This function can be added to `remember-handler-functions'.

\(fn)" nil nil)

;;;***

;;;### (autoloads (remember-emacs-wiki-journal-add-entry-maybe remember-emacs-wiki-journal-add-entry-auto
;;;;;;  remember-emacs-wiki-journal-add-entry) "remember-emacs-wiki-journal"
;;;;;;  "../package.d/remember-el/remember-emacs-wiki-journal.el"
;;;;;;  (18785 2915))
;;; Generated autoloads from ../package.d/remember-el/remember-emacs-wiki-journal.el

(autoload 'remember-emacs-wiki-journal-add-entry "remember-emacs-wiki-journal" "\
Prompt for category and heading and add entry.

\(fn)" nil nil)

(autoload 'remember-emacs-wiki-journal-add-entry-auto "remember-emacs-wiki-journal" "\
Add entry where the category is the first word and the heading the
rest of the words on the first line.

\(fn)" nil nil)

(autoload 'remember-emacs-wiki-journal-add-entry-maybe "remember-emacs-wiki-journal" "\
Like `remember-emacs-wiki-journal-add-entry-auto' but only adds
entry if the first line matches `emacs-wiki-journal-category-regexp'.

\(fn)" nil nil)

;;;***

;;;### (autoloads (remember-planner-append) "remember-planner" "../package.d/remember-el/remember-planner.el"
;;;;;;  (18785 2915))
;;; Generated autoloads from ../package.d/remember-el/remember-planner.el

(autoload 'remember-planner-append "remember-planner" "\
Remember this text to PAGE or today's page.
This function can be added to `remember-handler-functions'.

\(fn &optional PAGE)" nil nil)

;;;***

;;;### (autoloads (rst-minor-mode rst-mode) "rst" "../package.d/rst.el"
;;;;;;  (18784 41537))
;;; Generated autoloads from ../package.d/rst.el

(autoload 'rst-mode "rst" "\
Not documented

\(fn)" t nil)

(autoload 'rst-minor-mode "rst" "\
ReST Minor Mode.
Toggle ReST minor mode.
With no argument, this command toggles the mode.
Non-null prefix argument turns on the mode.
Null prefix argument turns off the mode.

When ReST minor mode is enabled, the ReST mode
keybindings are installed on top of the major
mode bindings. Use this for modes derived from
text-mode, like mail-mode..

\(fn &optional ARG)" t nil)

;;;***

;;;### (autoloads (schedule-completion-time) "schedule" "../package.d/planner-el/contrib/schedule.el"
;;;;;;  (18785 2890))
;;; Generated autoloads from ../package.d/planner-el/contrib/schedule.el

(autoload 'schedule-completion-time "schedule" "\
Advance THEN by COUNT seconds, skipping the weekends and holidays.
THEN must not already be in a holiday or non-worktime.  Make sure that
`schedule-align-now' is called at least once before this function ever
gets called.

\(fn THEN COUNT)" nil nil)

;;;***

;;;### (autoloads (timeclock-when-to-leave-string timeclock-workday-elapsed-string
;;;;;;  timeclock-workday-remaining-string timeclock-reread-log timeclock-query-out
;;;;;;  timeclock-change timeclock-status-string timeclock-out timeclock-in
;;;;;;  timeclock-modeline-display) "timeclock" "../package.d/planner-el/contrib/timeclock.el"
;;;;;;  (18785 2890))
;;; Generated autoloads from ../package.d/planner-el/contrib/timeclock.el

(autoload 'timeclock-modeline-display "timeclock" "\
Toggle display of the amount of time left today in the modeline.
If `timeclock-use-display-time' is non-nil (the default), then
the function `display-time-mode' must be active, and the modeline
will be updated whenever the time display is updated.  Otherwise,
the timeclock will use its own sixty second timer to do its
updating.  With prefix ARG, turn modeline display on if and only
if ARG is positive.  Returns the new status of timeclock modeline
display (non-nil means on).

\(fn &optional ARG)" t nil)

(autoload 'timeclock-in "timeclock" "\
Clock in, recording the current time moment in the timelog.
With a numeric prefix ARG, record the fact that today has only that
many hours in it to be worked.  If arg is a non-numeric prefix arg
\(non-nil, but not a number), 0 is assumed (working on a holiday or
weekend).  *If not called interactively, ARG should be the number of
_seconds_ worked today*.  This feature only has effect the first time
this function is called within a day.

PROJECT is the project being clocked into.  If PROJECT is nil, and
FIND-PROJECT is non-nil -- or the user calls `timeclock-in'
interactively -- call the function `timeclock-get-project-function' to
discover the name of the project.

\(fn &optional ARG PROJECT FIND-PROJECT)" t nil)

(autoload 'timeclock-out "timeclock" "\
Clock out, recording the current time moment in the timelog.
If a prefix ARG is given, the user has completed the project that was
begun during the last time segment.

REASON is the user's reason for clocking out.  If REASON is nil, and
FIND-REASON is non-nil -- or the user calls `timeclock-out'
interactively -- call the function `timeclock-get-reason-function' to
discover the reason.

\(fn &optional ARG REASON FIND-REASON)" t nil)

(autoload 'timeclock-status-string "timeclock" "\
Report the overall timeclock status at the present moment.
If SHOW-SECONDS is non-nil, display second resolution.
If TODAY-ONLY is non-nil, the display will be relative only to time
worked today, ignoring the time worked on previous days.

\(fn &optional SHOW-SECONDS TODAY-ONLY)" t nil)

(autoload 'timeclock-change "timeclock" "\
Change to working on a different project.
This clocks out of the current project, then clocks in on a new one.
With a prefix ARG, consider the previous project as finished at the
time of changeover.  PROJECT is the name of the last project you were
working on.

\(fn &optional ARG PROJECT)" t nil)

(autoload 'timeclock-query-out "timeclock" "\
Ask the user whether to clock out.
This is a useful function for adding to `kill-emacs-query-functions'.

\(fn)" nil nil)

(autoload 'timeclock-reread-log "timeclock" "\
Re-read the timeclock, to account for external changes.
Returns the new value of `timeclock-discrepancy'.

\(fn)" t nil)

(autoload 'timeclock-workday-remaining-string "timeclock" "\
Return a string representing the amount of time left today.
Display second resolution if SHOW-SECONDS is non-nil.  If TODAY-ONLY
is non-nil, the display will be relative only to time worked today.
See `timeclock-relative' for more information about the meaning of
\"relative to today\".

\(fn &optional SHOW-SECONDS TODAY-ONLY)" t nil)

(autoload 'timeclock-workday-elapsed-string "timeclock" "\
Return a string representing the amount of time worked today.
Display seconds resolution if SHOW-SECONDS is non-nil.  If RELATIVE is
non-nil, the amount returned will be relative to past time worked.

\(fn &optional SHOW-SECONDS)" t nil)

(autoload 'timeclock-when-to-leave-string "timeclock" "\
Return a string representing the end of today's workday.
This string is relative to the value of `timeclock-workday'.  If
SHOW-SECONDS is non-nil, the value printed/returned will include
seconds.  If TODAY-ONLY is non-nil, the value returned will be
relative only to the time worked today, and not to past time.

\(fn &optional SHOW-SECONDS TODAY-ONLY)" t nil)

;;;***

;;;### (autoloads (w3m-buffer w3m-region w3m-find-file w3m-browse-url
;;;;;;  w3m w3m-gohome w3m-goto-url-new-session w3m-goto-url w3m-download
;;;;;;  w3m-retrieve) "w3m" "../package.d/w3m-el/w3m.el" (18777 43742))
;;; Generated autoloads from ../package.d/w3m-el/w3m.el

(autoload 'w3m-retrieve "w3m" "\
Retrieve web contents pointed to by URL.
It will put the retrieved contents into the current buffer.

If HANDLER is nil, this function will retrieve web contents, return
the content type of the retrieved data, and then come to an end.  This
behavior is what is called a synchronous operation.  You have to
specify HANDLER in order to make this function show its real ability,
which is called an asynchronous operation.

If HANDLER is a function, this function will come to an end in no time.
In this case, contents will be retrieved by the asynchronous process
after a while.  And after finishing retrieving contents successfully,
HANDLER will be called on the buffer where this function starts.  The
content type of the retrieved data will be passed to HANDLER as a
string argument.

NO-UNCOMPRESS specifies whether this function should not uncompress contents.
NO-CACHE specifies whether this function should not use cached contents.
POST-DATA and REFERER will be sent to the web server with a request.

\(fn URL &optional NO-UNCOMPRESS NO-CACHE POST-DATA REFERER HANDLER)" nil nil)

(autoload 'w3m-download "w3m" "\
Download contents of URL to a file named FILENAME.
NO-CHACHE (which the prefix argument gives when called interactively)
specifies not using the cached data.

\(fn URL &optional FILENAME NO-CACHE HANDLER POST-DATA)" t nil)

(autoload 'w3m-goto-url "w3m" "\
Visit World Wide Web pages.  This is the primitive function of `w3m'.
If the second argument RELOAD is non-nil, reload a content of URL.
Except that if it is 'redisplay, re-display the page without reloading.
The third argument CHARSET specifies a charset to be used for decoding
a content.
The fourth argument POST-DATA should be a string or a cons cell.  If
it is a string, it makes this function request a body as if the
content-type is \"x-www-form-urlencoded\".  If it is a cons cell, the
car of a cell is used as the content-type and the cdr of a cell is
used as the body.
If the fifth argument REFERER is specified, it is used for a Referer:
field for this request.
The remaining HANDLER and ELEMENT[1] are for the internal operations
of emacs-w3m.
You can also use \"quicksearch\" url schemes such as \"gg:emacs\" which
would search for the term \"emacs\" with the Google search engine.  See
the `w3m-search' function and the variable `w3m-uri-replace-alist'.

\[1] A note for the developers: ELEMENT is a history element which has
already been registered in the `w3m-history-flat' variable.  It is
corresponding to URL to be retrieved at this time, not for the url of
the current page.

\(fn URL &optional RELOAD CHARSET POST-DATA REFERER HANDLER ELEMENT)" t nil)

(autoload 'w3m-goto-url-new-session "w3m" "\
Visit World Wide Web pages in a new session.
If you invoke this command in the emacs-w3m buffer, the new session
will be created by copying the current session.  Otherwise, the new
session will start afresh.

\(fn URL &optional RELOAD CHARSET POST-DATA REFERER)" t nil)

(autoload 'w3m-gohome "w3m" "\
Go to the Home page.

\(fn)" t nil)

(autoload 'w3m "w3m" "\
Visit World Wide Web pages using the external w3m command.

When you invoke this command interactively for the first time, it will
visit a page which is pointed to by a string like url around the
cursor position or the home page specified by the `w3m-home-page'
variable, but you will be prompted for a URL if `w3m-quick-start' is
nil (default t) or `w3m-home-page' is nil.

The variables `w3m-pop-up-windows' and `w3m-pop-up-frames' control
whether this command should pop to a window or a frame up for the
session.

When emacs-w3m sessions have already been opened, this command will
pop to the existing window or frame up, but if `w3m-quick-start' is
nil, (default t), you will be prompted for a URL (which defaults to
`popup' meaning to pop to an existing emacs-w3m buffer up).

In addition, if the prefix argument is given or you enter the empty
string for the prompt, it will visit the home page specified by the
`w3m-home-page' variable or the \"about:\" page.

You can also run this command in the batch mode as follows:

  emacs -f w3m http://emacs-w3m.namazu.org/ &

In that case, or if this command is called non-interactively, the
variables `w3m-pop-up-windows' and `w3m-pop-up-frames' will be ignored
\(treated as nil) and it will run emacs-w3m at the current (or the
initial) window.

If the optional NEW-SESSION is non-nil, this function makes a new
emacs-w3m buffer.  Besides that, it also makes a new emacs-w3m buffer
if `w3m-make-new-session' is non-nil and a user specifies a url string.

The optional INTERACTIVE-P is for the internal use; it is mainly used
to check whether Emacs 22 or later calls this function as an
interactive command in the batch mode.

\(fn &optional URL NEW-SESSION INTERACTIVE-P)" t nil)

(autoload 'w3m-browse-url "w3m" "\
Ask emacs-w3m to browse URL.
NEW-SESSION specifies whether to create a new emacs-w3m session.  URL
defaults to the string looking like a url around the cursor position.
Pop to a window or a frame up according to `w3m-pop-up-windows' and
`w3m-pop-up-frames'.

\(fn URL &optional NEW-SESSION)" t nil)

(autoload 'w3m-find-file "w3m" "\
Function used to open FILE whose name is expressed in ordinary format.
The file name will be converted into the file: scheme.

\(fn FILE)" t nil)

(autoload 'w3m-region "w3m" "\
Render the region of the current buffer between START and END.
URL specifies the address where the contents come from.  It can be
omitted or nil when the address is not identified.  CHARSET is used
for decoding the contents.  If it is nil, this function attempts to
parse the meta tag to extract the charset.

\(fn START END &optional URL CHARSET)" t nil)

(autoload 'w3m-buffer "w3m" "\
Render the current buffer.
See `w3m-region' for the optional arguments.

\(fn &optional URL CHARSET)" t nil)

;;;***

;;;### (autoloads (w3m-antenna w3m-about-antenna) "w3m-antenna" "../package.d/w3m-el/w3m-antenna.el"
;;;;;;  (18712 53399))
;;; Generated autoloads from ../package.d/w3m-el/w3m-antenna.el

(autoload 'w3m-about-antenna "w3m-antenna" "\
Not documented

\(fn URL &optional NO-DECODE NO-CACHE POST-DATA REFERER HANDLER)" nil nil)

(autoload 'w3m-antenna "w3m-antenna" "\
Report changes of WEB sites, which is specified in `w3m-antenna-sites'.

\(fn &optional NO-CACHE)" t nil)

;;;***

;;;### (autoloads (w3m-setup-bookmark-menu w3m-about-bookmark w3m-bookmark-view-new-session
;;;;;;  w3m-bookmark-view w3m-bookmark-add-current-url-group w3m-bookmark-add-all-urls
;;;;;;  w3m-bookmark-add-current-url w3m-bookmark-add-this-url) "w3m-bookmark"
;;;;;;  "../package.d/w3m-el/w3m-bookmark.el" (18712 53399))
;;; Generated autoloads from ../package.d/w3m-el/w3m-bookmark.el

(autoload 'w3m-bookmark-add-this-url "w3m-bookmark" "\
Add link under cursor to bookmark.

\(fn)" t nil)

(autoload 'w3m-bookmark-add-current-url "w3m-bookmark" "\
Add a url of the current page to the bookmark.
With prefix, ask for a new url instead of the present one.

\(fn &optional ARG)" t nil)

(autoload 'w3m-bookmark-add-all-urls "w3m-bookmark" "\
Add urls of all pages being visited to the bookmark.

\(fn)" t nil)

(autoload 'w3m-bookmark-add-current-url-group "w3m-bookmark" "\
Add link of the group of current urls to the bookmark.

\(fn)" t nil)

(autoload 'w3m-bookmark-view "w3m-bookmark" "\
Display the bookmark.

\(fn &optional RELOAD)" t nil)

(autoload 'w3m-bookmark-view-new-session "w3m-bookmark" "\
Display the bookmark on a new session.

\(fn &optional RELOAD)" t nil)

(autoload 'w3m-about-bookmark "w3m-bookmark" "\
Not documented

\(fn &rest ARGS)" nil nil)

(autoload 'w3m-setup-bookmark-menu "w3m-bookmark" "\
Setup w3m bookmark items in menubar.

\(fn)" nil nil)

;;;***

;;;### (autoloads (w3m-about-cookie w3m-cookie w3m-cookie-get w3m-cookie-set
;;;;;;  w3m-cookie-shutdown) "w3m-cookie" "../package.d/w3m-el/w3m-cookie.el"
;;;;;;  (18537 33443))
;;; Generated autoloads from ../package.d/w3m-el/w3m-cookie.el

(autoload 'w3m-cookie-shutdown "w3m-cookie" "\
Save cookies, and reset cookies' data.

\(fn)" t nil)

(autoload 'w3m-cookie-set "w3m-cookie" "\
Register cookies which correspond to URL.
BEG and END should be an HTTP response header region on current buffer.

\(fn URL BEG END)" nil nil)

(autoload 'w3m-cookie-get "w3m-cookie" "\
Get a cookie field string which corresponds to the URL.

\(fn URL)" nil nil)

(autoload 'w3m-cookie "w3m-cookie" "\
Display cookies and enable you to manage them.

\(fn &optional NO-CACHE)" t nil)

(autoload 'w3m-about-cookie "w3m-cookie" "\
Make the html contents to display and to enable you to manage cookies.

\(fn URL &optional NO-DECODE NO-CACHE POST-DATA &rest ARGS)" nil nil)

;;;***

;;;### (autoloads (w3m-dtree w3m-about-dtree) "w3m-dtree" "../package.d/w3m-el/w3m-dtree.el"
;;;;;;  (18197 61165))
;;; Generated autoloads from ../package.d/w3m-el/w3m-dtree.el

(autoload 'w3m-about-dtree "w3m-dtree" "\
Not documented

\(fn URL &optional NODECODE ALLFILES &rest ARGS)" nil nil)

(autoload 'w3m-dtree "w3m-dtree" "\
Display directory tree on local file system.
If called with 'prefix argument', display all directorys and files.

\(fn ALLFILES PATH)" t nil)

;;;***

;;;### (autoloads (w3m-fb-mode) "w3m-fb" "../package.d/w3m-el/w3m-fb.el"
;;;;;;  (17681 2386))
;;; Generated autoloads from ../package.d/w3m-el/w3m-fb.el

(defvar w3m-fb-mode nil "\
Non-nil if W3m-Fb mode is enabled.
See the command `w3m-fb-mode' for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `w3m-fb-mode'.")

(custom-autoload 'w3m-fb-mode "w3m-fb" nil)

(autoload 'w3m-fb-mode "w3m-fb" "\
Toggle W3M Frame Buffer mode.
This allows frame-local lists of buffers (tabs).

\(fn &optional ARG)" t nil)

;;;***

;;;### (autoloads (w3m-filter) "w3m-filter" "../package.d/w3m-el/w3m-filter.el"
;;;;;;  (18560 15090))
;;; Generated autoloads from ../package.d/w3m-el/w3m-filter.el

(autoload 'w3m-filter "w3m-filter" "\
Apply filtering rule of URL against a content in this buffer.

\(fn URL)" nil nil)

;;;***

;;;### (autoloads (w3m-fontify-forms) "w3m-form" "../package.d/w3m-el/w3m-form.el"
;;;;;;  (18777 43743))
;;; Generated autoloads from ../package.d/w3m-el/w3m-form.el

(autoload 'w3m-fontify-forms "w3m-form" "\
Process half-dumped data and fontify forms in this buffer.

\(fn)" nil nil)

;;;***

;;;### (autoloads (w3m-link-numbering-mode) "w3m-lnum" "../package.d/w3m-el/w3m-lnum.el"
;;;;;;  (18197 61165))
;;; Generated autoloads from ../package.d/w3m-el/w3m-lnum.el

(autoload 'w3m-link-numbering-mode "w3m-lnum" "\
Minor mode to enable operations using link numbers.

\(fn &optional ARG)" t nil)

;;;***

;;;### (autoloads (w3m-namazu w3m-about-namazu) "w3m-namazu" "../package.d/w3m-el/w3m-namazu.el"
;;;;;;  (18197 61165))
;;; Generated autoloads from ../package.d/w3m-el/w3m-namazu.el

(autoload 'w3m-about-namazu "w3m-namazu" "\
Not documented

\(fn URL &optional NO-DECODE NO-CACHE &rest ARGS)" nil nil)

(autoload 'w3m-namazu "w3m-namazu" "\
Search indexed files with Namazu.

\(fn INDEX QUERY &optional RELOAD)" t nil)

;;;***

;;;### (autoloads (w3m-perldoc w3m-about-perldoc) "w3m-perldoc" "../package.d/w3m-el/w3m-perldoc.el"
;;;;;;  (18197 61165))
;;; Generated autoloads from ../package.d/w3m-el/w3m-perldoc.el

(autoload 'w3m-about-perldoc "w3m-perldoc" "\
Not documented

\(fn URL &optional NO-DECODE NO-CACHE &rest ARGS)" nil nil)

(autoload 'w3m-perldoc "w3m-perldoc" "\
View Perl documents.

\(fn DOCNAME)" t nil)

;;;***

;;;### (autoloads (w3m-search-uri-replace w3m-search-new-session
;;;;;;  w3m-search) "w3m-search" "../package.d/w3m-el/w3m-search.el"
;;;;;;  (18537 33441))
;;; Generated autoloads from ../package.d/w3m-el/w3m-search.el

(autoload 'w3m-search "w3m-search" "\
Search QUERY using SEARCH-ENGINE.
When called interactively with a prefix argument, you can choose one of
the search engines defined in `w3m-search-engine-alist'.  Otherwise use
`w3m-search-default-engine'.
If Transient Mark mode, use the region as an initial string of query
and deactivate the mark.

\(fn SEARCH-ENGINE QUERY)" t nil)

(autoload 'w3m-search-new-session "w3m-search" "\
Like `w3m-search', but do the search in a new session.

\(fn SEARCH-ENGINE QUERY)" t nil)

(autoload 'w3m-search-uri-replace "w3m-search" "\
Generate query string for ENGINE from URI matched by last search.

\(fn URI ENGINE)" nil nil)

;;;***

;;;### (autoloads (w3m-setup-session-menu w3m-session-select w3m-session-save)
;;;;;;  "w3m-session" "../package.d/w3m-el/w3m-session.el" (18777
;;;;;;  43743))
;;; Generated autoloads from ../package.d/w3m-el/w3m-session.el

(autoload 'w3m-session-save "w3m-session" "\
Save list of displayed session.

\(fn)" t nil)

(autoload 'w3m-session-select "w3m-session" "\
Select session from session list.

\(fn)" t nil)

(autoload 'w3m-setup-session-menu "w3m-session" "\
Setup w3m session items in menubar.

\(fn)" nil nil)

;;;***

;;;### (autoloads (w3m-replace-symbol) "w3m-symbol" "../package.d/w3m-el/w3m-symbol.el"
;;;;;;  (18250 38291))
;;; Generated autoloads from ../package.d/w3m-el/w3m-symbol.el

(autoload 'w3m-replace-symbol "w3m-symbol" "\
Not documented

\(fn)" nil nil)

;;;***

;;;### (autoloads (w3m-about-weather w3m-weather) "w3m-weather" "../package.d/w3m-el/w3m-weather.el"
;;;;;;  (18197 61165))
;;; Generated autoloads from ../package.d/w3m-el/w3m-weather.el

(autoload 'w3m-weather "w3m-weather" "\
Display weather report.

\(fn AREA)" t nil)

(autoload 'w3m-about-weather "w3m-weather" "\
Not documented

\(fn URL NO-DECODE NO-CACHE POST-DATA REFERER HANDLER)" nil nil)

;;;***

;;;### (autoloads nil nil ("../../../../elisp/package.d/bbdb/bits/bbdb-anniv.el"
;;;;;;  "../../../../elisp/package.d/bbdb/bits/bbdb-edit.el" "../../../../elisp/package.d/bbdb/bits/bbdb-filters/bbdb-ccmail.el"
;;;;;;  "../../../../elisp/package.d/bbdb/bits/bbdb-filters/bbdb-eudora.el"
;;;;;;  "../../../../elisp/package.d/bbdb/bits/bbdb-filters/bbdb-export.el"
;;;;;;  "../../../../elisp/package.d/bbdb/bits/bbdb-filters/bbdb-hp200lx.el"
;;;;;;  "../../../../elisp/package.d/bbdb/bits/bbdb-filters/bbdb-passwd.el"
;;;;;;  "../../../../elisp/package.d/bbdb/bits/bbdb-filters/bbdb-ph.el"
;;;;;;  "../../../../elisp/package.d/bbdb/bits/bbdb-ldif.el" "../../../../elisp/package.d/bbdb/bits/bbdb-mail-folders.el"
;;;;;;  "../../../../elisp/package.d/bbdb/bits/bbdb-obsolete.el"
;;;;;;  "../../../../elisp/package.d/bbdb/bits/bbdb-pgp.el" "../../../../elisp/package.d/bbdb/bits/bbdb-signature.el"
;;;;;;  "../../../../elisp/package.d/bbdb/bits/bbdb-sort-mailrc.el"
;;;;;;  "../../../../elisp/package.d/bbdb/bits/bbdb-to-outlook.el"
;;;;;;  "../../../../elisp/package.d/bbdb/lisp/bbdb-com.el" "../../../../elisp/package.d/bbdb/lisp/bbdb-ftp.el"
;;;;;;  "../../../../elisp/package.d/bbdb/lisp/bbdb-gnus.el" "../../../../elisp/package.d/bbdb/lisp/bbdb-gui.el"
;;;;;;  "../../../../elisp/package.d/bbdb/lisp/bbdb-hooks.el" "../../../../elisp/package.d/bbdb/lisp/bbdb-merge.el"
;;;;;;  "../../../../elisp/package.d/bbdb/lisp/bbdb-mhe.el" "../../../../elisp/package.d/bbdb/lisp/bbdb-migrate.el"
;;;;;;  "../../../../elisp/package.d/bbdb/lisp/bbdb-print.el" "../../../../elisp/package.d/bbdb/lisp/bbdb-reportmail.el"
;;;;;;  "../../../../elisp/package.d/bbdb/lisp/bbdb-rmail.el" "../../../../elisp/package.d/bbdb/lisp/bbdb-sc.el"
;;;;;;  "../../../../elisp/package.d/bbdb/lisp/bbdb-snarf.el" "../../../../elisp/package.d/bbdb/lisp/bbdb-srv.el"
;;;;;;  "../../../../elisp/package.d/bbdb/lisp/bbdb-vm.el" "../../../../elisp/package.d/bbdb/lisp/bbdb-w3.el"
;;;;;;  "../../../../elisp/package.d/bbdb/lisp/bbdb-whois.el" "../../../../elisp/package.d/bbdb/lisp/bbdb-xemacs.el"
;;;;;;  "../../../../elisp/package.d/bbdb/lisp/bbdb.el" "../../../../elisp/package.d/bbdb/loadpath.el"
;;;;;;  "../../../../elisp/package.d/bbdb/misc/bbdb-unmigrate-stuff.el"
;;;;;;  "../../../../elisp/package.d/bbdb/testing/bbdb-test.el" "../../../../elisp/package.d/bbdb/testing/run-tests.el"
;;;;;;  "../../../../elisp/package.d/bbdb/texinfo/infohack.el" "../../../../elisp/package.d/bbdb/utils/bbdb-213-310.el"
;;;;;;  "../../../../elisp/package.d/bbdb/utils/bbdb-415-510.el"
;;;;;;  "../../../../elisp/package.d/bbdb/utils/bbdb-to-netscape.el"
;;;;;;  "../../../../elisp/package.d/dwa-c++.el" "../../../../elisp/package.d/dwa-rectangle.el"
;;;;;;  "../../../../elisp/package.d/dwa-util.el" "../../../../elisp/package.d/egg/egg-grep.el"
;;;;;;  "../../../../elisp/package.d/egg/egg.el" "../../../../elisp/package.d/git-emacs/git-blame.el"
;;;;;;  "../../../../elisp/package.d/git-emacs/git-emacs.el" "../../../../elisp/package.d/git-emacs/git-modeline.el"
;;;;;;  "../../../../elisp/package.d/initsplit.el" "../../../../elisp/package.d/magit/50magit.el"
;;;;;;  "../../../../elisp/package.d/magit/magit.el" "../../../../elisp/package.d/mailcrypt/FSF-timer.el"
;;;;;;  "../../../../elisp/package.d/mailcrypt/expect.el" "../../../../elisp/package.d/mailcrypt/mailcrypt.el"
;;;;;;  "../../../../elisp/package.d/mailcrypt/mc-gpg.el" "../../../../elisp/package.d/mailcrypt/mc-pgp.el"
;;;;;;  "../../../../elisp/package.d/mailcrypt/mc-pgp5.el" "../../../../elisp/package.d/mailcrypt/mc-remail.el"
;;;;;;  "../../../../elisp/package.d/mailcrypt/mc-setversion.el"
;;;;;;  "../../../../elisp/package.d/mailcrypt/mc-toplev.el" "../../../../elisp/package.d/mailcrypt/tests/remailer/test-remailer.el"
;;;;;;  "../../../../elisp/package.d/mailcrypt/tests/remailer/test-remailer2.el"
;;;;;;  "../../../../elisp/package.d/mailcrypt/tests/test-gpg.el"
;;;;;;  "../../../../elisp/package.d/maxframe.el" "../../../../elisp/package.d/muse-el/contrib/cgi.el"
;;;;;;  "../../../../elisp/package.d/muse-el/contrib/htmlize-hack.el"
;;;;;;  "../../../../elisp/package.d/muse-el/contrib/httpd.el" "../../../../elisp/package.d/muse-el/examples/ikiwiki/muse-init-project.el"
;;;;;;  "../../../../elisp/package.d/muse-el/examples/ikiwiki/muse-init-simple.el"
;;;;;;  "../../../../elisp/package.d/muse-el/examples/johnw/muse-init.el"
;;;;;;  "../../../../elisp/package.d/muse-el/examples/mwolson/muse-init.el"
;;;;;;  "../../../../elisp/package.d/muse-el/experimental/muse-cite.el"
;;;;;;  "../../../../elisp/package.d/muse-el/experimental/muse-mathml.el"
;;;;;;  "../../../../elisp/package.d/muse-el/experimental/muse-message.el"
;;;;;;  "../../../../elisp/package.d/muse-el/experimental/muse-protocol-iw.el"
;;;;;;  "../../../../elisp/package.d/muse-el/experimental/muse-split.el"
;;;;;;  "../../../../elisp/package.d/muse-el/lisp/muse-backlink.el"
;;;;;;  "../../../../elisp/package.d/muse-el/lisp/muse-blosxom.el"
;;;;;;  "../../../../elisp/package.d/muse-el/lisp/muse-book.el" "../../../../elisp/package.d/muse-el/lisp/muse-colors.el"
;;;;;;  "../../../../elisp/package.d/muse-el/lisp/muse-context.el"
;;;;;;  "../../../../elisp/package.d/muse-el/lisp/muse-docbook.el"
;;;;;;  "../../../../elisp/package.d/muse-el/lisp/muse-groff.el"
;;;;;;  "../../../../elisp/package.d/muse-el/lisp/muse-html.el" "../../../../elisp/package.d/muse-el/lisp/muse-http.el"
;;;;;;  "../../../../elisp/package.d/muse-el/lisp/muse-ikiwiki.el"
;;;;;;  "../../../../elisp/package.d/muse-el/lisp/muse-import-docbook.el"
;;;;;;  "../../../../elisp/package.d/muse-el/lisp/muse-import-latex.el"
;;;;;;  "../../../../elisp/package.d/muse-el/lisp/muse-import-xml.el"
;;;;;;  "../../../../elisp/package.d/muse-el/lisp/muse-journal.el"
;;;;;;  "../../../../elisp/package.d/muse-el/lisp/muse-latex.el"
;;;;;;  "../../../../elisp/package.d/muse-el/lisp/muse-latex2png.el"
;;;;;;  "../../../../elisp/package.d/muse-el/lisp/muse-mode.el" "../../../../elisp/package.d/muse-el/lisp/muse-poem.el"
;;;;;;  "../../../../elisp/package.d/muse-el/lisp/muse-project.el"
;;;;;;  "../../../../elisp/package.d/muse-el/lisp/muse-protocols.el"
;;;;;;  "../../../../elisp/package.d/muse-el/lisp/muse-publish.el"
;;;;;;  "../../../../elisp/package.d/muse-el/lisp/muse-regexps.el"
;;;;;;  "../../../../elisp/package.d/muse-el/lisp/muse-texinfo.el"
;;;;;;  "../../../../elisp/package.d/muse-el/lisp/muse-wiki.el" "../../../../elisp/package.d/muse-el/lisp/muse-xml-common.el"
;;;;;;  "../../../../elisp/package.d/muse-el/lisp/muse-xml.el" "../../../../elisp/package.d/muse-el/lisp/muse.el"
;;;;;;  "../../../../elisp/package.d/muse-el/scripts/muse-build.el"
;;;;;;  "../../../../elisp/package.d/planner-el/contrib/schedule.el"
;;;;;;  "../../../../elisp/package.d/planner-el/contrib/timeclock.el"
;;;;;;  "../../../../elisp/package.d/planner-el/planner-accomplishments.el"
;;;;;;  "../../../../elisp/package.d/planner-el/planner-appt.el"
;;;;;;  "../../../../elisp/package.d/planner-el/planner-authz.el"
;;;;;;  "../../../../elisp/package.d/planner-el/planner-bbdb.el"
;;;;;;  "../../../../elisp/package.d/planner-el/planner-bibtex.el"
;;;;;;  "../../../../elisp/package.d/planner-el/planner-bookmark.el"
;;;;;;  "../../../../elisp/package.d/planner-el/planner-calendar.el"
;;;;;;  "../../../../elisp/package.d/planner-el/planner-cyclic.el"
;;;;;;  "../../../../elisp/package.d/planner-el/planner-deadline.el"
;;;;;;  "../../../../elisp/package.d/planner-el/planner-diary.el"
;;;;;;  "../../../../elisp/package.d/planner-el/planner-erc.el" "../../../../elisp/package.d/planner-el/planner-experimental.el"
;;;;;;  "../../../../elisp/package.d/planner-el/planner-export-diary.el"
;;;;;;  "../../../../elisp/package.d/planner-el/planner-gnats.el"
;;;;;;  "../../../../elisp/package.d/planner-el/planner-gnus.el"
;;;;;;  "../../../../elisp/package.d/planner-el/planner-ical.el"
;;;;;;  "../../../../elisp/package.d/planner-el/planner-id.el" "../../../../elisp/package.d/planner-el/planner-ledger.el"
;;;;;;  "../../../../elisp/package.d/planner-el/planner-lisp.el"
;;;;;;  "../../../../elisp/package.d/planner-el/planner-log-edit.el"
;;;;;;  "../../../../elisp/package.d/planner-el/planner-mhe.el" "../../../../elisp/package.d/planner-el/planner-multi.el"
;;;;;;  "../../../../elisp/package.d/planner-el/planner-notes-index.el"
;;;;;;  "../../../../elisp/package.d/planner-el/planner-psvn.el"
;;;;;;  "../../../../elisp/package.d/planner-el/planner-publish.el"
;;;;;;  "../../../../elisp/package.d/planner-el/planner-rank.el"
;;;;;;  "../../../../elisp/package.d/planner-el/planner-rdf.el" "../../../../elisp/package.d/planner-el/planner-registry.el"
;;;;;;  "../../../../elisp/package.d/planner-el/planner-report.el"
;;;;;;  "../../../../elisp/package.d/planner-el/planner-rmail.el"
;;;;;;  "../../../../elisp/package.d/planner-el/planner-rss.el" "../../../../elisp/package.d/planner-el/planner-schedule.el"
;;;;;;  "../../../../elisp/package.d/planner-el/planner-tasks-overview.el"
;;;;;;  "../../../../elisp/package.d/planner-el/planner-timeclock-summary-proj.el"
;;;;;;  "../../../../elisp/package.d/planner-el/planner-timeclock-summary.el"
;;;;;;  "../../../../elisp/package.d/planner-el/planner-timeclock.el"
;;;;;;  "../../../../elisp/package.d/planner-el/planner-trunk.el"
;;;;;;  "../../../../elisp/package.d/planner-el/planner-unix-mail.el"
;;;;;;  "../../../../elisp/package.d/planner-el/planner-vm.el" "../../../../elisp/package.d/planner-el/planner-w3m.el"
;;;;;;  "../../../../elisp/package.d/planner-el/planner-wl.el" "../../../../elisp/package.d/planner-el/planner-xtla.el"
;;;;;;  "../../../../elisp/package.d/planner-el/planner-zoom.el"
;;;;;;  "../../../../elisp/package.d/planner-el/planner.el" "../../../../elisp/package.d/planner-el/scripts/planner-build.el"
;;;;;;  "../../../../elisp/package.d/planner-el/test/planner-cyclic-test.el"
;;;;;;  "../../../../elisp/package.d/planner-el/test/planner-test.el"
;;;;;;  "../../../../elisp/package.d/psvn.el" "../../../../elisp/package.d/remember-el/read-file-name.el"
;;;;;;  "../../../../elisp/package.d/remember-el/remember-autoloads.el"
;;;;;;  "../../../../elisp/package.d/remember-el/remember-bbdb.el"
;;;;;;  "../../../../elisp/package.d/remember-el/remember-bibl.el"
;;;;;;  "../../../../elisp/package.d/remember-el/remember-blosxom.el"
;;;;;;  "../../../../elisp/package.d/remember-el/remember-emacs-wiki-journal.el"
;;;;;;  "../../../../elisp/package.d/remember-el/remember-experimental.el"
;;;;;;  "../../../../elisp/package.d/remember-el/remember-planner.el"
;;;;;;  "../../../../elisp/package.d/remember-el/remember.el" "../../../../elisp/package.d/remember-el/scripts/remember-build.el"
;;;;;;  "../../../../elisp/package.d/rst.el" "../../../../elisp/package.d/w3m-el/attic/addpath.el"
;;;;;;  "../../../../elisp/package.d/w3m-el/attic/rfc2368.el" "../../../../elisp/package.d/w3m-el/doc/ptexinfmt.el"
;;;;;;  "../../../../elisp/package.d/w3m-el/mew-w3m.el" "../../../../elisp/package.d/w3m-el/mime-w3m.el"
;;;;;;  "../../../../elisp/package.d/w3m-el/octet.el" "../../../../elisp/package.d/w3m-el/shimbun/mew-shimbun.el"
;;;;;;  "../../../../elisp/package.d/w3m-el/shimbun/nnshimbun.el"
;;;;;;  "../../../../elisp/package.d/w3m-el/shimbun/sb-2ch.el" "../../../../elisp/package.d/w3m-el/shimbun/sb-airs.el"
;;;;;;  "../../../../elisp/package.d/w3m-el/shimbun/sb-aljazeera.el"
;;;;;;  "../../../../elisp/package.d/w3m-el/shimbun/sb-arch-bluegate.el"
;;;;;;  "../../../../elisp/package.d/w3m-el/shimbun/sb-asahi-html.el"
;;;;;;  "../../../../elisp/package.d/w3m-el/shimbun/sb-asahi-mytown.el"
;;;;;;  "../../../../elisp/package.d/w3m-el/shimbun/sb-asahi.el"
;;;;;;  "../../../../elisp/package.d/w3m-el/shimbun/sb-atmarkit.el"
;;;;;;  "../../../../elisp/package.d/w3m-el/shimbun/sb-atom-hash.el"
;;;;;;  "../../../../elisp/package.d/w3m-el/shimbun/sb-atom.el" "../../../../elisp/package.d/w3m-el/shimbun/sb-bbc.el"
;;;;;;  "../../../../elisp/package.d/w3m-el/shimbun/sb-bbdb-ml.el"
;;;;;;  "../../../../elisp/package.d/w3m-el/shimbun/sb-cgi-board.el"
;;;;;;  "../../../../elisp/package.d/w3m-el/shimbun/sb-cnet-jp.el"
;;;;;;  "../../../../elisp/package.d/w3m-el/shimbun/sb-cnet.el" "../../../../elisp/package.d/w3m-el/shimbun/sb-cnn-jp.el"
;;;;;;  "../../../../elisp/package.d/w3m-el/shimbun/sb-coldsync.el"
;;;;;;  "../../../../elisp/package.d/w3m-el/shimbun/sb-debian-jp.el"
;;;;;;  "../../../../elisp/package.d/w3m-el/shimbun/sb-debian.el"
;;;;;;  "../../../../elisp/package.d/w3m-el/shimbun/sb-debugmagazin-de.el"
;;;;;;  "../../../../elisp/package.d/w3m-el/shimbun/sb-dennou.el"
;;;;;;  "../../../../elisp/package.d/w3m-el/shimbun/sb-digiko.el"
;;;;;;  "../../../../elisp/package.d/w3m-el/shimbun/sb-elips.el"
;;;;;;  "../../../../elisp/package.d/w3m-el/shimbun/sb-emacs-w3m.el"
;;;;;;  "../../../../elisp/package.d/w3m-el/shimbun/sb-emacswiki.el"
;;;;;;  "../../../../elisp/package.d/w3m-el/shimbun/sb-engadget-ja.el"
;;;;;;  "../../../../elisp/package.d/w3m-el/shimbun/sb-excite.el"
;;;;;;  "../../../../elisp/package.d/w3m-el/shimbun/sb-exconn.el"
;;;;;;  "../../../../elisp/package.d/w3m-el/shimbun/sb-f1fan.el"
;;;;;;  "../../../../elisp/package.d/w3m-el/shimbun/sb-fau.el" "../../../../elisp/package.d/w3m-el/shimbun/sb-ffii.el"
;;;;;;  "../../../../elisp/package.d/w3m-el/shimbun/sb-fml.el" "../../../../elisp/package.d/w3m-el/shimbun/sb-gendai-net.el"
;;;;;;  "../../../../elisp/package.d/w3m-el/shimbun/sb-geocrawler.el"
;;;;;;  "../../../../elisp/package.d/w3m-el/shimbun/sb-glimpse.el"
;;;;;;  "../../../../elisp/package.d/w3m-el/shimbun/sb-gnome.el"
;;;;;;  "../../../../elisp/package.d/w3m-el/shimbun/sb-haiku-os.el"
;;;;;;  "../../../../elisp/package.d/w3m-el/shimbun/sb-hash.el" "../../../../elisp/package.d/w3m-el/shimbun/sb-heise.el"
;;;;;;  "../../../../elisp/package.d/w3m-el/shimbun/sb-hns.el" "../../../../elisp/package.d/w3m-el/shimbun/sb-ibm-dev.el"
;;;;;;  "../../../../elisp/package.d/w3m-el/shimbun/sb-impress.el"
;;;;;;  "../../../../elisp/package.d/w3m-el/shimbun/sb-infoshop.el"
;;;;;;  "../../../../elisp/package.d/w3m-el/shimbun/sb-itmedia.el"
;;;;;;  "../../../../elisp/package.d/w3m-el/shimbun/sb-japantimes.el"
;;;;;;  "../../../../elisp/package.d/w3m-el/shimbun/sb-javaconf.el"
;;;;;;  "../../../../elisp/package.d/w3m-el/shimbun/sb-jpilot.el"
;;;;;;  "../../../../elisp/package.d/w3m-el/shimbun/sb-jpo.el" "../../../../elisp/package.d/w3m-el/shimbun/sb-kantei.el"
;;;;;;  "../../../../elisp/package.d/w3m-el/shimbun/sb-kde.el" "../../../../elisp/package.d/w3m-el/shimbun/sb-laut-de.el"
;;;;;;  "../../../../elisp/package.d/w3m-el/shimbun/sb-linuxce-jp.el"
;;;;;;  "../../../../elisp/package.d/w3m-el/shimbun/sb-lotusex.el"
;;;;;;  "../../../../elisp/package.d/w3m-el/shimbun/sb-lump.el" "../../../../elisp/package.d/w3m-el/shimbun/sb-m17n.el"
;;;;;;  "../../../../elisp/package.d/w3m-el/shimbun/sb-macosx-jp.el"
;;;;;;  "../../../../elisp/package.d/w3m-el/shimbun/sb-mailarc.el"
;;;;;;  "../../../../elisp/package.d/w3m-el/shimbun/sb-mailman.el"
;;;;;;  "../../../../elisp/package.d/w3m-el/shimbun/sb-mainichi.el"
;;;;;;  "../../../../elisp/package.d/w3m-el/shimbun/sb-makanai.el"
;;;;;;  "../../../../elisp/package.d/w3m-el/shimbun/sb-marc-aims.el"
;;;;;;  "../../../../elisp/package.d/w3m-el/shimbun/sb-meadow.el"
;;;;;;  "../../../../elisp/package.d/w3m-el/shimbun/sb-mew.el" "../../../../elisp/package.d/w3m-el/shimbun/sb-mhonarc.el"
;;;;;;  "../../../../elisp/package.d/w3m-el/shimbun/sb-mozilla-jp.el"
;;;;;;  "../../../../elisp/package.d/w3m-el/shimbun/sb-msdn.el" "../../../../elisp/package.d/w3m-el/shimbun/sb-msports-nifty.el"
;;;;;;  "../../../../elisp/package.d/w3m-el/shimbun/sb-multi.el"
;;;;;;  "../../../../elisp/package.d/w3m-el/shimbun/sb-n24-de.el"
;;;;;;  "../../../../elisp/package.d/w3m-el/shimbun/sb-namazu.el"
;;;;;;  "../../../../elisp/package.d/w3m-el/shimbun/sb-netbsd.el"
;;;;;;  "../../../../elisp/package.d/w3m-el/shimbun/sb-nikkansports.el"
;;;;;;  "../../../../elisp/package.d/w3m-el/shimbun/sb-nikkei.el"
;;;;;;  "../../../../elisp/package.d/w3m-el/shimbun/sb-nytimes.el"
;;;;;;  "../../../../elisp/package.d/w3m-el/shimbun/sb-opentechpress-jp.el"
;;;;;;  "../../../../elisp/package.d/w3m-el/shimbun/sb-orca.el" "../../../../elisp/package.d/w3m-el/shimbun/sb-palmfan.el"
;;;;;;  "../../../../elisp/package.d/w3m-el/shimbun/sb-pcweb-column.el"
;;;;;;  "../../../../elisp/package.d/w3m-el/shimbun/sb-perlentaucher-de.el"
;;;;;;  "../../../../elisp/package.d/w3m-el/shimbun/sb-pilot-link.el"
;;;;;;  "../../../../elisp/package.d/w3m-el/shimbun/sb-pilot-mailsync.el"
;;;;;;  "../../../../elisp/package.d/w3m-el/shimbun/sb-plucker.el"
;;;;;;  "../../../../elisp/package.d/w3m-el/shimbun/sb-pocketgames.el"
;;;;;;  "../../../../elisp/package.d/w3m-el/shimbun/sb-rakuten.el"
;;;;;;  "../../../../elisp/package.d/w3m-el/shimbun/sb-redhat.el"
;;;;;;  "../../../../elisp/package.d/w3m-el/shimbun/sb-rediff.el"
;;;;;;  "../../../../elisp/package.d/w3m-el/shimbun/sb-rss-blogs.el"
;;;;;;  "../../../../elisp/package.d/w3m-el/shimbun/sb-rss-hash.el"
;;;;;;  "../../../../elisp/package.d/w3m-el/shimbun/sb-rss.el" "../../../../elisp/package.d/w3m-el/shimbun/sb-ruby.el"
;;;;;;  "../../../../elisp/package.d/w3m-el/shimbun/sb-sankei.el"
;;;;;;  "../../../../elisp/package.d/w3m-el/shimbun/sb-savannah.el"
;;;;;;  "../../../../elisp/package.d/w3m-el/shimbun/sb-scipy.el"
;;;;;;  "../../../../elisp/package.d/w3m-el/shimbun/sb-security-memo.el"
;;;;;;  "../../../../elisp/package.d/w3m-el/shimbun/sb-slashdot-jp.el"
;;;;;;  "../../../../elisp/package.d/w3m-el/shimbun/sb-slashdot.el"
;;;;;;  "../../../../elisp/package.d/w3m-el/shimbun/sb-sml.el" "../../../../elisp/package.d/w3m-el/shimbun/sb-sourceforge-jp.el"
;;;;;;  "../../../../elisp/package.d/w3m-el/shimbun/sb-spiegel.el"
;;;;;;  "../../../../elisp/package.d/w3m-el/shimbun/sb-sponichi.el"
;;;;;;  "../../../../elisp/package.d/w3m-el/shimbun/sb-squeak-dev.el"
;;;;;;  "../../../../elisp/package.d/w3m-el/shimbun/sb-squeak-ja.el"
;;;;;;  "../../../../elisp/package.d/w3m-el/shimbun/sb-sueddeutsche-de.el"
;;;;;;  "../../../../elisp/package.d/w3m-el/shimbun/sb-tcup.el" "../../../../elisp/package.d/w3m-el/shimbun/sb-tdiary-ml.el"
;;;;;;  "../../../../elisp/package.d/w3m-el/shimbun/sb-tdiary.el"
;;;;;;  "../../../../elisp/package.d/w3m-el/shimbun/sb-tech-on.el"
;;;;;;  "../../../../elisp/package.d/w3m-el/shimbun/sb-texfaq.el"
;;;;;;  "../../../../elisp/package.d/w3m-el/shimbun/sb-text.el" "../../../../elisp/package.d/w3m-el/shimbun/sb-the-onion.el"
;;;;;;  "../../../../elisp/package.d/w3m-el/shimbun/sb-the-register.el"
;;;;;;  "../../../../elisp/package.d/w3m-el/shimbun/sb-tigris.el"
;;;;;;  "../../../../elisp/package.d/w3m-el/shimbun/sb-toshiba.el"
;;;;;;  "../../../../elisp/package.d/w3m-el/shimbun/sb-vinelinux.el"
;;;;;;  "../../../../elisp/package.d/w3m-el/shimbun/sb-w3m-dev.el"
;;;;;;  "../../../../elisp/package.d/w3m-el/shimbun/sb-welt-de.el"
;;;;;;  "../../../../elisp/package.d/w3m-el/shimbun/sb-wiki.el" "../../../../elisp/package.d/w3m-el/shimbun/sb-wikimedia.el"
;;;;;;  "../../../../elisp/package.d/w3m-el/shimbun/sb-wincefan.el"
;;;;;;  "../../../../elisp/package.d/w3m-el/shimbun/sb-wired-jp.el"
;;;;;;  "../../../../elisp/package.d/w3m-el/shimbun/sb-x51.el" "../../../../elisp/package.d/w3m-el/shimbun/sb-xemacs.el"
;;;;;;  "../../../../elisp/package.d/w3m-el/shimbun/sb-yahoo-auctions.el"
;;;;;;  "../../../../elisp/package.d/w3m-el/shimbun/sb-yahoo-sports.el"
;;;;;;  "../../../../elisp/package.d/w3m-el/shimbun/sb-yahoo.el"
;;;;;;  "../../../../elisp/package.d/w3m-el/shimbun/sb-yomiuri-html.el"
;;;;;;  "../../../../elisp/package.d/w3m-el/shimbun/sb-yomiuri.el"
;;;;;;  "../../../../elisp/package.d/w3m-el/shimbun/sb-zdnet-jp.el"
;;;;;;  "../../../../elisp/package.d/w3m-el/shimbun/sb-zeit-de.el"
;;;;;;  "../../../../elisp/package.d/w3m-el/shimbun/shimbun.el" "../../../../elisp/package.d/w3m-el/w3m-antenna.el"
;;;;;;  "../../../../elisp/package.d/w3m-el/w3m-bookmark.el" "../../../../elisp/package.d/w3m-el/w3m-bug.el"
;;;;;;  "../../../../elisp/package.d/w3m-el/w3m-ccl.el" "../../../../elisp/package.d/w3m-el/w3m-cookie.el"
;;;;;;  "../../../../elisp/package.d/w3m-el/w3m-dtree.el" "../../../../elisp/package.d/w3m-el/w3m-ems.el"
;;;;;;  "../../../../elisp/package.d/w3m-el/w3m-favicon.el" "../../../../elisp/package.d/w3m-el/w3m-fb.el"
;;;;;;  "../../../../elisp/package.d/w3m-el/w3m-filter.el" "../../../../elisp/package.d/w3m-el/w3m-form.el"
;;;;;;  "../../../../elisp/package.d/w3m-el/w3m-hist.el" "../../../../elisp/package.d/w3m-el/w3m-image.el"
;;;;;;  "../../../../elisp/package.d/w3m-el/w3m-lnum.el" "../../../../elisp/package.d/w3m-el/w3m-load.el"
;;;;;;  "../../../../elisp/package.d/w3m-el/w3m-mail.el" "../../../../elisp/package.d/w3m-el/w3m-namazu.el"
;;;;;;  "../../../../elisp/package.d/w3m-el/w3m-perldoc.el" "../../../../elisp/package.d/w3m-el/w3m-proc.el"
;;;;;;  "../../../../elisp/package.d/w3m-el/w3m-rss.el" "../../../../elisp/package.d/w3m-el/w3m-search.el"
;;;;;;  "../../../../elisp/package.d/w3m-el/w3m-session.el" "../../../../elisp/package.d/w3m-el/w3m-symbol.el"
;;;;;;  "../../../../elisp/package.d/w3m-el/w3m-tabmenu.el" "../../../../elisp/package.d/w3m-el/w3m-ucs.el"
;;;;;;  "../../../../elisp/package.d/w3m-el/w3m-util.el" "../../../../elisp/package.d/w3m-el/w3m-weather.el"
;;;;;;  "../../../../elisp/package.d/w3m-el/w3m-xmas.el" "../../../../elisp/package.d/w3m-el/w3m.el"
;;;;;;  "../../../../elisp/package.d/w3m-el/w3mhack.el" "../package.d/bbdb/bits/bbdb-filters/bbdb-ccmail.el"
;;;;;;  "../package.d/bbdb/bits/bbdb-filters/bbdb-eudora.el" "../package.d/bbdb/bits/bbdb-filters/bbdb-export.el"
;;;;;;  "../package.d/bbdb/bits/bbdb-filters/bbdb-hp200lx.el" "../package.d/bbdb/bits/bbdb-filters/bbdb-passwd.el"
;;;;;;  "../package.d/bbdb/bits/bbdb-filters/bbdb-ph.el" "../package.d/bbdb/bits/bbdb-ldif.el"
;;;;;;  "../package.d/bbdb/bits/bbdb-mail-folders.el" "../package.d/bbdb/bits/bbdb-signature.el"
;;;;;;  "../package.d/bbdb/bits/bbdb-sort-mailrc.el" "../package.d/bbdb/bits/bbdb-to-outlook.el"
;;;;;;  "../package.d/bbdb/loadpath.el" "../package.d/bbdb/misc/bbdb-unmigrate-stuff.el"
;;;;;;  "../package.d/bbdb/testing/run-tests.el" "../package.d/bbdb/texinfo/infohack.el"
;;;;;;  "../package.d/bbdb/utils/bbdb-213-310.el" "../package.d/bbdb/utils/bbdb-415-510.el"
;;;;;;  "../package.d/bbdb/utils/bbdb-to-netscape.el" "../package.d/dwa-c++.el"
;;;;;;  "../package.d/dwa-rectangle.el" "../package.d/dwa-util.el"
;;;;;;  "../package.d/git-emacs/git-blame.el" "../package.d/git-emacs/git-emacs.el"
;;;;;;  "../package.d/git-emacs/git-modeline.el" "../package.d/initsplit.el"
;;;;;;  "../package.d/magit/50magit.el" "../package.d/magit/magit.el"
;;;;;;  "../package.d/mailcrypt/mailcrypt.el" "../package.d/mailcrypt/mc-gpg.el"
;;;;;;  "../package.d/mailcrypt/mc-pgp.el" "../package.d/mailcrypt/mc-pgp5.el"
;;;;;;  "../package.d/mailcrypt/mc-remail.el" "../package.d/mailcrypt/mc-setversion.el"
;;;;;;  "../package.d/mailcrypt/mc-toplev.el" "../package.d/mailcrypt/tests/remailer/test-remailer.el"
;;;;;;  "../package.d/mailcrypt/tests/remailer/test-remailer2.el"
;;;;;;  "../package.d/mailcrypt/tests/test-gpg.el" "../package.d/maxframe.el"
;;;;;;  "../package.d/muse-el/contrib/cgi.el" "../package.d/muse-el/contrib/htmlize-hack.el"
;;;;;;  "../package.d/muse-el/contrib/httpd.el" "../package.d/muse-el/examples/ikiwiki/muse-init-project.el"
;;;;;;  "../package.d/muse-el/examples/ikiwiki/muse-init-simple.el"
;;;;;;  "../package.d/muse-el/examples/johnw/muse-init.el" "../package.d/muse-el/examples/mwolson/muse-init.el"
;;;;;;  "../package.d/muse-el/experimental/muse-cite.el" "../package.d/muse-el/experimental/muse-mathml.el"
;;;;;;  "../package.d/muse-el/experimental/muse-protocol-iw.el" "../package.d/muse-el/experimental/muse-split.el"
;;;;;;  "../package.d/muse-el/lisp/muse-backlink.el" "../package.d/muse-el/lisp/muse-book.el"
;;;;;;  "../package.d/muse-el/lisp/muse-context.el" "../package.d/muse-el/lisp/muse-docbook.el"
;;;;;;  "../package.d/muse-el/lisp/muse-groff.el" "../package.d/muse-el/lisp/muse-html.el"
;;;;;;  "../package.d/muse-el/lisp/muse-http.el" "../package.d/muse-el/lisp/muse-ikiwiki.el"
;;;;;;  "../package.d/muse-el/lisp/muse-import-xml.el" "../package.d/muse-el/lisp/muse-journal.el"
;;;;;;  "../package.d/muse-el/lisp/muse-latex.el" "../package.d/muse-el/lisp/muse-latex2png.el"
;;;;;;  "../package.d/muse-el/lisp/muse-poem.el" "../package.d/muse-el/lisp/muse-regexps.el"
;;;;;;  "../package.d/muse-el/lisp/muse-texinfo.el" "../package.d/muse-el/lisp/muse-wiki.el"
;;;;;;  "../package.d/muse-el/lisp/muse-xml-common.el" "../package.d/muse-el/lisp/muse-xml.el"
;;;;;;  "../package.d/muse-el/scripts/muse-build.el" "../package.d/planner-el/planner-authz.el"
;;;;;;  "../package.d/planner-el/planner-calendar.el" "../package.d/planner-el/planner-experimental.el"
;;;;;;  "../package.d/planner-el/planner-ical.el" "../package.d/planner-el/planner-publish.el"
;;;;;;  "../package.d/planner-el/planner-zoom.el" "../package.d/planner-el/scripts/planner-build.el"
;;;;;;  "../package.d/planner-el/test/planner-cyclic-test.el" "../package.d/planner-el/test/planner-test.el"
;;;;;;  "../package.d/remember-el/read-file-name.el" "../package.d/remember-el/remember-autoloads.el"
;;;;;;  "../package.d/remember-el/remember-experimental.el" "../package.d/remember-el/scripts/remember-build.el"
;;;;;;  "../package.d/w3m-el/attic/addpath.el" "../package.d/w3m-el/attic/rfc2368.el"
;;;;;;  "../package.d/w3m-el/doc/ptexinfmt.el" "../package.d/w3m-el/mew-w3m.el"
;;;;;;  "../package.d/w3m-el/shimbun/sb-2ch.el" "../package.d/w3m-el/shimbun/sb-airs.el"
;;;;;;  "../package.d/w3m-el/shimbun/sb-aljazeera.el" "../package.d/w3m-el/shimbun/sb-arch-bluegate.el"
;;;;;;  "../package.d/w3m-el/shimbun/sb-asahi-html.el" "../package.d/w3m-el/shimbun/sb-asahi-mytown.el"
;;;;;;  "../package.d/w3m-el/shimbun/sb-asahi.el" "../package.d/w3m-el/shimbun/sb-atmarkit.el"
;;;;;;  "../package.d/w3m-el/shimbun/sb-atom-hash.el" "../package.d/w3m-el/shimbun/sb-atom.el"
;;;;;;  "../package.d/w3m-el/shimbun/sb-bbc.el" "../package.d/w3m-el/shimbun/sb-bbdb-ml.el"
;;;;;;  "../package.d/w3m-el/shimbun/sb-cgi-board.el" "../package.d/w3m-el/shimbun/sb-cnet-jp.el"
;;;;;;  "../package.d/w3m-el/shimbun/sb-cnet.el" "../package.d/w3m-el/shimbun/sb-cnn-jp.el"
;;;;;;  "../package.d/w3m-el/shimbun/sb-coldsync.el" "../package.d/w3m-el/shimbun/sb-debian-jp.el"
;;;;;;  "../package.d/w3m-el/shimbun/sb-debian.el" "../package.d/w3m-el/shimbun/sb-debugmagazin-de.el"
;;;;;;  "../package.d/w3m-el/shimbun/sb-dennou.el" "../package.d/w3m-el/shimbun/sb-digiko.el"
;;;;;;  "../package.d/w3m-el/shimbun/sb-elips.el" "../package.d/w3m-el/shimbun/sb-emacs-w3m.el"
;;;;;;  "../package.d/w3m-el/shimbun/sb-emacswiki.el" "../package.d/w3m-el/shimbun/sb-engadget-ja.el"
;;;;;;  "../package.d/w3m-el/shimbun/sb-excite.el" "../package.d/w3m-el/shimbun/sb-exconn.el"
;;;;;;  "../package.d/w3m-el/shimbun/sb-f1fan.el" "../package.d/w3m-el/shimbun/sb-fau.el"
;;;;;;  "../package.d/w3m-el/shimbun/sb-ffii.el" "../package.d/w3m-el/shimbun/sb-fml.el"
;;;;;;  "../package.d/w3m-el/shimbun/sb-gendai-net.el" "../package.d/w3m-el/shimbun/sb-geocrawler.el"
;;;;;;  "../package.d/w3m-el/shimbun/sb-glimpse.el" "../package.d/w3m-el/shimbun/sb-gnome.el"
;;;;;;  "../package.d/w3m-el/shimbun/sb-haiku-os.el" "../package.d/w3m-el/shimbun/sb-hash.el"
;;;;;;  "../package.d/w3m-el/shimbun/sb-heise.el" "../package.d/w3m-el/shimbun/sb-hns.el"
;;;;;;  "../package.d/w3m-el/shimbun/sb-ibm-dev.el" "../package.d/w3m-el/shimbun/sb-impress.el"
;;;;;;  "../package.d/w3m-el/shimbun/sb-infoshop.el" "../package.d/w3m-el/shimbun/sb-itmedia.el"
;;;;;;  "../package.d/w3m-el/shimbun/sb-japantimes.el" "../package.d/w3m-el/shimbun/sb-javaconf.el"
;;;;;;  "../package.d/w3m-el/shimbun/sb-jpilot.el" "../package.d/w3m-el/shimbun/sb-jpo.el"
;;;;;;  "../package.d/w3m-el/shimbun/sb-kantei.el" "../package.d/w3m-el/shimbun/sb-kde.el"
;;;;;;  "../package.d/w3m-el/shimbun/sb-laut-de.el" "../package.d/w3m-el/shimbun/sb-linuxce-jp.el"
;;;;;;  "../package.d/w3m-el/shimbun/sb-lotusex.el" "../package.d/w3m-el/shimbun/sb-lump.el"
;;;;;;  "../package.d/w3m-el/shimbun/sb-m17n.el" "../package.d/w3m-el/shimbun/sb-macosx-jp.el"
;;;;;;  "../package.d/w3m-el/shimbun/sb-mailarc.el" "../package.d/w3m-el/shimbun/sb-mailman.el"
;;;;;;  "../package.d/w3m-el/shimbun/sb-mainichi.el" "../package.d/w3m-el/shimbun/sb-makanai.el"
;;;;;;  "../package.d/w3m-el/shimbun/sb-marc-aims.el" "../package.d/w3m-el/shimbun/sb-meadow.el"
;;;;;;  "../package.d/w3m-el/shimbun/sb-mew.el" "../package.d/w3m-el/shimbun/sb-mhonarc.el"
;;;;;;  "../package.d/w3m-el/shimbun/sb-mozilla-jp.el" "../package.d/w3m-el/shimbun/sb-msdn.el"
;;;;;;  "../package.d/w3m-el/shimbun/sb-msports-nifty.el" "../package.d/w3m-el/shimbun/sb-multi.el"
;;;;;;  "../package.d/w3m-el/shimbun/sb-n24-de.el" "../package.d/w3m-el/shimbun/sb-namazu.el"
;;;;;;  "../package.d/w3m-el/shimbun/sb-netbsd.el" "../package.d/w3m-el/shimbun/sb-nikkansports.el"
;;;;;;  "../package.d/w3m-el/shimbun/sb-nikkei.el" "../package.d/w3m-el/shimbun/sb-nytimes.el"
;;;;;;  "../package.d/w3m-el/shimbun/sb-opentechpress-jp.el" "../package.d/w3m-el/shimbun/sb-orca.el"
;;;;;;  "../package.d/w3m-el/shimbun/sb-palmfan.el" "../package.d/w3m-el/shimbun/sb-pcweb-column.el"
;;;;;;  "../package.d/w3m-el/shimbun/sb-perlentaucher-de.el" "../package.d/w3m-el/shimbun/sb-pilot-link.el"
;;;;;;  "../package.d/w3m-el/shimbun/sb-pilot-mailsync.el" "../package.d/w3m-el/shimbun/sb-plucker.el"
;;;;;;  "../package.d/w3m-el/shimbun/sb-pocketgames.el" "../package.d/w3m-el/shimbun/sb-rakuten.el"
;;;;;;  "../package.d/w3m-el/shimbun/sb-redhat.el" "../package.d/w3m-el/shimbun/sb-rediff.el"
;;;;;;  "../package.d/w3m-el/shimbun/sb-rss-blogs.el" "../package.d/w3m-el/shimbun/sb-rss-hash.el"
;;;;;;  "../package.d/w3m-el/shimbun/sb-rss.el" "../package.d/w3m-el/shimbun/sb-ruby.el"
;;;;;;  "../package.d/w3m-el/shimbun/sb-sankei.el" "../package.d/w3m-el/shimbun/sb-savannah.el"
;;;;;;  "../package.d/w3m-el/shimbun/sb-scipy.el" "../package.d/w3m-el/shimbun/sb-security-memo.el"
;;;;;;  "../package.d/w3m-el/shimbun/sb-slashdot-jp.el" "../package.d/w3m-el/shimbun/sb-slashdot.el"
;;;;;;  "../package.d/w3m-el/shimbun/sb-sml.el" "../package.d/w3m-el/shimbun/sb-sourceforge-jp.el"
;;;;;;  "../package.d/w3m-el/shimbun/sb-spiegel.el" "../package.d/w3m-el/shimbun/sb-sponichi.el"
;;;;;;  "../package.d/w3m-el/shimbun/sb-squeak-dev.el" "../package.d/w3m-el/shimbun/sb-squeak-ja.el"
;;;;;;  "../package.d/w3m-el/shimbun/sb-sueddeutsche-de.el" "../package.d/w3m-el/shimbun/sb-tcup.el"
;;;;;;  "../package.d/w3m-el/shimbun/sb-tdiary-ml.el" "../package.d/w3m-el/shimbun/sb-tdiary.el"
;;;;;;  "../package.d/w3m-el/shimbun/sb-tech-on.el" "../package.d/w3m-el/shimbun/sb-texfaq.el"
;;;;;;  "../package.d/w3m-el/shimbun/sb-text.el" "../package.d/w3m-el/shimbun/sb-the-onion.el"
;;;;;;  "../package.d/w3m-el/shimbun/sb-the-register.el" "../package.d/w3m-el/shimbun/sb-tigris.el"
;;;;;;  "../package.d/w3m-el/shimbun/sb-toshiba.el" "../package.d/w3m-el/shimbun/sb-vinelinux.el"
;;;;;;  "../package.d/w3m-el/shimbun/sb-w3m-dev.el" "../package.d/w3m-el/shimbun/sb-welt-de.el"
;;;;;;  "../package.d/w3m-el/shimbun/sb-wiki.el" "../package.d/w3m-el/shimbun/sb-wikimedia.el"
;;;;;;  "../package.d/w3m-el/shimbun/sb-wincefan.el" "../package.d/w3m-el/shimbun/sb-wired-jp.el"
;;;;;;  "../package.d/w3m-el/shimbun/sb-x51.el" "../package.d/w3m-el/shimbun/sb-xemacs.el"
;;;;;;  "../package.d/w3m-el/shimbun/sb-yahoo-auctions.el" "../package.d/w3m-el/shimbun/sb-yahoo-sports.el"
;;;;;;  "../package.d/w3m-el/shimbun/sb-yahoo.el" "../package.d/w3m-el/shimbun/sb-yomiuri-html.el"
;;;;;;  "../package.d/w3m-el/shimbun/sb-yomiuri.el" "../package.d/w3m-el/shimbun/sb-zdnet-jp.el"
;;;;;;  "../package.d/w3m-el/shimbun/sb-zeit-de.el" "../package.d/w3m-el/shimbun/shimbun.el"
;;;;;;  "../package.d/w3m-el/w3m-bug.el" "../package.d/w3m-el/w3m-ccl.el"
;;;;;;  "../package.d/w3m-el/w3m-ems.el" "../package.d/w3m-el/w3m-favicon.el"
;;;;;;  "../package.d/w3m-el/w3m-hist.el" "../package.d/w3m-el/w3m-image.el"
;;;;;;  "../package.d/w3m-el/w3m-load.el" "../package.d/w3m-el/w3m-mail.el"
;;;;;;  "../package.d/w3m-el/w3m-proc.el" "../package.d/w3m-el/w3m-rss.el"
;;;;;;  "../package.d/w3m-el/w3m-tabmenu.el" "../package.d/w3m-el/w3m-ucs.el"
;;;;;;  "../package.d/w3m-el/w3m-util.el" "../package.d/w3m-el/w3m-xmas.el"
;;;;;;  "../package.d/w3m-el/w3mhack.el") (18807 19615 130892))

;;;***

(provide 'my-loaddefs)
;; Local Variables:
;; version-control: never
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; my-loaddefs.el ends here
