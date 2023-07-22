module tests

import entities.configuration { Config }
import entities
import os

pub fn test_simple_keys() ! {
	mut obj_struct := entities.ObjStruct{
		name: ''
		typ: .object | .root
		children: [
			entities.ObjStruct{
				name: 'name'
				typ: .string
				value: 'André'
			},
			entities.ObjStruct{
				name: 'age'
				typ: .number | .int
				value: 25
			},
			entities.ObjStruct{
				name: 'is_people'
				typ: .bool
				value: true
			},
			entities.ObjStruct{
				name: 'height'
				typ: .number | .f32
				value: 1.75
			},
		]
	}

	imports := 'import toml'

	str_object := r'
	name = "André"
	age = 25
	is_people = true
	height = 1.75
	'

	line_code_method_parser := 'mut obj_analyzed := toml.parse_text(str_object)!.reflect[Root]()'

	struct_gen := obj_struct.builder_struct(Config{
		struct_anon: false
		omit_empty: false
		reserved_word_with_underscore: true
		type_parser: .toml
	})!

	script := $tmpl('templates/gen_simple_keys_test.template')

	os.write_file('${@VMODROOT}/src/tests/scripts_gen/toml_simple_keys_temp_test.v', script)!
}
