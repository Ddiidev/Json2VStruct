module tests

import entities
import os

fn test_simple_keys() {
	mut obj_json := entities.ObjStruct{
		name: ''
		typ: .object | .root
		children: [
			entities.ObjStruct{
				name: 'name'
				typ: .string
				values: ['André']
			},
			entities.ObjStruct{
				name: 'age'
				typ: .number
				values: [25]
			},
			entities.ObjStruct{
				name: 'type'
				typ: .string
				values: ["is reservedword"]
			}
		]
	}

	struct_gen := obj_json.builder_struct(entities.Config{
		struct_anon: false
		omit_empty: false
		reserved_word_with_underscore: false
	})

	script := $tmpl('templates/gen_json_key_reservedword.template')

	os.write_file('${@VMODROOT}/src/tests/scripts_gen/gen_json_key_reservedword_test.v',
		script)!
}
