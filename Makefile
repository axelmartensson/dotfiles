# USAGE
# for a freshly checked out repo, don't forget to run
# git submodule update --init --recursive
# TODO this command is idempotent, so it could maybe be run on every 
# invocation of make
# grep submodule .git/config || git submodule update --init

ifneq ($(CURDIR),$(HOME))

.SUFFIXES:

.PHONY: switch-tree
switch-tree:
	$(MAKE) -C $(HOME) -f $(CURDIR)/Makefile SRCDIR=$(CURDIR) $(MAKECMDGOALS)
test:
	time sudo docker run -v $(CURDIR):/dotfiles ubuntu /bin/bash -c "apt update;apt install -y sudo;$$(cat init)" init file:///dotfiles '.dotfiles'
# use 
# sudo docker system prune
# to free up space if running out of disk
else

DOTFILES_MANIFEST := $(SRCDIR)/DOTFILES-MANIFEST

DOTFILES := $(shell cat $(DOTFILES_MANIFEST))

all: $(DOTFILES) .xsession .fzf/bin/fzf ripgrep fd entr gcc python3 curl urxvt tmux vim lynx mutt xmonad conky dzen2 dmenu ycm gpg code xkbset

$(DOTFILES):
	[ ! -h $(CURDIR)/$@ ] &&\
	[ -e $(CURDIR)/$@ ] &&\
		mv $(CURDIR)/$@ $(CURDIR)/$@.bak \
	|| true
	ln -s $(SRCDIR)/$@ $(CURDIR)/$@


deps.d: $(DOTFILES_MANIFEST)
	if [ -f $@ ]; then rm $@; fi
	for dotfile in $(DOTFILES); do echo "$${dotfile}: $(SRCDIR)/$${dotfile}" >> $@; done

include deps.d

.xsession: .xinitrc
	ln -s $< $@

.fzf/bin/fzf: | curl
	git clone --depth 1 https://github.com/junegunn/fzf.git .fzf
	cd .fzf/ && ./install

