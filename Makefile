TEST_DIR := tests
test_input := $(TEST_DIR)/input.txt
test_result := $(TEST_DIR)/result.txt
test_expected := $(TEST_DIR)/expected.txt

test: $(test_result)
	diff $(test_expected) $(test_result)

.PHONY: $(test_result)
$(test_result): aliases_sync.bash $(test_input)
	_B2F_ALIASES_FILE=$(test_result) _B2F_BASH_PROFILE=$(test_input) bash aliases_sync.bash
