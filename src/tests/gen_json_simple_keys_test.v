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
				name: 'is_people'
				typ: .boolean
				values: [true]
			},
			entities.ObjStruct{
				name: 'height'
				typ: .number
				values: [1.75]
			},
		]
	}

	struct_gen := obj_json.builder_struct()

	script := $tmpl('templates/gen_json_simple_keys_test.template')

	os.write_file('${@VMODROOT}/src/tests/scripts_gen/gen_json_simple_keys_temp_test.v',
		script)!
}
