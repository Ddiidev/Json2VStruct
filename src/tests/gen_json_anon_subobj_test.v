module tests

import entities.configuration { Config }
import os
import entities

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

	imports := 'import json'

	str_object := r'
	{
	    "my name": "André",
		"cars": [
		    {
	            "name": "Fiesta",
	            "speed": 3.3
	        },
	        {
	            "name": "Focus",
	            "speed": 5
	        }
		]
	}
	'

	line_code_method_parser := 'mut obj_analyzed := json.decode(Root, str_object)!'
	struct_gen := obj_json.builder_struct(Config{
		struct_anon: false
		omit_empty: false
		reserved_word_with_underscore: false
		type_parser: .json
	})!

	script := $tmpl('templates/gen_anon_subobj.template')

	os.write_file('${@VMODROOT}/src/tests/scripts_gen/json_anon_subobj_temp_test.v', script)!
}
