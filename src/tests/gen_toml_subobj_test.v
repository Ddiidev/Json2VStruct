module tests

import entities.configuration { Config }
import entities
import os

pub fn test_replace_name_property() ! {
	mut obj_struct := entities.ObjStruct{
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

	imports := 'import toml'

	str_object := r'
		"my name" = "André"
		nums = [0,1,2]
	'

	line_code_method_parser := 'mut obj_analyzed := toml.parse_text(str_object)!.reflect[Root]()'

	struct_gen := obj_struct.builder_struct(Config{
		struct_anon: false
		omit_empty: false
		reserved_word_with_underscore: false
		type_parser: .toml
	})!

	script := $tmpl('templates/gen_subobj.template')

	os.write_file('${@VMODROOT}/src/tests/scripts_gen/toml_subobj_temp_test.v', script)!
}
