module tests

import parsers
import entities.configuration { Config }
import contracts

const s_toml = r'
name = "André"
age = 25
is_people = true
height = 1.75
'

fn test_simple_keys() {
	builded_struct := parsers.parser_build_struct(tests.s_toml, Config{
		struct_anon: false
		omit_empty: false
		reserved_word_with_underscore: false
		type_parser: .toml
	})!

	assert builded_struct.typ == .object | .root
	assert builded_struct.children.len == 4
	assert builded_struct.children[0].name == 'name'
	assert builded_struct.children[1].name == 'age'
	assert builded_struct.children[1].value == contracts.Any(25)
	assert builded_struct.children[2].name == 'is_people'
	assert builded_struct.children[2].value == contracts.Any(true)
	assert builded_struct.children[3].name == 'height'
	assert builded_struct.children[3].value == contracts.Any(1.75)
}
