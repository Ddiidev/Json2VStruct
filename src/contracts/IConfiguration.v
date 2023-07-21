module contracts

import parsers.type_object { TypeParser }

pub interface IConfig {
	struct_anon bool
	omit_empty bool
	reserved_word_with_underscore bool
mut:
	type_parser TypeParser
}
