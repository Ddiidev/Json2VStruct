module tests

import entities.configuration { Config }
import entities
import os

pub fn test_simple_array() ! {
	mut obj_json := entities.ObjStruct{
		name: ''
		typ: .object | .root
		children: [
			entities.ObjStruct{
				name: 'childrens_str'
				typ: .array | .string
				children: [
					entities.ObjStruct{
						name: ''
						typ: .string
						value: 'Dante'
					},
					entities.ObjStruct{
						name: ''
						typ: .string
						value: 'André'
					},
					entities.ObjStruct{
						name: ''
						typ: .string
						value: 'Milca'
					},
				]
			},
			entities.ObjStruct{
				name: 'childrens_int'
				typ: .array | .number | .int
				children: [
					entities.ObjStruct{
						name: ''
						typ: .number
						value: 0
					},
					entities.ObjStruct{
						name: ''
						typ: .number
						value: 1
					},
					entities.ObjStruct{
						name: ''
						typ: .number
						value: 2
					},
				]
			},
			entities.ObjStruct{
				name: 'childrens_f32'
				typ: .array | .number | .f32
				children: [
					entities.ObjStruct{
						name: ''
						typ: .number
						value: 0
					},
					entities.ObjStruct{
						name: ''
						typ: .number
						value: 1
					},
					entities.ObjStruct{
						name: ''
						typ: .number
						value: 2
					},
				]
			},
			entities.ObjStruct{
				name: 'childrens_bool'
				typ: .array | .bool
				children: [
					entities.ObjStruct{
						name: ''
						typ: .bool
						value: true
					},
					entities.ObjStruct{
						name: ''
						typ: .bool
						value: false
					},
					entities.ObjStruct{
						name: ''
						typ: .bool
						value: true
					},
				]
			},
		]
	}

	imports := 'import toml'

	str_object := r'
	childrens_str = [ "André", "Milca", "Dante" ]
	childrens_int = [ 0, 1, 2 ]
	childrens_f32 = [ 0.1, 1.1, 2.1 ]
	childrens_bool = [ true, false, true ]
	'

	line_code_method_parser := 'mut obj_analyzed := toml.parse_text(str_object)!.reflect[Root]()'
	struct_gen := obj_json.builder_struct(Config{
		struct_anon: false
		omit_empty: false
		reserved_word_with_underscore: true
		type_parser: .toml
	})!

	script := $tmpl('templates/gen_simple_array.template')

	os.write_file('${@VMODROOT}/src/tests/scripts_gen/toml_simple_array_test.v', script)!
}
