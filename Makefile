
ifneq ($(CURDIR),$(HOME))

.SUFFIXES:

.PHONY: switch-tree
switch-tree:
	$(MAKE) -C $(HOME) -f $(CURDIR)/Makefile SRCDIR=$(CURDIR) $(MAKECMDGOALS)
test:
	time sudo docker run -v $(CURDIR):/dotfiles ubuntu /bin/bash -c " /dotfiles/init file:///dotfiles /tmp/dotfiles"
# use 
# sudo docker system prune
# to free up space if running out of disk
else

FORCE := $(shell touch force && echo force)

DOTFILES_MANIFEST := $(SRCDIR)/DOTFILES-MANIFEST

DOTFILES := $(shell cat $(DOTFILES_MANIFEST))

.PHONY: all
all: $(DOTFILES) .xsession .fzf/bin/fzf ripgrep fd entr gcc python3 python3-pip curl xterm tmux vim lynx mutt exuberant-ctags spectrwm conky dzen2 dmenu ycm gpg pass code eclipse .eclipse openjdk xkbset

# only install dotfiles
dotfiles: $(DOTFILES)
.PHONY: dotfiles


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

.PHONY: submodules
submodules:
	grep submodule $(SRCDIR)/.git/config || cd $(SRCDIR) && git submodule update --init --recursive

.xsession: .xinitrc
	ln -s $< $@

.fzf/bin/fzf: | curl
	git clone --depth 1 https://github.com/junegunn/fzf.git .fzf
	cd .fzf/ && ./install

.PHONY: ripgrep
ripgrep: | curl
	command -v rg >/dev/null \
		|| ([ "$$(uname -sm)" = "Linux x86_64" ] && curl -O https://github.com/BurntSushi/ripgrep/releases/download/12.1.1/ripgrep_12.1.1_amd64.deb && sudo dpkg -i ripgrep_12.1.1_amd64.deb )\
		|| (([ "$$(uname -sm)" = "MINGW x86_64" ] || [ "$$(uname -sm)" = "MSYS x86_64" ]) && \
			curl https://raw.githubusercontent.com/BurntSushi/ripgrep/releases/download/12.1.1/ripgrep-12.1.1-x86_64-pc-windows-msvc.zip -o ripgrep-12.1.1-x86_64-pc-windows-msvc.zip && \
			mkdir -p bin && unzip ripgrep-12.1.1-x86_64-pc-windows-msvc.zip -d bin)

.PHONY: fd
fd: | curl
	command -v fd >/dev/null \
		|| ([ "$$(uname -sm)" = "Linux x86_64" ] && curl -O https://github.com/sharkdp/fd/releases/download/v7.3.0/fd_7.3.0_amd64.deb && sudo dpkg -i fd_7.3.0_amd64.deb )\
		|| (([ "$$(uname -sm)" = "MINGW x86_64" ] || [ "$$(uname -sm)" = "MSYS x86_64" ]) && \
			curl -O https://github.com/sharkdp/fd/releases/download/v7.3.0/fd-v7.3.0-x86_64-pc-windows-msvc.zip && \
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

.PHONY: python3-pip
python3-pip:
	command -v pip3 >/dev/null \
		|| ([ "$$(uname -sm)" = "Linux x86_64" ] &&\
			sudo apt install -y python3-pip)\
		|| (([ "$$(uname -sm)" = "MINGW x86_64" ] || [ "$$(uname -sm)" = "MSYS x86_64" ]))

.PHONY: exuberant-ctags
exuberant-ctags:
	command -v ctags-exuberant >/dev/null \
		|| ([ "$$(uname -sm)" = "Linux x86_64" ] &&\
			sudo apt install -y exuberant-ctags)\
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


.PHONY: irssi
irssi:
	command -v irssi >/dev/null \
		|| ([ "$$(uname -sm)" = "Linux x86_64" ] &&\
			git clone https://github.com/irssi/irssi ;\
			cd irssi && ./autogen.sh && ./configure && make && sudo make install ;\
	)\
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

.PHONY: eclipse
eclipse: eclipse/eclipse | openjdk

eclipse/eclipse:
	wget https://ftp.acc.umu.se/mirror/eclipse.org/technology/epp/downloads/release/2020-06/R/eclipse-java-2020-06-R-linux-gtk-x86_64.tar.gz
	tar -xf eclipse-java-2020-06-R-linux-gtk-x86_64.tar.gz

.PHONY: eclim
eclim: eclipse/eclimd
eclipse/eclimd: $(FORCE) eclim/README.rst eclipse/eclipse | vim
	# Fixing https://github.com/ervandew/eclim/issues/432
	#
	# java.lang.RuntimeException: Application 
	# "org.eclim.application" could not be found in the 
	# registry. 
	#
	# by setting eclipse.dest=eclipse instead of .eclipse. This installs eclim straight in the eclipse install folder, not in .eclipse.
	cd eclim && \
		ant \
		-quiet \
		-logger org.apache.tools.ant.NoBannerLogger \
		-Declipse.home=$(HOME)/eclipse \
		-Declipse.dest=$(HOME)/eclipse \
		-Dvim.files=$(HOME)/.vim

eclim/README.rst:
	git clone git://github.com/ervandew/eclim.git
	# Applies PR to fix the StubUtility compile errors
	# https://github.com/ervandew/eclim/pull/602
	git -C eclim pull origin pull/602/head


.PHONY: openjdk
openjdk:
	command -v javac >/dev/null \
		|| ([ "$$(uname -sm)" = "Linux x86_64" ] &&\
			sudo apt install -y openjdk-11-jdk)\
		|| (([ "$$(uname -sm)" = "MINGW x86_64" ] || [ "$$(uname -sm)" = "MSYS x86_64" ]))

.PHONY: gpg
gpg: | pinentry-tty
	command -v gpg >/dev/null \
		|| ([ "$$(uname -sm)" = "Linux x86_64" ] &&\
			sudo apt install -y gpg)\
		|| (([ "$$(uname -sm)" = "MINGW x86_64" ] || [ "$$(uname -sm)" = "MSYS x86_64" ]))

.PHONY: pinentry-tty
pinentry-tty:
	command -v pinentry-tty >/dev/null \
		|| ([ "$$(uname -sm)" = "Linux x86_64" ] &&\
			sudo apt install -y pinentry-tty)\
		|| (([ "$$(uname -sm)" = "MINGW x86_64" ] || [ "$$(uname -sm)" = "MSYS x86_64" ]))

.PHONY: pass
pass:
	command -v pass >/dev/null \
		|| ([ "$$(uname -sm)" = "Linux x86_64" ] &&\
			sudo apt install -y pass)\
		|| (([ "$$(uname -sm)" = "MINGW x86_64" ] || [ "$$(uname -sm)" = "MSYS x86_64" ]))

.PHONY: xkbset
xkbset:
	command -v xkbset >/dev/null \
		|| ([ "$$(uname -sm)" = "Linux x86_64" ] &&\
			sudo apt install -y xkbset)\
		|| (([ "$$(uname -sm)" = "MINGW x86_64" ] || [ "$$(uname -sm)" = "MSYS x86_64" ]))

endif

