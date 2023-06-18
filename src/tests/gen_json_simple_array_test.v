module tests

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
						values: ['Dante']
					},
					entities.ObjStruct{
						name: ''
						typ: .string
						values: ['André']
					},
					entities.ObjStruct{
						name: ''
						typ: .string
						values: ['Milca']
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
						values: [0]
					},
					entities.ObjStruct{
						name: ''
						typ: .number
						values: [1]
					},
					entities.ObjStruct{
						name: ''
						typ: .number
						values: [2]
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
						values: [0]
					},
					entities.ObjStruct{
						name: ''
						typ: .number
						values: [1]
					},
					entities.ObjStruct{
						name: ''
						typ: .number
						values: [2]
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
						values: [true]
					},
					entities.ObjStruct{
						name: ''
						typ: .bool
						values: [false]
					},
					entities.ObjStruct{
						name: ''
						typ: .bool
						values: [true]
					},
				]
			},
		]
	}

	struct_gen := obj_json.builder_struct(entities.Config{
		struct_anon: true
		omit_empty: false
		reserved_word_with_underscore: true
	})

	script := $tmpl('templates/gen_json_simple_array.template')

	os.write_file('${@VMODROOT}/src/tests/scripts_gen/gen_json_simple_array_test.v', script)!
}
