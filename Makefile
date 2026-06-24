KOREADER_DIR ?= $(HOME)/github/koreader/koreader
PLUGIN_LINK   := $(KOREADER_DIR)/plugins/calibreplus.koplugin
SPEC_LINK     := $(KOREADER_DIR)/spec/unit/calibreplus_db_spec.lua

# macOS: Homebrew GNU tools must precede system tools.
# Install prerequisites: brew install gnu-getopt make util-linux bash findutils
ifeq ($(shell uname),Darwin)
export PATH := /opt/homebrew/opt/gnu-getopt/bin:/opt/homebrew/opt/make/libexec/gnubin:/opt/homebrew/opt/util-linux/bin:/opt/homebrew/bin:$(PATH)
SHELL := /opt/homebrew/bin/bash
endif

.PHONY: install uninstall test

install:
	ln -sfn "$(CURDIR)" "$(PLUGIN_LINK)"
	ln -sfn "$(CURDIR)/spec/calibreplus_db_spec.lua" "$(SPEC_LINK)"

uninstall:
	rm -f "$(PLUGIN_LINK)" "$(SPEC_LINK)"

# Requires a built KOReader emulator in KOREADER_DIR.
# First-time setup: cd $(KOREADER_DIR) && ./kodev fetch-thirdparty && ./kodev build
test: install
	@KODIR=$$(find "$(KOREADER_DIR)" -maxdepth 3 -name "koreader.sh" -path "*/koreader-emulator-*" -exec dirname {} \; 2>/dev/null | head -1); \
	if [ -z "$$KODIR" ]; then \
	  echo "ERROR: emulator not built. Run: cd $(KOREADER_DIR) && ./kodev build"; exit 1; \
	fi; \
	cd "$$KODIR" && spec/runtests front calibreplus_db
