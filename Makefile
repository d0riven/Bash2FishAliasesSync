_B2F_ALIASES_FILE := $(HOME)/.config/fish/b2f_aliases.fish
_B2F_BASHRC := $(HOME)/.bashrc

show_fixture:
	@echo "_B2F_ALIASES_FILE: $(_B2F_ALIASES_FILE)"
	@echo "_B2F_BASHRC: $(_B2F_BASHRC)"

sync: $(_B2F_ALIASES_FILE)

$(_B2F_ALIASES_FILE): $(_B2F_BASHRC)
	_B2F_BASHRC=$(_B2F_BASHRC) bash bash2fish_translator.bash > $@

TEST_DIR := tests
test_input := $(TEST_DIR)/input.txt
test_result := $(TEST_DIR)/result.txt
test_expected := $(TEST_DIR)/expected.txt

test: $(test_result)
	diff $(test_expected) $(test_result)

.PHONY: $(test_result)
$(test_result): bash2fish_translator.bash $(test_input)
	cat $(test_input) > bash bash2fish_translator.bash > $@
