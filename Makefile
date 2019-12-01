
ifneq ($(CURDIR),$(HOME))

.SUFFIXES:

PHONY+=switch-tree
switch-tree:
	$(MAKE) -C $(HOME) -f $(CURDIR)/Makefile SRCDIR=$(CURDIR) $(MAKECMDGOALS)
else

DOTFILES_MANIFEST := $(SRCDIR)/DOTFILES-MANIFEST

DOTFILES := $(shell cat $(DOTFILES_MANIFEST))

all: $(DOTFILES) .fzf/bin/fzf ripgrep fd entr urxvt tmux lynx mutt xmonad conky dzen2 dmenu ycm

$(DOTFILES):
	ln -s $(SRCDIR)/$@ $(CURDIR)/$@


deps.d: $(DOTFILES_MANIFEST)
	if [ -f $@ ]; then rm $@; fi
	for dotfile in $(DOTFILES); do echo "$${dotfile}: $(SRCDIR)/$${dotfile}" >> $@; done

include deps.d

.fzf/bin/fzf:
	git clone --depth 1 https://github.com/junegunn/fzf.git .fzf
	cd .fzf/ && ./install

.PHONY: ripgrep
ripgrep:
	command -v rg >/dev/null \
		|| ([ "$$(uname -sm)" = "Linux x86_64" ] && curl -LO https://github.com/BurntSushi/ripgrep/releases/download/11.0.1/ripgrep_11.0.1_amd64.deb && sudo dpkg -i ripgrep_11.0.1_amd64.deb )\
		|| (([ "$$(uname -sm)" = "MINGW x86_64" ] || [ "$$(uname -sm)" = "MSYS x86_64" ]) && \
			curl https://raw.githubusercontent.com/BurntSushi/ripgrep/releases/download/11.0.1/ripgrep-11.0.1-x86_64-pc-windows-msvc.zip -o ripgrep-11.0.1-x86_64-pc-windows-msvc.zip && \
			mkdir -p bin && unzip ripgrep-11.0.1-x86_64-pc-windows-msvc.zip -d bin)

.PHONY: fd
fd:
	command -v fd >/dev/null \
		|| ([ "$$(uname -sm)" = "Linux x86_64" ] && curl -LO https://github.com/sharkdp/fd/releases/download/v7.3.0/fd_7.3.0_amd64.deb && sudo dpkg -i fd_7.3.0_amd64.deb )\
		|| (([ "$$(uname -sm)" = "MINGW x86_64" ] || [ "$$(uname -sm)" = "MSYS x86_64" ]) && \
			curl -LO https://github.com/sharkdp/fd/releases/download/v7.3.0/fd-v7.3.0-x86_64-pc-windows-msvc.zip && \
			mkdir -p bin && unzip fd-v7.3.0-x86_64-pc-windows-msvc.zip -d bin)

.PHONY: entr
entr:
	command -v entr >/dev/null \
		|| ([ "$$(uname -sm)" = "Linux x86_64" ] &&\
			([ -d entr ] || git clone https://github.com/eradman/entr entr) &&\
			cd entr && ./configure && make test && sudo make install )\
		|| (([ "$$(uname -sm)" = "MINGW x86_64" ] || [ "$$(uname -sm)" = "MSYS x86_64" ]))

.PHONY: urxvt
urxvt:
	command -v urxvt >/dev/null \
		|| ([ "$$(uname -sm)" = "Linux x86_64" ] &&\
			sudo apt install rxvt-unicode)\
		|| (([ "$$(uname -sm)" = "MINGW x86_64" ] || [ "$$(uname -sm)" = "MSYS x86_64" ]))

.PHONY: tmux
tmux:
	command -v tmux >/dev/null \
		|| ([ "$$(uname -sm)" = "Linux x86_64" ] &&\
			sudo apt install tmux)\
		|| (([ "$$(uname -sm)" = "MINGW x86_64" ] || [ "$$(uname -sm)" = "MSYS x86_64" ]))

.PHONY: lynx
lynx:
	command -v lynx >/dev/null \
		|| ([ "$$(uname -sm)" = "Linux x86_64" ] &&\
			sudo apt install lynx)\
		|| (([ "$$(uname -sm)" = "MINGW x86_64" ] || [ "$$(uname -sm)" = "MSYS x86_64" ]))

.PHONY: mutt
mutt:
	command -v mutt >/dev/null \
		|| ([ "$$(uname -sm)" = "Linux x86_64" ] &&\
			sudo apt install mutt)\
		|| (([ "$$(uname -sm)" = "MINGW x86_64" ] || [ "$$(uname -sm)" = "MSYS x86_64" ]))

.PHONY: xmonad
xmonad:
	command -v xmonad >/dev/null \
		|| ([ "$$(uname -sm)" = "Linux x86_64" ] &&\
			sudo apt install xmonad)\
		|| (([ "$$(uname -sm)" = "MINGW x86_64" ] || [ "$$(uname -sm)" = "MSYS x86_64" ]))

.PHONY: conky
conky:
	command -v conky >/dev/null \
		|| ([ "$$(uname -sm)" = "Linux x86_64" ] &&\
			sudo apt install conky-cli)\
		|| (([ "$$(uname -sm)" = "MINGW x86_64" ] || [ "$$(uname -sm)" = "MSYS x86_64" ]))

.PHONY: dzen2
dzen2:
	command -v dzen2 >/dev/null \
		|| ([ "$$(uname -sm)" = "Linux x86_64" ] &&\
			sudo apt install dzen2)\
		|| (([ "$$(uname -sm)" = "MINGW x86_64" ] || [ "$$(uname -sm)" = "MSYS x86_64" ]))

.PHONY: dmenu
dmenu:
	command -v dmenu >/dev/null \
		|| ([ "$$(uname -sm)" = "Linux x86_64" ] &&\
			sudo apt install suckless-tools)\
		|| (([ "$$(uname -sm)" = "MINGW x86_64" ] || [ "$$(uname -sm)" = "MSYS x86_64" ]))

.PHONY: ycm
ycm: .vim/bundle/YouCompleteMe/third_party/ycmd/ycm_core.so

.vim/bundle/YouCompleteMe/third_party/ycmd/ycm_core.so: $(SRCDIR)/get-ycm
	$(SRCDIR)/get-ycm

endif