.PHONY: ripgrep
ripgrep: | curl
	command -v rg >/dev/null \
		|| ([ "$$(uname -sm)" = "Linux x86_64" ] && curl -LO https://github.com/BurntSushi/ripgrep/releases/download/11.0.1/ripgrep_11.0.1_amd64.deb && sudo dpkg -i ripgrep_11.0.1_amd64.deb )\
		|| (([ "$$(uname -sm)" = "MINGW x86_64" ] || [ "$$(uname -sm)" = "MSYS x86_64" ]) && \
			curl https://raw.githubusercontent.com/BurntSushi/ripgrep/releases/download/11.0.1/ripgrep-11.0.1-x86_64-pc-windows-msvc.zip -o ripgrep-11.0.1-x86_64-pc-windows-msvc.zip && \
			mkdir -p bin && unzip ripgrep-11.0.1-x86_64-pc-windows-msvc.zip -d bin)

.PHONY: fd
fd: | curl
	command -v fd >/dev/null \
		|| ([ "$$(uname -sm)" = "Linux x86_64" ] && curl -LO https://github.com/sharkdp/fd/releases/download/v7.3.0/fd_7.3.0_amd64.deb && sudo dpkg -i fd_7.3.0_amd64.deb )\
		|| (([ "$$(uname -sm)" = "MINGW x86_64" ] || [ "$$(uname -sm)" = "MSYS x86_64" ]) && \
			curl -LO https://github.com/sharkdp/fd/releases/download/v7.3.0/fd-v7.3.0-x86_64-pc-windows-msvc.zip && \
			mkdir -p bin && unzip fd-v7.3.0-x86_64-pc-windows-msvc.zip -d bin)

.PHONY: entr
entr: gcc
	command -v entr >/dev/null \
		|| ([ "$$(uname -sm)" = "Linux x86_64" ] &&\
			([ -d entr ] || git clone https://github.com/eradman/entr entr) &&\
			cd entr && ./configure && make test && sudo make install )\
		|| (([ "$$(uname -sm)" = "MINGW x86_64" ] || [ "$$(uname -sm)" = "MSYS x86_64" ]))

.PHONY: gcc
gcc:
	command -v gcc >/dev/null \
		|| ([ "$$(uname -sm)" = "Linux x86_64" ] &&\
			sudo apt install -y gcc)\
		|| (([ "$$(uname -sm)" = "MINGW x86_64" ] || [ "$$(uname -sm)" = "MSYS x86_64" ]))

.PHONY: curl
curl:
	command -v curl >/dev/null \
		|| ([ "$$(uname -sm)" = "Linux x86_64" ] &&\
			sudo apt install -y curl)\
		|| (([ "$$(uname -sm)" = "MINGW x86_64" ] || [ "$$(uname -sm)" = "MSYS x86_64" ]))

.PHONY: python3
python3:
	command -v python3 >/dev/null \
		|| ([ "$$(uname -sm)" = "Linux x86_64" ] &&\
			sudo apt install -y python3)\
		|| (([ "$$(uname -sm)" = "MINGW x86_64" ] || [ "$$(uname -sm)" = "MSYS x86_64" ]))

.PHONY: python3-dev
python3-dev:
	false \
		|| ([ "$$(uname -sm)" = "Linux x86_64" ] &&\
		([ "$$(dpkg-query -W -f='$${db:Status-Status}' python3)" = "installed" ] ||\
			sudo apt install -y python3-dev))\
		|| (([ "$$(uname -sm)" = "MINGW x86_64" ] || [ "$$(uname -sm)" = "MSYS x86_64" ]))
 
.PHONY: urxvt
urxvt:
	command -v urxvt >/dev/null \
		|| ([ "$$(uname -sm)" = "Linux x86_64" ] &&\
			sudo apt install -y rxvt-unicode)\
		|| (([ "$$(uname -sm)" = "MINGW x86_64" ] || [ "$$(uname -sm)" = "MSYS x86_64" ]))

.PHONY: tmux
tmux:
	command -v tmux >/dev/null \
		|| ([ "$$(uname -sm)" = "Linux x86_64" ] &&\
			sudo apt install -y tmux)\
		|| (([ "$$(uname -sm)" = "MINGW x86_64" ] || [ "$$(uname -sm)" = "MSYS x86_64" ]))

.PHONY: vim
vim:
	command -v vim >/dev/null \
		|| ([ "$$(uname -sm)" = "Linux x86_64" ] &&\
			sudo apt install -y vim)\
		|| (([ "$$(uname -sm)" = "MINGW x86_64" ] || [ "$$(uname -sm)" = "MSYS x86_64" ]))

.PHONY: lynx
lynx:
	command -v lynx >/dev/null \
		|| ([ "$$(uname -sm)" = "Linux x86_64" ] &&\
			sudo apt install -y lynx)\
		|| (([ "$$(uname -sm)" = "MINGW x86_64" ] || [ "$$(uname -sm)" = "MSYS x86_64" ]))

.PHONY: mutt
mutt:
	command -v mutt >/dev/null \
		|| ([ "$$(uname -sm)" = "Linux x86_64" ] &&\
			sudo apt install -y mutt)\
		|| (([ "$$(uname -sm)" = "MINGW x86_64" ] || [ "$$(uname -sm)" = "MSYS x86_64" ]))

.PHONY: xmonad
xmonad:
	command -v xmonad >/dev/null \
		|| ([ "$$(uname -sm)" = "Linux x86_64" ] &&\
			sudo apt install -y xmonad)\
		|| (([ "$$(uname -sm)" = "MINGW x86_64" ] || [ "$$(uname -sm)" = "MSYS x86_64" ]))

.PHONY: conky
conky:
	command -v conky >/dev/null \
		|| ([ "$$(uname -sm)" = "Linux x86_64" ] &&\
			sudo apt install -y conky-cli)\
		|| (([ "$$(uname -sm)" = "MINGW x86_64" ] || [ "$$(uname -sm)" = "MSYS x86_64" ]))

.PHONY: dzen2
dzen2:
	command -v dzen2 >/dev/null \
		|| ([ "$$(uname -sm)" = "Linux x86_64" ] &&\
			sudo apt install -y dzen2)\
		|| (([ "$$(uname -sm)" = "MINGW x86_64" ] || [ "$$(uname -sm)" = "MSYS x86_64" ]))

.PHONY: dmenu
dmenu:
	command -v dmenu >/dev/null \
		|| ([ "$$(uname -sm)" = "Linux x86_64" ] &&\
			sudo apt install -y suckless-tools)\
		|| (([ "$$(uname -sm)" = "MINGW x86_64" ] || [ "$$(uname -sm)" = "MSYS x86_64" ]))

.PHONY: ycm
ycm: .vim/bundle/YouCompleteMe/third_party/ycmd/ycm_core.so

.vim/bundle/YouCompleteMe/third_party/ycmd/ycm_core.so: $(SRCDIR)/get-ycm | python3 python3-dev cmake
	$(SRCDIR)/get-ycm

.PHONY: cmake
cmake:
	command -v cmake >/dev/null \
		|| ([ "$$(uname -sm)" = "Linux x86_64" ] &&\
			sudo apt install -y cmake)\
		|| (([ "$$(uname -sm)" = "MINGW x86_64" ] || [ "$$(uname -sm)" = "MSYS x86_64" ]))

.PHONY: code
code: $(SRCDIR)/get-code | gpg
	command -v code >/dev/null \
		|| ([ "$$(uname -sm)" = "Linux x86_64" ] &&\
			$(SRCDIR)/get-code)\
		|| (([ "$$(uname -sm)" = "MINGW x86_64" ] || [ "$$(uname -sm)" = "MSYS x86_64" ]))
	# for turning of telemetry see https://code.visualstudio.com/docs/supporting/faq#_how-to-disable-telemetry-reporting
	# extensions:
	# generated by: ls ~/.vscode/extensions
	# ms-python.python-2020.7.96456
	# ms-vscode.cpptools-0.29.0
	# redhat.java-0.65.0
	# vscjava.vscode-java-debug-0.27.1
	# vscodevim.vim-1.16.0

.PHONY: gpg
gpg:
	command -v gpg >/dev/null \
		|| ([ "$$(uname -sm)" = "Linux x86_64" ] &&\
			sudo apt install -y gpg)\
		|| (([ "$$(uname -sm)" = "MINGW x86_64" ] || [ "$$(uname -sm)" = "MSYS x86_64" ]))

.PHONY: xkbset
xkbset:
	command -v xkbset >/dev/null \
		|| ([ "$$(uname -sm)" = "Linux x86_64" ] &&\
			sudo apt install -y xkbset)\
		|| (([ "$$(uname -sm)" = "MINGW x86_64" ] || [ "$$(uname -sm)" = "MSYS x86_64" ]))

endif

