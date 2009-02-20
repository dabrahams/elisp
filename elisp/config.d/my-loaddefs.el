;;; my-loaddefs.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads (run-at-time) "FSF-timer" "../package.d/mailcrypt/FSF-timer.el"
;;;;;;  (18846 37975))
;;; Generated autoloads from ../package.d/mailcrypt/FSF-timer.el

(autoload (quote run-at-time) "FSF-timer" "\
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

;;;### (autoloads (any-ini-mode) "any-ini-mode" "../package.d/any-ini-mode.el"
;;;;;;  (18847 2295))
;;; Generated autoloads from ../package.d/any-ini-mode.el

(autoload (quote any-ini-mode) "any-ini-mode" "\
*Major mode for editing config files with syntax highlighting based on a 'source of truth'.

You may set up a default style for all <any>.ini mode buffers, or, more usefully,
you may set up several styles that will be automatically applied based on the name
of the file being visited.

See `any-ini-set-my-style' and `any-ini-styles-alist' for more details.

Turning on <any>.ini mode runs the normal hook `any-ini-mode-hook'.

\(fn)" t nil)

;;;***

;;;### (autoloads (bbdb-insinuate-message bbdb-initialize bbdb-multiple-buffers
;;;;;;  bbdb-submit-bug-report) "bbdb" "../package.d/bbdb/lisp/bbdb.el"
;;;;;;  (18846 37975))
;;; Generated autoloads from ../package.d/bbdb/lisp/bbdb.el

(autoload (quote bbdb-submit-bug-report) "bbdb" "\
Submit a bug report, with pertinent information to the BBDB info list.

\(fn)" t nil)

(defvar bbdb-multiple-buffers nil "\
When non-nil we create a new buffer of every buffer causing pop-ups.
You can also set this to a function returning a buffer name.")

(custom-autoload (quote bbdb-multiple-buffers) "bbdb" t)

(autoload (quote bbdb-initialize) "bbdb" "\
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

(autoload (quote bbdb-insinuate-message) "bbdb" "\
Call this function to hook BBDB into `message-mode'.

\(fn)" nil nil)

;;;***

;;;### (autoloads (bbdb-include-anniversaries bbdb-anniversaries
;;;;;;  bbdb-utilities-anniversaries) "bbdb-anniv" "../package.d/bbdb/bits/bbdb-anniv.el"
;;;;;;  (18846 37975))
;;; Generated autoloads from ../package.d/bbdb/bits/bbdb-anniv.el

(let ((loads (get (quote bbdb-utilities-anniversaries) (quote custom-loads)))) (if (member (quote "bbdb-anniv") loads) nil (put (quote bbdb-utilities-anniversaries) (quote custom-loads) (cons (quote "bbdb-anniv") loads))))

