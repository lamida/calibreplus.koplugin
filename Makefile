KOREADER_DIR ?= $(HOME)/github/koreader/koreader
PLUGIN_LINK   := $(KOREADER_DIR)/plugins/calibreplus.koplugin
SPEC_LINK     := $(KOREADER_DIR)/spec/unit/calibreplus_db_spec.lua

.PHONY: install uninstall test

install:
	ln -sfn "$(CURDIR)" "$(PLUGIN_LINK)"
	ln -sfn "$(CURDIR)/spec/calibreplus_db_spec.lua" "$(SPEC_LINK)"

uninstall:
	rm -f "$(PLUGIN_LINK)" "$(SPEC_LINK)"

test: install
	cd "$(KOREADER_DIR)" && ./kodev test front calibreplus_db_spec.lua
