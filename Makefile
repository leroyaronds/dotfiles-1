
.PHONY: all
all: home

.PHONY: home
home:
	echo "Deploying dotfiles to ${HOME}";
	for f in $(shell find "${CURDIR}" -maxdepth 1 -type f -name ".*" -not -name "*.swp"); do \
		fname=$$(basename "$$f"); \
		ln -sn "$$f" "${HOME}/${fname}"; \
	done;
	ln -sn $(shell pwd)/.config ${HOME}/.config
