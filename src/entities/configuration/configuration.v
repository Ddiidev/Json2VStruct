module configuration

import parsers.type_object { TypeParser }

pub struct Config {
pub:
	struct_anon                   bool
	omit_empty                    bool = true
	reserved_word_with_underscore bool = true
pub mut:
	type_parser TypeParser = .json
}
