.PHONY: clean watch build build-subdirs check-todo clean-subdirs

SUBDIRS := $(sort $(dir $(wildcard */Makefile)))


watch: build-subdirs
	typst watch thesis.typ

build: clean build-subdirs check-todo
	typst compile --pdf-standard=1.7 thesis.typ

build-subdirs:
	@for d in $(SUBDIRS); do \
		$(MAKE) -C $$d; \
	done

check-todo:
	@if grep --binary-files=without-match --recursive --line-number --color=always --ignore-case --perl-regexp "^(?!#import).*?\Ktodo" chapters/ > /tmp/todo_matches.txt 2>/dev/null; then \
		echo "⚠️  Found TODOs in the following files:"; \
		cat /tmp/todo_matches.txt; \
		echo "⚠️  Consider removing these ToDo's before submission ;)"; \
	fi

clean: clean-subdirs
	rm -f thesis.pdf chapters/*.pdf lib/*.pdf

clean-subdirs:
	@for d in $(SUBDIRS); do \
		$(MAKE) -C $$d clean; \
	done
