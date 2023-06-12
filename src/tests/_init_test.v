module tests

import os

fn test_01()! {
	if os.exists('src/tests/scripts_gen') {
		os.rmdir_all('src/tests/scripts_gen')!
	}
	os.mkdir('src/tests/scripts_gen')!
}