(defvar bbdb-anniversaries nil "\
Should BBDB anniversaries be included when the diary is displayed (fancy)?
You must modify via \\[customize] for this variable to have an effect.")

(custom-autoload (quote bbdb-anniversaries) "bbdb-anniv" nil)

(autoload (quote bbdb-include-anniversaries) "bbdb-anniv" "\
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
;;;;;;  "bbdb-com" "../package.d/bbdb/lisp/bbdb-com.el" (18846 37975))
;;; Generated autoloads from ../package.d/bbdb/lisp/bbdb-com.el

(autoload (quote bbdb-search-invert-set) "bbdb-com" "\
Typing \\<bbdb-mode-map>\\[bbdb-search-invert-set] inverts the meaning of the next search command.
Sets `bbdb-search-invert' to t.
You will have to call this function again, if you want to
do repeated inverted searches.

\(fn)" t nil)

(autoload (quote bbdb) "bbdb-com" "\
Display all entries in the BBDB matching the regexp STRING
in either the name(s), company, network address, or notes.

\(fn STRING ELIDEP)" t nil)

(autoload (quote bbdb-name) "bbdb-com" "\
Display all entries in the BBDB matching the regexp STRING in the name
\(or ``alternate'' names).

\(fn STRING ELIDEP)" t nil)

(autoload (quote bbdb-company) "bbdb-com" "\
Display all entries in BBDB matching STRING in the company field.

\(fn STRING ELIDEP)" t nil)

(autoload (quote bbdb-net) "bbdb-com" "\
Display all entries in BBDB matching regexp STRING in the network address.

\(fn STRING ELIDEP)" t nil)

(autoload (quote bbdb-notes) "bbdb-com" "\
Display all entries in BBDB matching STRING in the named notes field.

\(fn WHICH STRING ELIDEP)" t nil)

(autoload (quote bbdb-changed) "bbdb-com" "\
Display all entries in the bbdb database which have been changed since
the database was last saved.

\(fn ELIDEP)" t nil)

(autoload (quote bbdb-redisplay-records) "bbdb-com" "\
Regrinds the contents of the *BBDB* buffer, without scrolling.
If possible, you should call `bbdb-redisplay-one-record' instead.

\(fn)" nil nil)

(autoload (quote bbdb-create) "bbdb-com" "\
Add a new entry to the bbdb database ; prompts for all relevant info
using the echo area, inserts the new record in the db, sorted alphabetically,
and offers to save the db file.  DO NOT call this from a program.  Call
bbdb-create-internal instead.

\(fn RECORD)" t nil)

(autoload (quote bbdb-apply-next-command-to-all-records) "bbdb-com" "\
Typing \\<bbdb-mode-map>\\[bbdb-apply-next-command-to-all-records] in the *BBDB* buffer makes the next command operate on all
of the records currently displayed.  (Note that this only works for
certain commands.)

\(fn)" t nil)

(autoload (quote bbdb-append-records-p) "bbdb-com" "\
Not documented

\(fn)" nil nil)

(autoload (quote bbdb-append-records) "bbdb-com" "\
Typing \\<bbdb-mode-map>\\[bbdb-append-records] in the *BBDB* buffer makes the next search/display command to append
new records to those in the *BBDB* buffer.

With an prefix arg (C-u) toggle between always append and no append.
With an prefix arg that is a positive number append will be enabled for that
many times.
With any other argument append will be enabled once.

\(fn ARG)" t nil)

(autoload (quote bbdb-insert-new-field) "bbdb-com" "\
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

(autoload (quote bbdb-edit-current-field) "bbdb-com" "\
Edit the contents of the Insidious Big Brother Database field displayed on
the current line (this is only meaningful in the \"*BBDB*\" buffer.)   If the
cursor is in the middle of a multi-line field, such as an address or comments
section, then the entire field is edited, not just the current line.

\(fn)" t nil)

(autoload (quote bbdb-record-edit-notes) "bbdb-com" "\
Not documented

\(fn BBDB-RECORD &optional REGRIND)" t nil)

(autoload (quote bbdb-record-edit-property) "bbdb-com" "\
Not documented

\(fn BBDB-RECORD &optional PROP REGRIND)" t nil)

(autoload (quote bbdb-transpose-fields) "bbdb-com" "\
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

(autoload (quote bbdb-delete-current-field-or-record) "bbdb-com" "\
Delete the line which the cursor is on; actually, delete the field which
that line represents from the database.  If the cursor is on the first line
of a database entry (the name/company line) then the entire entry will be
deleted.

\(fn &optional RECORDS NOPROMPT)" t nil)

(autoload (quote bbdb-delete-current-record) "bbdb-com" "\
Delete the entire bbdb database entry which the cursor is within.
Pressing \\<bbdb-mode-map>\\[bbdb-apply-next-command-to-all-records] will
delete all records listed in the BBDB buffer.

\(fn RECS &optional NOPROMPT)" t nil)

(autoload (quote bbdb-toggle-all-records-display-layout) "bbdb-com" "\
Show all the fields of all visible records.
Like `bbdb-toggle-records-display-layout' but for all visible records.

\(fn ARG &optional RECORDS)" t nil)

(autoload (quote bbdb-toggle-records-display-layout) "bbdb-com" "\
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

(autoload (quote bbdb-display-all-records-completely) "bbdb-com" "\
Show all the fields of all currently displayed records.
The display layout `full-multi-line' is used for this.

\(fn ARG &optional RECORDS)" t nil)

(autoload (quote bbdb-display-record-completely) "bbdb-com" "\
Show all the fields of the current record.
The display layout `full-multi-line' is used for this.

\(fn ARG)" t nil)

(autoload (quote bbdb-display-record-with-layout) "bbdb-com" "\
Show all the fields of the current record using LAYOUT.

\(fn LAYOUT &optional RECORDS)" t nil)

(autoload (quote bbdb-omit-record) "bbdb-com" "\
Remove the current record from the display without deleting it from the
database.  With a prefix argument, omit the next N records.  If negative,
omit backwards.

\(fn N)" t nil)

(autoload (quote bbdb-refile-record) "bbdb-com" "\
Merge the current record into some other record; that is, delete the
record under point after copying all of the data within it into some other
record.  this is useful if you realize that somehow a redundant record has
gotten into the database, and you want to merge it with another.

If both records have names and/or companies, you are asked which to use.
Phone numbers, addresses, and network addresses are simply concatenated.
The first record is the record under the point; the second is prompted for.
Completion behaviour is as dictated by the variable `bbdb-completion-type'.

\(fn OLD-RECORD NEW-RECORD)" t nil)

(autoload (quote bbdb-sort-notes) "bbdb-com" "\
Sort the notes in the record according to `bbdb-notes-sort-order'.
Can be used in `bbdb-change-hook'.

\(fn REC)" nil nil)

(autoload (quote bbdb-sort-phones) "bbdb-com" "\
Sort the phones in the record according to the location.
Can be used in `bbdb-change-hook'.

\(fn REC)" nil nil)

(autoload (quote bbdb-sort-addresses) "bbdb-com" "\
Sort the addresses in the record according to the location.
Can be used in `bbdb-change-hook'.

\(fn REC)" nil nil)

(autoload (quote bbdb-dwim-net-address) "bbdb-com" "\
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

(autoload (quote bbdb-send-mail) "bbdb-com" "\
Compose a mail message to the person indicated by the current bbdb record.
The first (most-recently-added) address is used if there are more than one.
\\<bbdb-mode-map>
If \"\\[bbdb-apply-next-command-to-all-records]\\[bbdb-send-mail]\" is used instead of simply \"\\[bbdb-send-mail]\", then mail will be sent to all of the
folks listed in the *BBDB* buffer instead of just the person at point.

\(fn BBDB-RECORD &optional SUBJECT)" t nil)

(autoload (quote bbdb-show-all-recipients) "bbdb-com" "\
*Display BBDB records for all recipients of the message in this buffer.

\(fn)" t nil)

(autoload (quote bbdb-completion-check-record) "bbdb-com" "\
Not documented

\(fn SYM REC)" nil nil)

(autoload (quote bbdb-completion-predicate) "bbdb-com" "\
For use as the third argument to `completing-read'.
Obey the semantics of `bbdb-completion-type'.

\(fn SYMBOL)" nil nil)

(autoload (quote bbdb-read-addresses-with-completion) "bbdb-com" "\
Like `read-string', but allows `bbdb-complete-name' style completion.

\(fn PROMPT &optional DEFAULT)" nil nil)

(autoload (quote bbdb-complete-name) "bbdb-com" "\
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

(autoload (quote bbdb-yank) "bbdb-com" "\
Insert the current contents of the *BBDB* buffer at point.

\(fn)" t nil)

(autoload (quote bbdb-define-all-aliases) "bbdb-com" "\
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

(autoload (quote bbdb-add-or-remove-mail-alias) "bbdb-com" "\
Add NEWALIAS in all RECORDS or remove it if DELETE it t.
When called with prefix argument it will remove the alias.
We honor `bbdb-apply-next-command-to-all-records'!
The new alias will only be added if it isn't there yet.

\(fn &optional RECORDS NEWALIAS DELETE)" t nil)

(autoload (quote bbdb-dial) "bbdb-com" "\
Dial the number at point.
If the point is at the beginning of a record, dial the first
phone number.  Does not dial the extension.  Does not apply the
transformations from bbdb-dial-local-prefix-alist if a prefix arg
is given.

\(fn PHONE FORCE-AREA-CODE)" t nil)

(autoload (quote bbdb-finger) "bbdb-com" "\
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

(autoload (quote bbdb-timestamp-older) "bbdb-com" "\
*Display records with timestamp older than DATE.
DATE must be in yyyy-mm-dd format.

\(fn DATE)" t nil)

(autoload (quote bbdb-timestamp-newer) "bbdb-com" "\
*Display records with timestamp newer than DATE.
DATE must be in yyyy-mm-dd format.

\(fn DATE)" t nil)

(autoload (quote bbdb-creation-older) "bbdb-com" "\
*Display records with creation-date older than DATE.
DATE must be in yyyy-mm-dd format.

\(fn DATE)" t nil)

(autoload (quote bbdb-creation-newer) "bbdb-com" "\
*Display records with creation-date newer than DATE.
DATE must be in yyyy-mm-dd format.

\(fn DATE)" t nil)

(autoload (quote bbdb-creation-no-change) "bbdb-com" "\
*Display records that have the same timestamp and creation-date.

\(fn)" t nil)

(autoload (quote bbdb-info) "bbdb-com" "\
Not documented

\(fn)" t nil)

(autoload (quote bbdb-help) "bbdb-com" "\
Not documented

\(fn)" t nil)

(defvar bbdb-update-records-mode (quote annotating) "\
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

(custom-autoload (quote bbdb-update-records-mode) "bbdb-com" t)

(autoload (quote bbdb-update-records) "bbdb-com" "\
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

(defvar bbdb-get-addresses-headers (quote ((authors "From" "Resent-From" "Reply-To") (recipients "Resent-To" "Resent-CC" "To" "CC" "BCC"))) "\
*List of headers to search for senders and recipients email addresses.
The headers are grouped into two classes, the authors and the senders headers.")

(custom-autoload (quote bbdb-get-addresses-headers) "bbdb-com" t)

(defvar bbdb-get-only-first-address-p nil "\
*If t `bbdb-update-records' will return only the first one.
Changing this variable will show its effect only after clearing the
`bbdb-message-cache' of a folder or closing and visiting it again.")

(custom-autoload (quote bbdb-get-only-first-address-p) "bbdb-com" t)

;;;***

;;;### (autoloads (bbdb-field-edit-del bbdb-field-edit-add) "bbdb-edit"
;;;;;;  "../package.d/bbdb/bits/bbdb-edit.el" (18846 37975))
;;; Generated autoloads from ../package.d/bbdb/bits/bbdb-edit.el

(autoload (quote bbdb-field-edit-add) "bbdb-edit" "\
Add VALUE to FIELD of bbdb-record(s).

\(fn BBDB-RECORD FIELD VALUE)" t nil)

(autoload (quote bbdb-field-edit-del) "bbdb-edit" "\
Delete VALUE to FIELD of bbdb-record(s).
If prefix arg exists, delete all existing field values matching VALUE(regexp).

\(fn BBDB-RECORD FIELD VALUE)" t nil)

;;;***

;;;### (autoloads (bbdb-create-ftp-site bbdb-ftp) "bbdb-ftp" "../package.d/bbdb/lisp/bbdb-ftp.el"
;;;;;;  (18846 37975))
;;; Generated autoloads from ../package.d/bbdb/lisp/bbdb-ftp.el

(autoload (quote bbdb-ftp) "bbdb-ftp" "\
Use ange-ftp to open an ftp-connection to a BBDB record's name.
If this command is executed from the *BBDB* buffer, ftp the site of
the record at point; otherwise, it prompts for an ftp-site.

\(fn BBDB-RECORD &optional WHICH)" t nil)

(autoload (quote bbdb-create-ftp-site) "bbdb-ftp" "\
Add a new ftp-site entry to the bbdb database.
Prompts for all relevant info using the echo area,
inserts the new record in the db, sorted alphabetically.

\(fn RECORD)" t nil)

;;;***

;;;### (autoloads (bbdb-insinuate-gnus bbdb/gnus-summary-show-all-recipients
;;;;;;  bbdb/gnus-score bbdb/gnus-snarf-signature bbdb/gnus-show-all-recipients
;;;;;;  bbdb/gnus-show-records bbdb/gnus-annotate-sender bbdb/gnus-update-records
;;;;;;  bbdb/gnus-update-record) "bbdb-gnus" "../package.d/bbdb/lisp/bbdb-gnus.el"
;;;;;;  (18846 37975))
;;; Generated autoloads from ../package.d/bbdb/lisp/bbdb-gnus.el

(autoload (quote bbdb/gnus-update-record) "bbdb-gnus" "\
Return the record corresponding to the current Gnus message, creating
or modifying it as necessary.  A record will be created if
bbdb/news-auto-create-p is non-nil, or if OFFER-TO-CREATE is true and
the user confirms the creation.

\(fn &optional OFFER-TO-CREATE)" nil nil)

(autoload (quote bbdb/gnus-update-records) "bbdb-gnus" "\
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

(autoload (quote bbdb/gnus-annotate-sender) "bbdb-gnus" "\
Add a line to the end of the Notes field of the BBDB record
corresponding to the sender of this message.  If REPLACE is non-nil,
replace the existing notes entry (if any).

\(fn STRING &optional REPLACE)" t nil)

(autoload (quote bbdb/gnus-show-records) "bbdb-gnus" "\
Display the contents of the BBDB for all addresses of this message.
This buffer will be in `bbdb-mode', with associated keybindings.

\(fn &optional ADDRESS-CLASS)" t nil)

(autoload (quote bbdb/gnus-show-all-recipients) "bbdb-gnus" "\
Show all recipients of this message. Counterpart to `bbdb/vm-show-sender'.

\(fn)" t nil)

(autoload (quote bbdb/gnus-snarf-signature) "bbdb-gnus" "\
Snarf signature from the corresponding *Article* buffer.

\(fn)" t nil)

(autoload (quote bbdb/gnus-score) "bbdb-gnus" "\
This returns a score alist for Gnus.  A score pair will be made for
every member of the net field in records which also have a gnus-score
field.  This allows the BBDB to serve as a supplemental global score
file, with the advantage that it can keep up with multiple and changing
addresses better than the traditionally static global scorefile.

\(fn GROUP)" nil nil)

(autoload (quote bbdb/gnus-summary-show-all-recipients) "bbdb-gnus" "\
Display BBDB records for all recipients of the message.

\(fn NOT-ELIDED)" t nil)

(autoload (quote bbdb-insinuate-gnus) "bbdb-gnus" "\
Call this function to hook BBDB into Gnus.

\(fn)" nil nil)

;;;***

;;;### (autoloads (bbdb-menu bbdb-fontify-buffer) "bbdb-gui" "../package.d/bbdb/lisp/bbdb-gui.el"
;;;;;;  (18846 37975))
;;; Generated autoloads from ../package.d/bbdb/lisp/bbdb-gui.el

(autoload (quote bbdb-fontify-buffer) "bbdb-gui" "\
Not documented

\(fn &optional RECORDS)" t nil)

(autoload (quote bbdb-menu) "bbdb-gui" "\
Not documented

\(fn EVENT)" t nil)

;;;***

;;;### (autoloads (bbdb-force-record-create sample-bbdb-canonicalize-net-hook
;;;;;;  bbdb-auto-notes-hook bbdb-ignore-some-messages-hook bbdb-ignore-selected-messages-hook
;;;;;;  bbdb-ignore-most-messages-hook bbdb-extract-field-value bbdb-header-start
;;;;;;  bbdb-creation-date-hook bbdb-timestamp-hook) "bbdb-hooks"
;;;;;;  "../package.d/bbdb/lisp/bbdb-hooks.el" (18846 37975))
;;; Generated autoloads from ../package.d/bbdb/lisp/bbdb-hooks.el

(autoload (quote bbdb-timestamp-hook) "bbdb-hooks" "\
For use as a `bbdb-change-hook'; maintains a notes-field called `timestamp'
for the given record which contains the time when it was last modified.  If
there is such a field there already, it is changed, otherwise it is added.

\(fn RECORD)" nil nil)

(autoload (quote bbdb-creation-date-hook) "bbdb-hooks" "\
For use as a `bbdb-create-hook'; adds a notes-field called `creation-date'
which is the current time string.

\(fn RECORD)" nil nil)

(autoload (quote bbdb-header-start) "bbdb-hooks" "\
Returns a marker at the beginning of the header block of the current
message.  This will not necessarily be in the current buffer.

\(fn)" nil nil)

(autoload (quote bbdb-extract-field-value) "bbdb-hooks" "\
Given the name of a field (like \"Subject\") this returns the value of
that field in the current message, or nil.  This works whether you're in
Gnus, Rmail, or VM.  This works on multi-line fields, but if more than
one field of the same name is present, only the last is returned.  It is
expected that the current buffer has a message in it, and (point) is at the
beginning of the message headers.

\(fn FIELD-NAME)" nil nil)

(autoload (quote bbdb-ignore-most-messages-hook) "bbdb-hooks" "\
For use as the value of bbdb/news-auto-create-p or bbdb/mail-auto-create-p.
This will automatically create BBDB entries for messages which match
the bbdb-ignore-most-messages-alist (which see) and *no* others.

\(fn &optional INVERT-SENSE)" nil nil)

(autoload (quote bbdb-ignore-selected-messages-hook) "bbdb-hooks" "\
For use as a bbdb/news-auto-create-hook or bbdb/mail-auto-create-hook.
This will automatically create BBDB entries for messages based on a
combination of bbdb-ignore-some-messages-alist and
bbdb-ignore-most-messages-alist.  It first looks at the SOME list.  If
that doesn't disqualify a message, then it looks at the MOST list.  If
that qualifies the message, the record is auto-created, but a
confirmation is conditionally sought, based on the value of
`bbdb-ignore-selected-messages-confirmation'.

\(fn)" nil nil)

(autoload (quote bbdb-ignore-some-messages-hook) "bbdb-hooks" "\
For use as a `bbdb/news-auto-create-hook' or `bbdb/mail-auto-create-hook'.
This will automatically create BBDB entries for messages which do *not*
match the `bbdb-ignore-some-messages-alist' (which see).

\(fn)" nil nil)

(autoload (quote bbdb-auto-notes-hook) "bbdb-hooks" "\
For use as a `bbdb-notice-hook'.  This might automatically add some text
to the notes field of the BBDB record corresponding to the current record
based on the header of the current message.  See the documentation for
the variables `bbdb-auto-notes-alist' and `bbdb-auto-notes-ignore'.

\(fn RECORD)" nil nil)

(autoload (quote sample-bbdb-canonicalize-net-hook) "bbdb-hooks" "\
Not documented

\(fn ADDR)" nil nil)

(autoload (quote bbdb-force-record-create) "bbdb-hooks" "\
Force automatic creation of a BBDB records for the current message.
You might add this to the reply hook of your MUA in order to automatically
get records added for those people you reply to.

\(fn)" t nil)

;;;***

;;;### (autoloads (bbdb-merge-file bbdb-merge-record) "bbdb-merge"
;;;;;;  "../package.d/bbdb/lisp/bbdb-merge.el" (18846 37975))
;;; Generated autoloads from ../package.d/bbdb/lisp/bbdb-merge.el

(autoload (quote bbdb-merge-record) "bbdb-merge" "\
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

(autoload (quote bbdb-merge-file) "bbdb-merge" "\
Merge a bbdb file into the in-core bbdb.

\(fn &optional BBDB-NEW OVERRIDE MATCH-FUN)" t nil)

;;;***

;;;### (autoloads (bbdb-insinuate-mh bbdb/mh-show-sender bbdb/mh-annotate-sender
;;;;;;  bbdb/mh-update-record) "bbdb-mhe" "../package.d/bbdb/lisp/bbdb-mhe.el"
;;;;;;  (18846 37975))
;;; Generated autoloads from ../package.d/bbdb/lisp/bbdb-mhe.el

(autoload (quote bbdb/mh-update-record) "bbdb-mhe" "\
Returns the record corresponding to the current MH message, creating or
modifying it as necessary.  A record will be created if
bbdb/mail-auto-create-p is non-nil, or if OFFER-TO-CREATE is true and
the user confirms the creation.

\(fn &optional OFFER-TO-CREATE)" nil nil)

(autoload (quote bbdb/mh-annotate-sender) "bbdb-mhe" "\
Add a line to the end of the Notes field of the BBDB record
corresponding to the sender of this message.  If REPLACE is non-nil,
replace the existing notes entry (if any).

\(fn STRING &optional REPLACE)" t nil)

(autoload (quote bbdb/mh-show-sender) "bbdb-mhe" "\
Display the contents of the BBDB for the sender of this message.
This buffer will be in bbdb-mode, with associated keybindings.

\(fn)" t nil)

(autoload (quote bbdb-insinuate-mh) "bbdb-mhe" "\
Call this function to hook BBDB into MH-E.

\(fn)" nil nil)

;;;***

;;;### (autoloads (bbdb-migrate-update-file-version bbdb-migrate-rewrite-all
;;;;;;  bbdb-unmigrate-record bbdb-migrate bbdb-migration-query)
;;;;;;  "bbdb-migrate" "../package.d/bbdb/lisp/bbdb-migrate.el" (18846
;;;;;;  37975))
;;; Generated autoloads from ../package.d/bbdb/lisp/bbdb-migrate.el

(autoload (quote bbdb-migration-query) "bbdb-migrate" "\
Ask if the database is to be migrated.
ONDISK is the version number of the database as currently stored on
disk.  Returns the version for the saved database.

\(fn ONDISK)" nil nil)

(autoload (quote bbdb-migrate) "bbdb-migrate" "\
Migrate the BBDB from the version on disk (the car of
`bbdb-file-format-migration') to the current version (in
`bbdb-file-format').

\(fn RECORDS)" nil nil)

(autoload (quote bbdb-unmigrate-record) "bbdb-migrate" "\
Reverse-migrate a single record from the current version (in
`bbdb-file-format') to the version to be saved (the cdr of
`bbdb-file-format-migration').

\(fn RECORD)" nil nil)

(autoload (quote bbdb-migrate-rewrite-all) "bbdb-migrate" "\
Rewrite each and every record in the bbdb file; this is necessary if we
are updating an old file format.  MESSAGE-P says whether to sound off
for each record converted.  If RECORDS is non-nil, its value will be
used as the list of records to update.

\(fn MESSAGE-P &optional RECORDS)" nil nil)

(autoload (quote bbdb-migrate-update-file-version) "bbdb-migrate" "\
Change the `file-version' string from the OLD version to the NEW
version.

\(fn OLD NEW)" nil nil)

;;;***

;;;### (autoloads (bbdb-obsolete-net-canonicalize-net-hook) "bbdb-obsolete"
;;;;;;  "../package.d/bbdb/bits/bbdb-obsolete.el" (18846 37975))
;;; Generated autoloads from ../package.d/bbdb/bits/bbdb-obsolete.el

(autoload (quote bbdb-obsolete-net-canonicalize-net-hook) "bbdb-obsolete" "\
Return user's current net address given obsolete ADDR.

Return ADDR if it is not obsolete anywhere, or there is no net address
in the matching record.  The field is set in `bbdb-obsolete-net-field'.

\(fn ADDR)" nil nil)

;;;***

;;;### (autoloads (bbdb-utilities-pgp) "bbdb-pgp" "../package.d/bbdb/bits/bbdb-pgp.el"
;;;;;;  (18846 37975))
;;; Generated autoloads from ../package.d/bbdb/bits/bbdb-pgp.el

(let ((loads (get (quote bbdb-utilities-pgp) (quote custom-loads)))) (if (member (quote "bbdb-pgp") loads) nil (put (quote bbdb-utilities-pgp) (quote custom-loads) (cons (quote "bbdb-pgp") loads))))

;;;***

;;;### (autoloads (bbdb-print) "bbdb-print" "../package.d/bbdb/lisp/bbdb-print.el"
;;;;;;  (18846 37975))
;;; Generated autoloads from ../package.d/bbdb/lisp/bbdb-print.el

(autoload (quote bbdb-print) "bbdb-print" "\
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
;;;;;;  (18846 37975))
;;; Generated autoloads from ../package.d/bbdb/lisp/bbdb-reportmail.el

(autoload (quote bbdb-insinuate-reportmail) "bbdb-reportmail" "\
Call this function to hook BBDB into reportmail.

\(fn)" nil nil)

;;;***

;;;### (autoloads (bbdb-insinuate-rmail bbdb/rmail-show-sender bbdb/rmail-annotate-sender
;;;;;;  bbdb/rmail-update-records bbdb/rmail-update-record) "bbdb-rmail"
;;;;;;  "../package.d/bbdb/lisp/bbdb-rmail.el" (18846 37975))
;;; Generated autoloads from ../package.d/bbdb/lisp/bbdb-rmail.el

(autoload (quote bbdb/rmail-update-record) "bbdb-rmail" "\
Not documented

\(fn &optional OFFER-TO-CREATE)" nil nil)

(autoload (quote bbdb/rmail-update-records) "bbdb-rmail" "\
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

(autoload (quote bbdb/rmail-annotate-sender) "bbdb-rmail" "\
Add a line to the end of the Notes field of the BBDB record
corresponding to the sender of this message.  If REPLACE is non-nil,
replace the existing notes entry (if any).

\(fn STRING &optional REPLACE)" t nil)

(autoload (quote bbdb/rmail-show-sender) "bbdb-rmail" "\
Display the contents of the BBDB for the sender of this message.
This buffer will be in bbdb-mode, with associated keybindings.

\(fn)" t nil)

(autoload (quote bbdb-insinuate-rmail) "bbdb-rmail" "\
Call this function to hook BBDB into RMAIL.

\(fn)" nil nil)

;;;***

;;;### (autoloads (bbdb-insinuate-sc bbdb/sc-default) "bbdb-sc" "../package.d/bbdb/lisp/bbdb-sc.el"
;;;;;;  (18846 37975))
;;; Generated autoloads from ../package.d/bbdb/lisp/bbdb-sc.el

(autoload (quote bbdb/sc-default) "bbdb-sc" "\
If the current \"from\" field in `sc-mail-info' alist
contains only an e-mail address, lookup e-mail address in
BBDB, and prepend a new \"from\" field to `sc-mail-info'.

\(fn)" nil nil)

(autoload (quote bbdb-insinuate-sc) "bbdb-sc" "\
Call this function to hook BBDB into Supercite.

\(fn)" nil nil)

;;;***

;;;### (autoloads (bbdb-rfc822-addresses bbdb-extract-address-components
;;;;;;  bbdb-snarf-region bbdb-snarf) "bbdb-snarf" "../package.d/bbdb/lisp/bbdb-snarf.el"
;;;;;;  (18846 37975))
;;; Generated autoloads from ../package.d/bbdb/lisp/bbdb-snarf.el

(autoload (quote bbdb-snarf) "bbdb-snarf" "\
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

(autoload (quote bbdb-snarf-region) "bbdb-snarf" "\
snarf up a bbdb record in the current region.  See `bbdb-snarf' for
more details.

\(fn BEGIN END)" t nil)

(autoload (quote bbdb-extract-address-components) "bbdb-snarf" "\
Return a list of address components found in ADSTRING.
If extracting fails one probably has to adjust the variable
`bbdb-extract-address-component-regexps'.

\(fn ADSTRING &optional IGNORE-ERRORS)" nil nil)

(autoload (quote bbdb-rfc822-addresses) "bbdb-snarf" "\
Split ADDRLINE into a list of parsed addresses.

You can't do this with rfc822.el in any sort of useful way because it discards
the comments. You can't do this with mail-extr.el because the multiple address
parsing in GNU Emacs appears to be broken beyond belief, and the XEmacs
version doesn't support multiple addresses.

\(fn ADDRLINE &optional IGNORE-ERRORS)" nil nil)

;;;***

;;;### (autoloads (bbdb-srv-add-phone bbdb/srv-auto-create-mail-news-dispatcher
;;;;;;  bbdb/srv-handle-headers-with-delay) "bbdb-srv" "../package.d/bbdb/lisp/bbdb-srv.el"
;;;;;;  (18846 37975))
;;; Generated autoloads from ../package.d/bbdb/lisp/bbdb-srv.el

(autoload (quote bbdb/srv-handle-headers-with-delay) "bbdb-srv" "\
Just like bbdb/srv-handle-headers, but only updates every few seconds.
This is so that trying to display many records in succession won't queue them
up, but will end up only displaying a record when no displays have been
requested for a couple of seconds.

\(fn HEADERS)" nil nil)

(defalias (quote bbdb-srv) (quote bbdb/srv-handle-headers-with-delay))

(autoload (quote bbdb/srv-auto-create-mail-news-dispatcher) "bbdb-srv" "\
For use as the value of bbdb/srv-auto-create-p.
This will try to decide if this is a mail message or a news message, and then
run either bbdb/news-auto-create-p or bbdb/mail-auto-create-p as appropriate.
\(The heuristic is that news messages never have a Status or X-Mozilla-Status
header; and that mail messages never have Path headers.)

\(fn)" nil nil)

(autoload (quote bbdb-srv-add-phone) "bbdb-srv" "\
Not documented

\(fn PHONE-STRING &optional DESCRIPTION RECORD)" nil nil)

;;;***

;;;### (autoloads (bbdb-test/run-one-test bbdb-test/run-tests bbdb-test/run-all-tests)
;;;;;;  "bbdb-test" "../package.d/bbdb/testing/bbdb-test.el" (18846
;;;;;;  37975))
;;; Generated autoloads from ../package.d/bbdb/testing/bbdb-test.el

(autoload (quote bbdb-test/run-all-tests) "bbdb-test" "\
Run all BBDB tests.

\(fn &optional BATCH)" t nil)

(autoload (quote bbdb-test/run-tests) "bbdb-test" "\
Run BBDB tests.

\(fn)" t nil)

(autoload (quote bbdb-test/run-one-test) "bbdb-test" "\
Not documented

\(fn TEST-VAR)" t nil)

;;;***

;;;### (autoloads (bbdb-insinuate-vm bbdb/vm-set-auto-folder-alist
;;;;;;  bbdb/vm-set-auto-folder-alist-headers bbdb/vm-set-auto-folder-alist-field
;;;;;;  bbdb/vm-show-sender bbdb/vm-show-all-recipients bbdb/vm-show-records
;;;;;;  bbdb/vm-annotate-sender bbdb/vm-update-records bbdb/vm-update-record)
;;;;;;  "bbdb-vm" "../package.d/bbdb/lisp/bbdb-vm.el" (18846 37975))
;;; Generated autoloads from ../package.d/bbdb/lisp/bbdb-vm.el

(autoload (quote bbdb/vm-update-record) "bbdb-vm" "\
Not documented

\(fn &optional OFFER-TO-CREATE)" nil nil)

(autoload (quote bbdb/vm-update-records) "bbdb-vm" "\
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

(autoload (quote bbdb/vm-annotate-sender) "bbdb-vm" "\
Add a line to the end of the Notes field of the BBDB record
corresponding to the sender of this message.  If REPLACE is non-nil,
replace the existing notes entry (if any).

\(fn STRING &optional REPLACE)" t nil)

(autoload (quote bbdb/vm-show-records) "bbdb-vm" "\
Display the contents of the BBDB for the sender of this message.
This buffer will be in bbdb-mode, with associated keybindings.

\(fn &optional ADDRESS-CLASS)" t nil)

(autoload (quote bbdb/vm-show-all-recipients) "bbdb-vm" "\
Show all recipients of this message. Counterpart to `bbdb/vm-show-sender'.

\(fn)" t nil)

(autoload (quote bbdb/vm-show-sender) "bbdb-vm" "\
Display the contents of the BBDB for the senders of this message.
With a prefix argument show the recipients instead,
with two prefix arguments show all records.
This buffer will be in `bbdb-mode', with associated keybindings.

\(fn &optional SHOW-RECIPIENTS)" t nil)

(defvar bbdb/vm-set-auto-folder-alist-field (quote vm-folder) "\
*The field which `bbdb/vm-set-auto-folder-alist' searches for.")

(custom-autoload (quote bbdb/vm-set-auto-folder-alist-field) "bbdb-vm" t)

(defvar bbdb/vm-set-auto-folder-alist-headers (quote ("From:" "To:" "CC:")) "\
*The headers used by `bbdb/vm-set-auto-folder-alist'.
The order in this list is the order how matching will be performed!")

(custom-autoload (quote bbdb/vm-set-auto-folder-alist-headers) "bbdb-vm" t)

(autoload (quote bbdb/vm-set-auto-folder-alist) "bbdb-vm" "\
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

(autoload (quote bbdb-insinuate-vm) "bbdb-vm" "\
Call this function to hook BBDB into VM.

\(fn)" nil nil)

;;;***

;;;### (autoloads (bbdb-insinuate-w3 bbdb-www-grab-homepage bbdb-www)
;;;;;;  "bbdb-w3" "../package.d/bbdb/lisp/bbdb-w3.el" (18846 37975))
;;; Generated autoloads from ../package.d/bbdb/lisp/bbdb-w3.el

(autoload (quote bbdb-www) "bbdb-w3" "\
Visit URLs stored in the `www' field of the current record.
\\[bbdb-apply-next-command-to-all-records]\\[bbdb-www] means to try all records currently visible.
Non-interactively, do all records if arg is nonnil.

\(fn REC &optional WHICH)" t nil)

(autoload (quote bbdb-www-grab-homepage) "bbdb-w3" "\
Grab the current URL and store it in the bbdb database

\(fn RECORD)" t nil)

(autoload (quote bbdb-insinuate-w3) "bbdb-w3" "\
Call this function to hook BBDB into W3.

\(fn)" nil nil)

;;;***

;;;### (autoloads (bbdb-whois) "bbdb-whois" "../package.d/bbdb/lisp/bbdb-whois.el"
;;;;;;  (18846 37975))
;;; Generated autoloads from ../package.d/bbdb/lisp/bbdb-whois.el

(autoload (quote bbdb-whois) "bbdb-whois" "\
Not documented

\(fn THE-RECORD &optional SERVER)" t nil)

;;;***

;;;### (autoloads (bbdb-load-touchtones bbdb-sound-volume bbdb-sounds-directory
;;;;;;  bbdb-xemacs-display-completion-list) "bbdb-xemacs" "../package.d/bbdb/lisp/bbdb-xemacs.el"
;;;;;;  (18846 37975))
;;; Generated autoloads from ../package.d/bbdb/lisp/bbdb-xemacs.el

(autoload (quote bbdb-xemacs-display-completion-list) "bbdb-xemacs" "\
Wrapper for `display-completion-list'.
Allows callbacks on XEmacs `display-completion-list' is called with
`:activate-callback CALLBACK' if CALLBACK is non-nil.
`:user-data DATA' is also used if DATA is non-nil.
Neither are used if CALLBACK is nil.

\(fn LIST &optional CALLBACK DATA)" nil nil)

(defvar bbdb-sounds-directory (expand-file-name "~/.xemacs/etc/sounds") "\
The directory to load the touchtone sound files from, or nil if none.")

(custom-autoload (quote bbdb-sounds-directory) "bbdb-xemacs" t)

(defvar bbdb-sound-volume 50 "\
Volume for playing sounds.")

(custom-autoload (quote bbdb-sound-volume) "bbdb-xemacs" t)

(autoload (quote bbdb-load-touchtones) "bbdb-xemacs" "\
Load the touchtone sounds into `sound-alist'.
The directory specified in `bbdb-sounds-directory' is searched for the files
touchtone.*\\.\\(wav\\|au\\) as named in `bbdb-sound-files'.
They are stored in `sound-alist' as touchtone0 to touchtone11.

\(fn)" t nil)

;;;***

;;;### (autoloads (bibl-visit-grab) "bibl-grab" "../package.d/bibl-mode-1.27/bibl-grab.el"
;;;;;;  (18847 2295))
;;; Generated autoloads from ../package.d/bibl-mode-1.27/bibl-grab.el

(autoload (quote bibl-visit-grab) "bibl-grab" "\
Grab from the current buffer, visit bibliography file, create a record.
If called with a prefix argument, search for record entries from
point, rather than from the top of the current buffer.

See the documentation for `bibl-visit-bibliography' for more details.

\(fn &optional FROM-HERE)" t nil)

;;;***

;;;### (autoloads (bibl-names-mode bibl-names-find-record bibl-visit-list-names
;;;;;;  bibl-list-names bibl-visit-list-keywords bibl-list-keywords
;;;;;;  bibl-sort-buffer) "bibl-lists" "../package.d/bibl-mode-1.27/bibl-lists.el"
;;;;;;  (18847 2295))
;;; Generated autoloads from ../package.d/bibl-mode-1.27/bibl-lists.el

(autoload (quote bibl-sort-buffer) "bibl-lists" "\
Sort the contents of a bibliography mode buffer.

If called with a prefix arg, sorts by keyword, otherwise by record
name.

Uses the value of case-fold-search to determine whether or not to
ignore case while sorting.

\(fn TYPE)" t nil)

(autoload (quote bibl-list-keywords) "bibl-lists" "\
Make a list of the keywords found in a bibliography buffer.
Call with NO-POP set to something non-nil, or call interactively with
a prefix argument, to work with less window shuffling.

\(fn &optional NO-POP)" t nil)

(autoload (quote bibl-visit-list-keywords) "bibl-lists" "\
Visit a bibliography buffer and make a list of the keywords to be found.
See the documentation for `bibl-list-keywords' and `bibl-visit-bibliography'.

\(fn &optional NO-POP)" t nil)

(autoload (quote bibl-list-names) "bibl-lists" "\
Make a list of the names found in a bibliography buffer.
Call with NO-POP set to something non-nil, or call interactively with
a prefix argument, to do this without any window shuffling.

\(fn &optional NO-POP)" t nil)

(autoload (quote bibl-visit-list-names) "bibl-lists" "\
Visit a bibliography buffer and make a list of the names to be found.
See the documentation for `bibl-list-keywords' and `bibl-visit-bibliography'.

\(fn &optional NO-POP)" t nil)

(autoload (quote bibl-names-find-record) "bibl-lists" "\
Try to find a record in the bibliography file.
This operates on a name or keyword taken from a names buffer.  With a
prefix argument, the search goes from the top.

\(fn &optional FROM-TOP)" t nil)

(autoload (quote bibl-names-mode) "bibl-lists" "\
Major mode for tracking keyword and record names for bibliography files.
Not all that major, but since it's illegal to do anything else while
in here, I might as well make it so.

Commands:
\\{bibl-names-mode-map}

Entry to this mode calls the value of `bibl-names-mode-hooks' if that
value is non-nil.

\(fn &optional TYPE OWNER)" t nil)

;;;***

;;;### (autoloads (bibl-mode bibl-visit-goto bibl-visit-create bibl-visit-bibliography)
;;;;;;  "bibl-mode" "../package.d/bibl-mode-1.27/bibl-mode.el" (18847
;;;;;;  2295))
;;; Generated autoloads from ../package.d/bibl-mode-1.27/bibl-mode.el

(autoload (quote bibl-visit-bibliography) "bibl-mode" "\
Visit a bibliography file.
Uses the value of `bibl-file-name' as a default guess if run
interactively.  If `bibl-prompt-on-visit' is t, asks the user to
confirm the filename if called interactively.

\(fn FILE)" t nil)

(autoload (quote bibl-visit-create) "bibl-mode" "\
Visit a bibliography file and create a new record.
See the documentation for `bibl-visit-bibliography'.

\(fn)" t nil)

(autoload (quote bibl-visit-goto) "bibl-mode" "\
Visit a bibliography file and go to some record.
See the documentation for `bibl-visit-bibliography' and
`bibl-goto-record'.

\(fn)" t nil)

(autoload (quote bibl-mode) "bibl-mode" "\
Major mode for editing bibliography files.

By default, we only handle one such buffer at a time (its name should
be in bibl-file-name).  If you want to use more than one buffer in
bibliography mode at once, set `bibl-use-any-buffer' to t.  Note that
you will have to use bibliography mode commands from within
bibliography mode buffers in that case; they won't work just anywhere
any longer.

Page delimiter definitions have been changed so that the page movement
commands (\\[forward-page] and \\[backward-page]) hop between records.

The mode-specific key bindings are as follows:

\\{bibl-mode-prefix-map}
To access the global key bindings, put a line such as the following in
your `.emacs':
  (global-set-key \"\\Cb\" 'bibl-global-map)
Once bound to something in this way, the global key bindings go like
this:

\\{bibl-global-map}
Entry to this mode causes `bibl-mode-hooks' to be run.

\(fn)" t nil)

(define-prefix-command (quote bibl-global-map))

(define-key bibl-global-map "c" (quote bibl-visit-create))

(define-key bibl-global-map "g" (quote bibl-visit-grab))

(define-key bibl-global-map "k" (quote bibl-visit-list-keywords))

(define-key bibl-global-map "n" (quote bibl-visit-list-names))

(define-key bibl-global-map "o" (quote bibl-visit-goto))

(define-key bibl-global-map "v" (quote bibl-visit-bibliography))

;;;***

;;;### (autoloads (with-expect) "expect" "../package.d/mailcrypt/expect.el"
;;;;;;  (18846 37975))
;;; Generated autoloads from ../package.d/mailcrypt/expect.el

(autoload (quote with-expect) "expect" "\
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

;;;### (autoloads (mew-shimbun-expire mew-shimbun-expire-all mew-shimbun-re-retrieve-all
;;;;;;  mew-shimbun-re-retrieve mew-shimbun-retrieve-all mew-shimbun-retrieve
;;;;;;  mew-shimbun-goto-folder mew-shimbun-goto-unseen-folder) "mew-shimbun"
;;;;;;  "../package.d/w3m-el/shimbun/mew-shimbun.el" (18846 37975))
;;; Generated autoloads from ../package.d/w3m-el/shimbun/mew-shimbun.el

(autoload (quote mew-shimbun-goto-unseen-folder) "mew-shimbun" "\
Goto folder for SHIMBUN to have a few new messages.

\(fn)" t nil)

(autoload (quote mew-shimbun-goto-folder) "mew-shimbun" "\
Goto folder for SHIMBUN.
If called with '\\[universal-argument]', goto folder to have a few new messages.

\(fn &optional ARGS)" t nil)

(autoload (quote mew-shimbun-retrieve) "mew-shimbun" "\
Retrieve articles via SHIMBUN on this folder.

\(fn &optional NEWFLD)" t nil)

(autoload (quote mew-shimbun-retrieve-all) "mew-shimbun" "\
Retrieve all articles via SHIMBUN.

\(fn)" t nil)

(autoload (quote mew-shimbun-re-retrieve) "mew-shimbun" "\
Re-retrieve this message.
If called with '\\[universal-argument]', re-retrieve messages marked with
'mew-shimbun-mark-re-retrieve'.

\(fn &optional ARGS)" t nil)

(autoload (quote mew-shimbun-re-retrieve-all) "mew-shimbun" "\
Re-retrieve all messages in this folder.
If called with '\\[universal-argument]', re-retrieve messages in the region.

\(fn &optional ARG)" t nil)

(autoload (quote mew-shimbun-expire-all) "mew-shimbun" "\
Expire all shimbun folder.

\(fn)" t nil)

(autoload (quote mew-shimbun-expire) "mew-shimbun" "\
Expire this shimbun folder.

\(fn)" t nil)

;;;***

;;;### (autoloads (mime-w3m-preview-text/html) "mime-w3m" "../package.d/w3m-el/mime-w3m.el"
;;;;;;  (18846 37975))
;;; Generated autoloads from ../package.d/w3m-el/mime-w3m.el

(autoload (quote mime-w3m-preview-text/html) "mime-w3m" "\
Not documented

\(fn ENTITY SITUATION)" nil nil)

;;;***

;;;### (autoloads (gnus-group-make-shimbun-groups gnus-group-make-shimbun-group
;;;;;;  gnus-summary-refer-shimbun-article) "nnshimbun" "../package.d/w3m-el/shimbun/nnshimbun.el"
;;;;;;  (18846 37975))
;;; Generated autoloads from ../package.d/w3m-el/shimbun/nnshimbun.el

(autoload (quote gnus-summary-refer-shimbun-article) "nnshimbun" "\
Show a shimbun article pointed to by the given URL.

\(fn URL)" t nil)

(autoload (quote gnus-group-make-shimbun-group) "nnshimbun" "\
Create a new nnshimbun group.
The user will be prompted for a SERVER name and a GROUP name.  When
this command is called with a prefix argument, it makes an ephemeral
shimbun group.

\(fn SERVER GROUP &optional EPHEMERAL)" t nil)

(autoload (quote gnus-group-make-shimbun-groups) "nnshimbun" "\
Create all nnshimbun groups prepared for SERVER.

\(fn SERVER)" t nil)

;;;***

;;;### (autoloads (octet-mime-setup mime-view-octet mime-preview-octet
;;;;;;  octet-find-file octet-buffer) "octet" "../package.d/w3m-el/octet.el"
;;;;;;  (18846 37975))
;;; Generated autoloads from ../package.d/w3m-el/octet.el

(autoload (quote octet-buffer) "octet" "\
View octet-stream content according to `octet-type-filter-alist'.
Optional NAME is the filename.
If optional CONTENT-TYPE is specified, it is used for type guess.

\(fn &optional NAME CONTENT-TYPE)" t nil)

(autoload (quote octet-find-file) "octet" "\
Find FILE with octet-stream decoding.

\(fn FILE)" t nil)

(autoload (quote mime-preview-octet) "octet" "\
A method for mime-view to preview octet message.

\(fn ENTITY SITUATION)" nil nil)

(autoload (quote mime-view-octet) "octet" "\
A method for mime-view to display octet message.

\(fn ENTITY SITUATION)" nil nil)

(autoload (quote octet-mime-setup) "octet" "\
Octet setting for MIME module.

\(fn)" nil nil)

;;;***

;;;### (autoloads (svn-status svn-checkout) "psvn" "../package.d/psvn.el"
;;;;;;  (18846 37975))
;;; Generated autoloads from ../package.d/psvn.el

(autoload (quote svn-checkout) "psvn" "\
Run svn checkout REPOS-URL PATH.

\(fn REPOS-URL PATH)" t nil)
 (defalias 'svn-examine 'svn-status)

(autoload (quote svn-status) "psvn" "\
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

;;;### (autoloads (rst-minor-mode rst-mode) "rst" "../package.d/rst.el"
;;;;;;  (18846 37975))
;;; Generated autoloads from ../package.d/rst.el

(autoload (quote rst-mode) "rst" "\
Not documented

\(fn)" t nil)

(autoload (quote rst-minor-mode) "rst" "\
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

;;;### (autoloads (w3m-buffer w3m-region w3m-find-file w3m-browse-url
;;;;;;  w3m w3m-gohome w3m-goto-url-new-session w3m-goto-url w3m-download
;;;;;;  w3m-retrieve) "w3m" "../package.d/w3m-el/w3m.el" (18846 37976))
;;; Generated autoloads from ../package.d/w3m-el/w3m.el

(autoload (quote w3m-retrieve) "w3m" "\
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

(autoload (quote w3m-download) "w3m" "\
Download contents of URL to a file named FILENAME.
NO-CHACHE (which the prefix argument gives when called interactively)
specifies not using the cached data.

\(fn URL &optional FILENAME NO-CACHE HANDLER POST-DATA)" t nil)

(autoload (quote w3m-goto-url) "w3m" "\
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

(autoload (quote w3m-goto-url-new-session) "w3m" "\
Visit World Wide Web pages in a new session.
If you invoke this command in the emacs-w3m buffer, the new session
will be created by copying the current session.  Otherwise, the new
session will start afresh.

\(fn URL &optional RELOAD CHARSET POST-DATA REFERER)" t nil)

(autoload (quote w3m-gohome) "w3m" "\
Go to the Home page.

\(fn)" t nil)

(autoload (quote w3m) "w3m" "\
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

(autoload (quote w3m-browse-url) "w3m" "\
Ask emacs-w3m to browse URL.
NEW-SESSION specifies whether to create a new emacs-w3m session.  URL
defaults to the string looking like a url around the cursor position.
Pop to a window or a frame up according to `w3m-pop-up-windows' and
`w3m-pop-up-frames'.

\(fn URL &optional NEW-SESSION)" t nil)

(autoload (quote w3m-find-file) "w3m" "\
Function used to open FILE whose name is expressed in ordinary format.
The file name will be converted into the file: scheme.

\(fn FILE)" t nil)

(autoload (quote w3m-region) "w3m" "\
Render the region of the current buffer between START and END.
URL specifies the address where the contents come from.  It can be
omitted or nil when the address is not identified.  CHARSET is used
for decoding the contents.  If it is nil, this function attempts to
parse the meta tag to extract the charset.

\(fn START END &optional URL CHARSET)" t nil)

(autoload (quote w3m-buffer) "w3m" "\
Render the current buffer.
See `w3m-region' for the optional arguments.

\(fn &optional URL CHARSET)" t nil)

;;;***

;;;### (autoloads (w3m-antenna w3m-about-antenna) "w3m-antenna" "../package.d/w3m-el/w3m-antenna.el"
;;;;;;  (18846 37976))
;;; Generated autoloads from ../package.d/w3m-el/w3m-antenna.el

(autoload (quote w3m-about-antenna) "w3m-antenna" "\
Not documented

\(fn URL &optional NO-DECODE NO-CACHE POST-DATA REFERER HANDLER)" nil nil)

(autoload (quote w3m-antenna) "w3m-antenna" "\
Report changes of WEB sites, which is specified in `w3m-antenna-sites'.

\(fn &optional NO-CACHE)" t nil)

;;;***

;;;### (autoloads (w3m-setup-bookmark-menu w3m-about-bookmark w3m-bookmark-view-new-session
;;;;;;  w3m-bookmark-view w3m-bookmark-add-current-url-group w3m-bookmark-add-all-urls
;;;;;;  w3m-bookmark-add-current-url w3m-bookmark-add-this-url) "w3m-bookmark"
;;;;;;  "../package.d/w3m-el/w3m-bookmark.el" (18846 37976))
;;; Generated autoloads from ../package.d/w3m-el/w3m-bookmark.el

(autoload (quote w3m-bookmark-add-this-url) "w3m-bookmark" "\
Add link under cursor to bookmark.

\(fn)" t nil)

(autoload (quote w3m-bookmark-add-current-url) "w3m-bookmark" "\
Add a url of the current page to the bookmark.
With prefix, ask for a new url instead of the present one.

\(fn &optional ARG)" t nil)

(autoload (quote w3m-bookmark-add-all-urls) "w3m-bookmark" "\
Add urls of all pages being visited to the bookmark.

\(fn)" t nil)

(autoload (quote w3m-bookmark-add-current-url-group) "w3m-bookmark" "\
Add link of the group of current urls to the bookmark.

\(fn)" t nil)

(autoload (quote w3m-bookmark-view) "w3m-bookmark" "\
Display the bookmark.

\(fn &optional RELOAD)" t nil)

(autoload (quote w3m-bookmark-view-new-session) "w3m-bookmark" "\
Display the bookmark on a new session.

\(fn &optional RELOAD)" t nil)

(autoload (quote w3m-about-bookmark) "w3m-bookmark" "\
Not documented

\(fn &rest ARGS)" nil nil)

(autoload (quote w3m-setup-bookmark-menu) "w3m-bookmark" "\
Setup w3m bookmark items in menubar.

\(fn)" nil nil)

;;;***

;;;### (autoloads (w3m-about-cookie w3m-cookie w3m-cookie-get w3m-cookie-set
;;;;;;  w3m-cookie-shutdown) "w3m-cookie" "../package.d/w3m-el/w3m-cookie.el"
;;;;;;  (18846 37976))
;;; Generated autoloads from ../package.d/w3m-el/w3m-cookie.el

(autoload (quote w3m-cookie-shutdown) "w3m-cookie" "\
Save cookies, and reset cookies' data.

\(fn)" t nil)

(autoload (quote w3m-cookie-set) "w3m-cookie" "\
Register cookies which correspond to URL.
BEG and END should be an HTTP response header region on current buffer.

\(fn URL BEG END)" nil nil)

(autoload (quote w3m-cookie-get) "w3m-cookie" "\
Get a cookie field string which corresponds to the URL.

\(fn URL)" nil nil)

(autoload (quote w3m-cookie) "w3m-cookie" "\
Display cookies and enable you to manage them.

\(fn &optional NO-CACHE)" t nil)

(autoload (quote w3m-about-cookie) "w3m-cookie" "\
Make the html contents to display and to enable you to manage cookies.

\(fn URL &optional NO-DECODE NO-CACHE POST-DATA &rest ARGS)" nil nil)

;;;***

;;;### (autoloads (w3m-dtree w3m-about-dtree) "w3m-dtree" "../package.d/w3m-el/w3m-dtree.el"
;;;;;;  (18846 37976))
;;; Generated autoloads from ../package.d/w3m-el/w3m-dtree.el

(autoload (quote w3m-about-dtree) "w3m-dtree" "\
Not documented

\(fn URL &optional NODECODE ALLFILES &rest ARGS)" nil nil)

(autoload (quote w3m-dtree) "w3m-dtree" "\
Display directory tree on local file system.
If called with 'prefix argument', display all directorys and files.

\(fn ALLFILES PATH)" t nil)

;;;***

;;;### (autoloads (w3m-fb-mode) "w3m-fb" "../package.d/w3m-el/w3m-fb.el"
;;;;;;  (18846 37976))
;;; Generated autoloads from ../package.d/w3m-el/w3m-fb.el

(defvar w3m-fb-mode nil "\
Non-nil if W3m-Fb mode is enabled.
See the command `w3m-fb-mode' for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `w3m-fb-mode'.")

(custom-autoload (quote w3m-fb-mode) "w3m-fb" nil)

(autoload (quote w3m-fb-mode) "w3m-fb" "\
Toggle W3M Frame Buffer mode.
This allows frame-local lists of buffers (tabs).

\(fn &optional ARG)" t nil)

;;;***

;;;### (autoloads (w3m-filter) "w3m-filter" "../package.d/w3m-el/w3m-filter.el"
;;;;;;  (18846 37976))
;;; Generated autoloads from ../package.d/w3m-el/w3m-filter.el

(autoload (quote w3m-filter) "w3m-filter" "\
Apply filtering rule of URL against a content in this buffer.

\(fn URL)" nil nil)

;;;***

;;;### (autoloads (w3m-fontify-forms) "w3m-form" "../package.d/w3m-el/w3m-form.el"
;;;;;;  (18846 37976))
;;; Generated autoloads from ../package.d/w3m-el/w3m-form.el

(autoload (quote w3m-fontify-forms) "w3m-form" "\
Process half-dumped data and fontify forms in this buffer.

\(fn)" nil nil)

;;;***

;;;### (autoloads (w3m-link-numbering-mode) "w3m-lnum" "../package.d/w3m-el/w3m-lnum.el"
;;;;;;  (18846 37976))
;;; Generated autoloads from ../package.d/w3m-el/w3m-lnum.el

(autoload (quote w3m-link-numbering-mode) "w3m-lnum" "\
Minor mode to enable operations using link numbers.

\(fn &optional ARG)" t nil)

;;;***

;;;### (autoloads (w3m-namazu w3m-about-namazu) "w3m-namazu" "../package.d/w3m-el/w3m-namazu.el"
;;;;;;  (18846 37976))
;;; Generated autoloads from ../package.d/w3m-el/w3m-namazu.el

(autoload (quote w3m-about-namazu) "w3m-namazu" "\
Not documented

\(fn URL &optional NO-DECODE NO-CACHE &rest ARGS)" nil nil)

(autoload (quote w3m-namazu) "w3m-namazu" "\
Search indexed files with Namazu.

\(fn INDEX QUERY &optional RELOAD)" t nil)

;;;***

;;;### (autoloads (w3m-perldoc w3m-about-perldoc) "w3m-perldoc" "../package.d/w3m-el/w3m-perldoc.el"
;;;;;;  (18846 37976))
;;; Generated autoloads from ../package.d/w3m-el/w3m-perldoc.el

(autoload (quote w3m-about-perldoc) "w3m-perldoc" "\
Not documented

\(fn URL &optional NO-DECODE NO-CACHE &rest ARGS)" nil nil)

(autoload (quote w3m-perldoc) "w3m-perldoc" "\
View Perl documents.

\(fn DOCNAME)" t nil)

;;;***

;;;### (autoloads (w3m-search-uri-replace w3m-search-new-session
;;;;;;  w3m-search) "w3m-search" "../package.d/w3m-el/w3m-search.el"
;;;;;;  (18846 37976))
;;; Generated autoloads from ../package.d/w3m-el/w3m-search.el

(autoload (quote w3m-search) "w3m-search" "\
Search QUERY using SEARCH-ENGINE.
When called interactively with a prefix argument, you can choose one of
the search engines defined in `w3m-search-engine-alist'.  Otherwise use
`w3m-search-default-engine'.
If Transient Mark mode, use the region as an initial string of query
and deactivate the mark.

\(fn SEARCH-ENGINE QUERY)" t nil)

(autoload (quote w3m-search-new-session) "w3m-search" "\
Like `w3m-search', but do the search in a new session.

\(fn SEARCH-ENGINE QUERY)" t nil)

(autoload (quote w3m-search-uri-replace) "w3m-search" "\
Generate query string for ENGINE from URI matched by last search.

\(fn URI ENGINE)" nil nil)

;;;***

;;;### (autoloads (w3m-setup-session-menu w3m-session-select w3m-session-save)
;;;;;;  "w3m-session" "../package.d/w3m-el/w3m-session.el" (18846
;;;;;;  37976))
;;; Generated autoloads from ../package.d/w3m-el/w3m-session.el

(autoload (quote w3m-session-save) "w3m-session" "\
Save list of displayed session.

\(fn)" t nil)

(autoload (quote w3m-session-select) "w3m-session" "\
Select session from session list.

\(fn)" t nil)

(autoload (quote w3m-setup-session-menu) "w3m-session" "\
Setup w3m session items in menubar.

\(fn)" nil nil)

;;;***

;;;### (autoloads (w3m-replace-symbol) "w3m-symbol" "../package.d/w3m-el/w3m-symbol.el"
;;;;;;  (18846 37976))
;;; Generated autoloads from ../package.d/w3m-el/w3m-symbol.el

(autoload (quote w3m-replace-symbol) "w3m-symbol" "\
Not documented

\(fn)" nil nil)

;;;***

;;;### (autoloads (w3m-about-weather w3m-weather) "w3m-weather" "../package.d/w3m-el/w3m-weather.el"
;;;;;;  (18846 37976))
;;; Generated autoloads from ../package.d/w3m-el/w3m-weather.el

(autoload (quote w3m-weather) "w3m-weather" "\
Display weather report.

\(fn AREA)" t nil)

(autoload (quote w3m-about-weather) "w3m-weather" "\
Not documented

\(fn URL NO-DECODE NO-CACHE POST-DATA REFERER HANDLER)" nil nil)

;;;***

;;;### (autoloads nil nil ("../package.d/bbdb/bits/bbdb-filters/bbdb-ccmail.el"
;;;;;;  "../package.d/bbdb/bits/bbdb-filters/bbdb-eudora.el" "../package.d/bbdb/bits/bbdb-filters/bbdb-export.el"
;;;;;;  "../package.d/bbdb/bits/bbdb-filters/bbdb-hp200lx.el" "../package.d/bbdb/bits/bbdb-filters/bbdb-passwd.el"
;;;;;;  "../package.d/bbdb/bits/bbdb-filters/bbdb-ph.el" "../package.d/bbdb/bits/bbdb-ldif.el"
;;;;;;  "../package.d/bbdb/bits/bbdb-mail-folders.el" "../package.d/bbdb/bits/bbdb-signature.el"
;;;;;;  "../package.d/bbdb/bits/bbdb-sort-mailrc.el" "../package.d/bbdb/bits/bbdb-to-outlook.el"
;;;;;;  "../package.d/bbdb/lisp/bbdb-autoloads.el" "../package.d/bbdb/misc/bbdb-unmigrate-stuff.el"
;;;;;;  "../package.d/bbdb/testing/run-tests.el" "../package.d/bbdb/texinfo/infohack.el"
;;;;;;  "../package.d/bbdb/utils/bbdb-213-310.el" "../package.d/bbdb/utils/bbdb-415-510.el"
;;;;;;  "../package.d/bbdb/utils/bbdb-to-netscape.el" "../package.d/dwa-c++.el"
;;;;;;  "../package.d/dwa-rectangle.el" "../package.d/dwa-util.el"
;;;;;;  "../package.d/initsplit.el" "../package.d/mailcrypt/mailcrypt.el"
;;;;;;  "../package.d/mailcrypt/mc-gpg.el" "../package.d/mailcrypt/mc-pgp.el"
;;;;;;  "../package.d/mailcrypt/mc-pgp5.el" "../package.d/mailcrypt/mc-remail.el"
;;;;;;  "../package.d/mailcrypt/mc-setversion.el" "../package.d/mailcrypt/mc-toplev.el"
;;;;;;  "../package.d/mailcrypt/tests/remailer/test-remailer.el"
;;;;;;  "../package.d/mailcrypt/tests/remailer/test-remailer2.el"
;;;;;;  "../package.d/mailcrypt/tests/test-gpg.el" "../package.d/maxframe.el"
;;;;;;  "../package.d/timeclock-x.el" "../package.d/w3m-el/attic/addpath.el"
;;;;;;  "../package.d/w3m-el/attic/rfc2368.el" "../package.d/w3m-el/doc/ptexinfmt.el"
;;;;;;  "../package.d/w3m-el/mew-w3m.el" "../package.d/w3m-el/shimbun/sb-2ch.el"
;;;;;;  "../package.d/w3m-el/shimbun/sb-airs.el" "../package.d/w3m-el/shimbun/sb-aljazeera.el"
;;;;;;  "../package.d/w3m-el/shimbun/sb-arch-bluegate.el" "../package.d/w3m-el/shimbun/sb-asahi-html.el"
;;;;;;  "../package.d/w3m-el/shimbun/sb-asahi-mytown.el" "../package.d/w3m-el/shimbun/sb-asahi.el"
;;;;;;  "../package.d/w3m-el/shimbun/sb-atmarkit.el" "../package.d/w3m-el/shimbun/sb-atom-hash.el"
;;;;;;  "../package.d/w3m-el/shimbun/sb-atom.el" "../package.d/w3m-el/shimbun/sb-bbc.el"
;;;;;;  "../package.d/w3m-el/shimbun/sb-bbdb-ml.el" "../package.d/w3m-el/shimbun/sb-cgi-board.el"
;;;;;;  "../package.d/w3m-el/shimbun/sb-cnet-jp.el" "../package.d/w3m-el/shimbun/sb-cnet.el"
;;;;;;  "../package.d/w3m-el/shimbun/sb-cnn-jp.el" "../package.d/w3m-el/shimbun/sb-coldsync.el"
;;;;;;  "../package.d/w3m-el/shimbun/sb-debian-jp.el" "../package.d/w3m-el/shimbun/sb-debian.el"
;;;;;;  "../package.d/w3m-el/shimbun/sb-debugmagazin-de.el" "../package.d/w3m-el/shimbun/sb-dennou.el"
;;;;;;  "../package.d/w3m-el/shimbun/sb-digiko.el" "../package.d/w3m-el/shimbun/sb-elips.el"
;;;;;;  "../package.d/w3m-el/shimbun/sb-emacs-w3m.el" "../package.d/w3m-el/shimbun/sb-emacswiki.el"
;;;;;;  "../package.d/w3m-el/shimbun/sb-engadget-ja.el" "../package.d/w3m-el/shimbun/sb-excite.el"
;;;;;;  "../package.d/w3m-el/shimbun/sb-exconn.el" "../package.d/w3m-el/shimbun/sb-f1fan.el"
;;;;;;  "../package.d/w3m-el/shimbun/sb-fau.el" "../package.d/w3m-el/shimbun/sb-ffii.el"
;;;;;;  "../package.d/w3m-el/shimbun/sb-fml.el" "../package.d/w3m-el/shimbun/sb-gendai-net.el"
;;;;;;  "../package.d/w3m-el/shimbun/sb-geocrawler.el" "../package.d/w3m-el/shimbun/sb-glimpse.el"
;;;;;;  "../package.d/w3m-el/shimbun/sb-gnome.el" "../package.d/w3m-el/shimbun/sb-haiku-os.el"
;;;;;;  "../package.d/w3m-el/shimbun/sb-hash.el" "../package.d/w3m-el/shimbun/sb-heise.el"
;;;;;;  "../package.d/w3m-el/shimbun/sb-hns.el" "../package.d/w3m-el/shimbun/sb-ibm-dev.el"
;;;;;;  "../package.d/w3m-el/shimbun/sb-impress.el" "../package.d/w3m-el/shimbun/sb-infoshop.el"
;;;;;;  "../package.d/w3m-el/shimbun/sb-itmedia.el" "../package.d/w3m-el/shimbun/sb-japantimes.el"
;;;;;;  "../package.d/w3m-el/shimbun/sb-javaconf.el" "../package.d/w3m-el/shimbun/sb-jpilot.el"
;;;;;;  "../package.d/w3m-el/shimbun/sb-jpo.el" "../package.d/w3m-el/shimbun/sb-kantei.el"
;;;;;;  "../package.d/w3m-el/shimbun/sb-kde.el" "../package.d/w3m-el/shimbun/sb-laut-de.el"
;;;;;;  "../package.d/w3m-el/shimbun/sb-linuxce-jp.el" "../package.d/w3m-el/shimbun/sb-lotusex.el"
;;;;;;  "../package.d/w3m-el/shimbun/sb-lump.el" "../package.d/w3m-el/shimbun/sb-m17n.el"
;;;;;;  "../package.d/w3m-el/shimbun/sb-macosx-jp.el" "../package.d/w3m-el/shimbun/sb-mailarc.el"
;;;;;;  "../package.d/w3m-el/shimbun/sb-mailman.el" "../package.d/w3m-el/shimbun/sb-mainichi.el"
;;;;;;  "../package.d/w3m-el/shimbun/sb-makanai.el" "../package.d/w3m-el/shimbun/sb-marc-aims.el"
;;;;;;  "../package.d/w3m-el/shimbun/sb-meadow.el" "../package.d/w3m-el/shimbun/sb-mew.el"
;;;;;;  "../package.d/w3m-el/shimbun/sb-mhonarc.el" "../package.d/w3m-el/shimbun/sb-mozilla-jp.el"
;;;;;;  "../package.d/w3m-el/shimbun/sb-msdn.el" "../package.d/w3m-el/shimbun/sb-msports-nifty.el"
;;;;;;  "../package.d/w3m-el/shimbun/sb-multi.el" "../package.d/w3m-el/shimbun/sb-n24-de.el"
;;;;;;  "../package.d/w3m-el/shimbun/sb-namazu.el" "../package.d/w3m-el/shimbun/sb-netbsd.el"
;;;;;;  "../package.d/w3m-el/shimbun/sb-nikkansports.el" "../package.d/w3m-el/shimbun/sb-nikkei.el"
;;;;;;  "../package.d/w3m-el/shimbun/sb-nytimes.el" "../package.d/w3m-el/shimbun/sb-opentechpress-jp.el"
;;;;;;  "../package.d/w3m-el/shimbun/sb-orca.el" "../package.d/w3m-el/shimbun/sb-palmfan.el"
;;;;;;  "../package.d/w3m-el/shimbun/sb-pcweb-column.el" "../package.d/w3m-el/shimbun/sb-perlentaucher-de.el"
;;;;;;  "../package.d/w3m-el/shimbun/sb-pilot-link.el" "../package.d/w3m-el/shimbun/sb-pilot-mailsync.el"
;;;;;;  "../package.d/w3m-el/shimbun/sb-plucker.el" "../package.d/w3m-el/shimbun/sb-pocketgames.el"
;;;;;;  "../package.d/w3m-el/shimbun/sb-rakuten.el" "../package.d/w3m-el/shimbun/sb-redhat.el"
;;;;;;  "../package.d/w3m-el/shimbun/sb-rediff.el" "../package.d/w3m-el/shimbun/sb-rss-blogs.el"
;;;;;;  "../package.d/w3m-el/shimbun/sb-rss-hash.el" "../package.d/w3m-el/shimbun/sb-rss.el"
;;;;;;  "../package.d/w3m-el/shimbun/sb-ruby.el" "../package.d/w3m-el/shimbun/sb-sankei.el"
;;;;;;  "../package.d/w3m-el/shimbun/sb-savannah.el" "../package.d/w3m-el/shimbun/sb-scipy.el"
;;;;;;  "../package.d/w3m-el/shimbun/sb-security-memo.el" "../package.d/w3m-el/shimbun/sb-slashdot-jp.el"
;;;;;;  "../package.d/w3m-el/shimbun/sb-slashdot.el" "../package.d/w3m-el/shimbun/sb-sml.el"
;;;;;;  "../package.d/w3m-el/shimbun/sb-sourceforge-jp.el" "../package.d/w3m-el/shimbun/sb-spiegel.el"
;;;;;;  "../package.d/w3m-el/shimbun/sb-sponichi.el" "../package.d/w3m-el/shimbun/sb-squeak-dev.el"
;;;;;;  "../package.d/w3m-el/shimbun/sb-squeak-ja.el" "../package.d/w3m-el/shimbun/sb-sueddeutsche-de.el"
;;;;;;  "../package.d/w3m-el/shimbun/sb-tcup.el" "../package.d/w3m-el/shimbun/sb-tdiary-ml.el"
;;;;;;  "../package.d/w3m-el/shimbun/sb-tdiary.el" "../package.d/w3m-el/shimbun/sb-tech-on.el"
;;;;;;  "../package.d/w3m-el/shimbun/sb-texfaq.el" "../package.d/w3m-el/shimbun/sb-text.el"
;;;;;;  "../package.d/w3m-el/shimbun/sb-the-onion.el" "../package.d/w3m-el/shimbun/sb-the-register.el"
;;;;;;  "../package.d/w3m-el/shimbun/sb-tigris.el" "../package.d/w3m-el/shimbun/sb-toshiba.el"
;;;;;;  "../package.d/w3m-el/shimbun/sb-vinelinux.el" "../package.d/w3m-el/shimbun/sb-w3m-dev.el"
;;;;;;  "../package.d/w3m-el/shimbun/sb-welt-de.el" "../package.d/w3m-el/shimbun/sb-wiki.el"
;;;;;;  "../package.d/w3m-el/shimbun/sb-wikimedia.el" "../package.d/w3m-el/shimbun/sb-wincefan.el"
;;;;;;  "../package.d/w3m-el/shimbun/sb-wired-jp.el" "../package.d/w3m-el/shimbun/sb-x51.el"
;;;;;;  "../package.d/w3m-el/shimbun/sb-xemacs.el" "../package.d/w3m-el/shimbun/sb-yahoo-auctions.el"
;;;;;;  "../package.d/w3m-el/shimbun/sb-yahoo-sports.el" "../package.d/w3m-el/shimbun/sb-yahoo.el"
;;;;;;  "../package.d/w3m-el/shimbun/sb-yomiuri-html.el" "../package.d/w3m-el/shimbun/sb-yomiuri.el"
;;;;;;  "../package.d/w3m-el/shimbun/sb-zdnet-jp.el" "../package.d/w3m-el/shimbun/sb-zeit-de.el"
;;;;;;  "../package.d/w3m-el/shimbun/shimbun.el" "../package.d/w3m-el/w3m-bug.el"
;;;;;;  "../package.d/w3m-el/w3m-ccl.el" "../package.d/w3m-el/w3m-ems.el"
;;;;;;  "../package.d/w3m-el/w3m-favicon.el" "../package.d/w3m-el/w3m-hist.el"
;;;;;;  "../package.d/w3m-el/w3m-image.el" "../package.d/w3m-el/w3m-load.el"
;;;;;;  "../package.d/w3m-el/w3m-mail.el" "../package.d/w3m-el/w3m-proc.el"
;;;;;;  "../package.d/w3m-el/w3m-rss.el" "../package.d/w3m-el/w3m-tabmenu.el"
;;;;;;  "../package.d/w3m-el/w3m-ucs.el" "../package.d/w3m-el/w3m-util.el"
;;;;;;  "../package.d/w3m-el/w3m-xmas.el" "../package.d/w3m-el/w3mhack.el")
;;;;;;  (18847 2665 627050))

;;;***

(provide 'my-loaddefs)
;; Local Variables:
;; version-control: never
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; my-loaddefs.el ends here
