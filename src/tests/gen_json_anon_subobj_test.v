module tests

import entities
import os
import contracts

pub fn test_replace_name_property() ! {
	mut obj_json := entities.ObjStruct{
		name: ''
		typ: .object | .root
		children: [
			entities.ObjStruct{
				name: 'my name'
				typ: .string
				value: 'André'
			},
			entities.ObjStruct{
				name: 'cars'
				typ: .array | .object
				children: [
					entities.ObjStruct{
						name: 'name'
						typ: .string
						value: 'Uno'
					},
					entities.ObjStruct{
						name: 'speed'
						typ: .number | .f32
						value: 'Uno'
					},
				]
			},
		]
	}

	struct_gen := obj_json.builder_struct(entities.Config{
		struct_anon: true
		omit_empty: false
		reserved_word_with_underscore: false
	})!

	script := $tmpl('templates/gen_json_anon_subobj.template')

	os.write_file('${@VMODROOT}/src/tests/scripts_gen/gen_json_anon_subobj_temp_test.v',
		script)!
}
