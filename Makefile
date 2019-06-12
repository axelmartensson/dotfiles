
ifneq ($(CURDIR),$(HOME))

.SUFFIXES:

PHONY+=switch-tree
switch-tree:
	$(MAKE) -C $(HOME) -f $(CURDIR)/Makefile SRCDIR=$(CURDIR) $(MAKECMDGOALS)
else

DOTFILES_MANIFEST := $(SRCDIR)/DOTFILES-MANIFEST

DOTFILES := $(shell cat $(DOTFILES_MANIFEST))

all: $(DOTFILES) .fzf/install

$(DOTFILES):
	ln -s $(SRCDIR)/$@ $(CURDIR)/$@


deps.d: $(DOTFILES_MANIFEST)
	if [ -f $@ ]; then rm $@; fi
	for dotfile in $(DOTFILES); do echo "$${dotfile}: $(SRCDIR)/$${dotfile}" >> $@; done

include deps.d

.fzf/bin/fzf:
	git clone --depth 1 https://github.com/junegunn/fzf.git .fzf
	cd .fzf/ && ./install

endif
