module main

import entities

const str_simple_js = r'
	{
		"name": "André",
		"age": 25,
		"is_people": true,
		"height": 1.75,
		"childrens": [
			{
				"name": "Dante",
				"age": 1.8,
				"is_people": true,
				"height": 0.9,
			}
		]
	}
'

fn main() {
	mut e := entities.ObjStruct{
		name: ''
		typ: .object | .root
		children: [
			// entities.ObjStruct{
			// 	name: 'name'
			// 	typ: .string
			// 	values: ['André']
			// },
			// entities.ObjStruct{
			// 	name: 'age'
			// 	typ: .number
			// 	values: [25]
			// },
			// entities.ObjStruct{
			// 	name: 'is_people'
			// 	typ: .boolean
			// 	values: [true]
			// },
			// entities.ObjStruct{
			// 	name: 'type'
			// 	typ: .string
			// 	values: ['reserved keyword']
			// },
			// entities.ObjStruct{
			// 	name: 'height'
			// 	typ: .number
			// 	values: [1.75]
			// },
			// entities.ObjStruct{
			// 	name: 'teste subObj'
			// 	typ: .object
			// 	children: [entities.ObjStruct{
			// 		name: 'name'
			// 		typ: .string
			// 		values: ['André']
			// 	}, entities.ObjStruct{
			// 		name: 'age'
			// 		typ: .number
			// 		values: [25]
			// 	}]
			// },
			entities.ObjStruct{
				name: 'childrens'
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
				name: 'childrens_number'
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

	println(e.builder_struct(entities.Config{
		struct_anon: false
		omit_empty: false
		reserved_word_with_underscore: true
	}))
}
