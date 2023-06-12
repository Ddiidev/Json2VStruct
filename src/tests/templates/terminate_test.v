module templates

import os

// Run all tests that are generated from the templates
fn test_all_tests_generated() {
	result := os.execute('v -stats test src/tests/scripts_gen')

	println(result.output)

	assert result.exit_code == 0
}
