module main

import entities

const str_simple_js = r'
	{
		"name": "André",
		"age": 25,
		"is_people": true,
		"height": 1.75
	}
'

fn main() {
	mut e := entities.ObjStruct{
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

	println(e.builder_struct())
}
