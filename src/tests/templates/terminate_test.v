module templates

import os

// Run all tests that are generated from the templates
fn test_all_tests_generated() {
	result := os.execute('v -stats test src/tests/scripts_gen')

	println(result.output)

	$if !delete_scriptgen_after_run ? {
		os.rmdir_all('src/tests/scripts_gen') or {
			eprintln('Failed to delete src/tests/scripts_gen')
		}
	}

	assert result.exit_code == 0
}
