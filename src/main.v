module main

import entities
import parsers

// const str_simple_js = r'[1,2,3]'

const str_simple_js = r'
	{
		"name": "André",
		"age": 25,
		"is_people": true,
		"height": 1.75,
		"childrens": [
			{
				"name": "Dante",
				"age": 1.8,
				"is_people": true,
				"height": 0.9,
				"x": {"então":1}
			}
		],
		"childrens_number": [0,1,2]
	}
'

fn main() {
	str_struct := parsers.parser(.json, str_simple_js, entities.Config{
		struct_anon: true
		omit_empty: false
		reserved_word_with_underscore: true
	})!

	print(str_struct)
}
