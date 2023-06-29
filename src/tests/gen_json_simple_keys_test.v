module tests

import entities
import os

pub fn test_simple_keys() ! {
	mut obj_json := entities.ObjStruct{
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

	struct_gen := obj_json.builder_struct(entities.Config{
		struct_anon: false
		omit_empty: false
		reserved_word_with_underscore: true
	})!

	script := $tmpl('../tests/templates/gen_json_simple_keys_test.template')

	os.write_file('${@VMODROOT}/src/tests/scripts_gen/json_simple_keys_temp_test.v', script)!
}
