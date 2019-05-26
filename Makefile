
ifneq ($(CURDIR),$(HOME))

.SUFFIXES:

PHONY+=switch-tree
switch-tree:
	$(MAKE) -C $(HOME) -f $(CURDIR)/Makefile SRCDIR=$(CURDIR) $(MAKECMDGOALS)
else

DOTFILES_MANIFEST := $(SRCDIR)/DOTFILES-MANIFEST

DOTFILES := $(shell cat $(DOTFILES_MANIFEST))

all: $(DOTFILES)

$(DOTFILES):
	ln -s $(SRCDIR)/$@ $(CURDIR)/$@


deps.d: $(DOTFILES_MANIFEST)
	if [ -f $@ ]; then rm $@; fi
	for dotfile in $(DOTFILES); do echo "$${dotfile}: $(SRCDIR)/$${dotfile}" >> $@; done

include deps.d

endif
