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
				name: 'my age'
				typ: .number | .int
				value: 25
			},
		]
	}

	imports := 'import toml'

	str_object := r'
	"my name" = "André"
	"my age" = 25
	'

	line_code_method_parser := 'mut obj_analyzed := toml.parse_text(str_object)!.reflect[Root]()'
	struct_gen := obj_json.builder_struct(Config{
		struct_anon: false
		omit_empty: false
		reserved_word_with_underscore: false
		type_parser: .toml
	})!

	script := $tmpl('templates/gen_replace_name_property.template')

	os.write_file('${@VMODROOT}/src/tests/scripts_gen/toml_replace_name_property_temp_test.v',
		script)!
}
