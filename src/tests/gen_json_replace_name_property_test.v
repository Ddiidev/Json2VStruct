module tests

import entities
import os

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
				name: 'my age'
				typ: .number
				value: 25
			},
		]
	}

	struct_gen := obj_json.builder_struct(entities.Config{
		struct_anon: false
		omit_empty: false
		reserved_word_with_underscore: false
	})

	script := $tmpl('templates/gen_json_replace_name_property.template')

	os.write_file('${@VMODROOT}/src/tests/scripts_gen/gen_json_replace_name_property_temp_test.v',
		script)!
}
