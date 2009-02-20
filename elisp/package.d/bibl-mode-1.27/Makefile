# Makefile for building and installing bibliography mode.
#
# Author: Bryan O'Sullivan <bos@serpentine.com>
# Keywords: bibliographies, databases, World Wide Web
# $Revision: 1.9 $
# $Date: 1995/05/27 16:30:24 $
# $Source: /archive/pub/bosullvn/elisp/bibl-mode/RCS/Makefile,v $


# what emacs is called on your system
EMACS = emacs
 
# what to use to make info documentation
TEXINDEX = texindex
TEXINFO = texinfo
TEX = tex

# where the .elc files should go
LISPDIR = /usr/local/lib/emacs/site-lisp/bibl-mode

######## no user serviceable parts beyond this point ########

# other things to know
GZIP = gzip
GZIP_EXT = .gz

# csh ... just say no.

SHELL = /bin/sh

# compile in batch mode, without loading too much user cruft.

EFLAGS = -batch -q

SRCS = bibl-mode.el bibl-lists.el bibl-grab.el

DISTFILES = ChangeLog MANIFEST Makefile NEWS README TODO bibl-grep \
	bibl-mode.texi bibl2html slim-bibl-file $(SRCS)

DISTDIR = /archive/pub/bosullvn/elisp

OBJS = bibl-mode.elc bibl-lists.elc bibl-grab.elc

all: bibl-mode info

info: bibl-mode.texi

manual: bibl-mode.dvi

bibl-mode: $(OBJS)

bibl-mode.elc: bibl-mode.el
	$(EMACS) $(EFLAGS) -f batch-byte-compile bibl-mode.el

bibl-lists.elc: bibl-lists.el bibl-mode.el
	$(EMACS) $(EFLAGS) -f batch-byte-compile bibl-lists.el

bibl-grab.elc: bibl-grab.el bibl-mode.el
	$(EMACS) $(EFLAGS) -f batch-byte-compile bibl-grab.el

bibl-mode.info: bibl-mode.texi
	$(TEXINFO) bibl-mode.texi

bibl-mode.dvi: bibl-mode.texi
	$(TEX) bibl-mode.texi
	$(TEXINDEX) bibl-mode.cp bibl-mode.fn bibl-mode.ky bibl-mode.pg \
		bibl-mode.tp bibl-mode.vr

install: all
	install -c -m 644 $(SRCS) $(OBJS) $(LISPDIR)

tags: TAGS

TAGS: $(SRCS)
	etags $(SRCS)

clean:; -rm -f $(OBJS) bibl-mode.cp bibl-mode.fn bibl-mode.ky bibl-mode.pg \
		bibl-mode.tp bibl-mode.vr bibl-mode.ps bibl-mode.dvi \
		bibl-mode.info bibl-mode.toc bibl-mode.log bibl-mode.aux

dist: bibl-mode-*.tar.gz

bibl-mode-*.tar.gz: $(DISTFILES) $(HOME)/etc/bibliography
	rm -f bibl-mode-*.tar.gz
	echo > .fname \
	  bibl-mode-`sed < bibl-mode.el \
		-e '/Revision:/!d' \
		-e 's/.*Revision: \([0-9.]*\).*/\1/' \
		-e q`
	rm -rf `cat .fname`
	mkdir `cat .fname`
	ln $(DISTFILES) `cat .fname`
	cp $(HOME)/etc/bibliography `cat .fname`
	tar chvf - `cat .fname` | $(GZIP) > "`cat .fname`.tar$(GZIP_EXT)"
	rm -rf `cat .fname` .fname

install-dist: dist
	-mkdir -p $(DISTDIR)/obsolete
	mv $(DISTDIR)/bibl-mode-*.tar.gz $(DISTDIR)/obsolete
	cp bibl-mode-*.tar.gz $(DISTDIR)
	rm -f $(DISTDIR)/bibl-mode.tar.gz
	cd $(DISTDIR) && ln bibl-mode-*.tar.gz bibl-mode.tar.gz
