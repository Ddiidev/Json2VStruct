module tests

import entities.configuration { Config }
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
				name: 'nums'
				typ: .array | .number | .int
				children: [
					entities.ObjStruct{
						typ: .int
						value: 0
					},
				]
			},
		]
	}

	imports := 'import json'

	str_object := r'
	{
        "my name": "André",
		"nums": [0,1,2]
	}'

	line_code_method_parser := 'mut obj_analyzed := json.decode(Root, str_object)!'

	struct_gen := obj_json.builder_struct(Config{
		struct_anon: false
		omit_empty: false
		reserved_word_with_underscore: false
		type_parser: .json
	})!

	script := $tmpl('templates/gen_subobj.template')

	os.write_file('${@VMODROOT}/src/tests/scripts_gen/json_subobj_temp_test.v', script)!
}
